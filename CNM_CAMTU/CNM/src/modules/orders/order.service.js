const inventoryService = require('../inventory/inventory.service');
const orderRepo = require('./order.repository');
const { pool } = require('../../config/database');

// ================= CREATE ORDER =================
exports.create = async ({
    customer_id,
    staff_id,
    create_by,
    shipping_address,
    payment_term_template_id,
    items
}) => {

    const conn = await pool.getConnection();

    try {
        await conn.beginTransaction();

        if (!payment_term_template_id) {
            throw new Error('Vui lòng chọn điều khoản thanh toán');
        }

        if (!items || !Array.isArray(items) || items.length === 0) {
            throw new Error('Đơn hàng phải có ít nhất một sản phẩm');
        }

        let total_amount = 0;
        const processedItems = [];

        // ================= BƯỚC 1: TÍNH TỔNG TIỀN =================
        for (let item of items) {
            const product = await orderRepo.getProductPrice(
                item.product_id,
                conn
            );

            if (!product) {
                throw new Error(`Sản phẩm ${item.product_id} không tồn tại`);
            }

            const price = Number(product.Price || 0);
            const quantity = Number(item.quantity || 0);

            if (quantity <= 0) {
                throw new Error('Số lượng sản phẩm phải lớn hơn 0');
            }

            total_amount += price * quantity;

            processedItems.push({
                product_id: item.product_id,
                quantity,
                price
            });
        }

        // ================= BƯỚC 2: KHÓA KHÁCH HÀNG ĐỂ KIỂM TRA CÔNG NỢ =================
        const customer = await orderRepo.getCustomerForUpdate(
            customer_id,
            conn
        );

        if (!customer) {
            throw new Error('Khách hàng không tồn tại');
        }

        const currentDebt = Number(customer.current_debt || 0);
        const creditLimit = Number(customer.credit_limit || 0);

        if (currentDebt + total_amount > creditLimit) {
            throw new Error(
                `Vượt hạn mức nợ! Còn lại: ${(creditLimit - currentDebt).toLocaleString()}đ`
            );
        }

        // ================= BƯỚC 3: LẤY ĐIỀU KHOẢN THANH TOÁN =================
        const paymentTerm = await orderRepo.getPaymentTermTemplateForUpdate(
            payment_term_template_id,
            conn
        );

        if (!paymentTerm) {
            throw new Error('Điều khoản thanh toán không tồn tại hoặc đã ngừng sử dụng');
        }

        // ================= BƯỚC 4: TẠO ĐƠN HÀNG =================
        const orderId = await orderRepo.createOrder(
            {
                customer_id,
                staff_id,
                create_by,
                total_amount,
                paid_amount: 0,
                remaining_amount: total_amount,
                payment_status: 'UNPAID',
                shipping_address
            },
            conn
        );

        // ================= BƯỚC 5: TẠO CHI TIẾT ĐƠN + GIỮ KHO =================
        for (let item of processedItems) {
            await orderRepo.createOrderDetail(orderId, item, conn);
            await inventoryService.reserveStockAuto(
                item.product_id,
                item.quantity,
                conn
            );
        }

        // ================= BƯỚC 6: COPY ĐIỀU KHOẢN SANG ĐƠN HÀNG =================
        const dueDate = await orderRepo.createOrderPaymentTerm({
            order_id: orderId,
            payment_term_template: paymentTerm
        }, conn);

        await orderRepo.updateOrderPaymentDueDate(orderId, dueDate, conn);

        // ================= BƯỚC 7: TĂNG CÔNG NỢ KHÁCH HÀNG =================
        const balanceAfter = currentDebt + total_amount;

        await orderRepo.updateCustomerDebt(
            customer_id,
            total_amount,
            conn
        );

        await orderRepo.createDebtLog({
            customer_id,
            order_id: orderId,
            type: 'INCREASE',
            reason: 'ORDER_CREATE',
            amount: total_amount,
            balance_after: balanceAfter,
            description: `Nợ phát sinh từ đơn hàng #${orderId}`
        }, conn);

        await conn.commit();

        return {
            success: true,
            message: 'Đơn hàng đã tạo thành công',
            order_id: orderId,
            total_amount,
            paid_amount: 0,
            remaining_amount: total_amount,
            payment_due_date: dueDate,
            payment_status: 'UNPAID'
        };

    } catch (err) {
        await conn.rollback();
        throw err;
    } finally {
        conn.release();
    }
};

// ================= LIST =================
exports.findAll = async () => {
    return await orderRepo.findAll();
};

// ================= DETAIL =================
exports.findById = async (id) => {
    return await orderRepo.findById(id);
};

// ================= CANCEL ORDER =================
exports.cancel = async (orderId) => {
    const conn = await pool.getConnection();

    try {
        await conn.beginTransaction();

        const order = await orderRepo.findById(orderId);
        if (!order) {
            throw new Error(`Đơn hàng #${orderId} không tồn tại`);
        }

        if (order.status === 'CANCELLED') {
            throw new Error(`Đơn hàng #${orderId} đã được hủy từ trước`);
        }

        if (order.payment_status === 'PAID' || Number(order.paid_amount || 0) > 0) {
            throw new Error('Không thể hủy đơn đã phát sinh thanh toán');
        }

        await conn.execute(
            `UPDATE orders SET status = 'CANCELLED', payment_status = 'CANCELLED', updated_at = NOW() WHERE order_id = ?`,
            [orderId]
        );

        const totalAmount = Number(order.total_amount || 0);
        const customer = await orderRepo.getCustomerForUpdate(order.customer_id, conn);
        const balanceAfter = Math.max(Number(customer.current_debt || 0) - totalAmount, 0);

        await orderRepo.updateCustomerDebt(
            order.customer_id,
            -totalAmount,
            conn
        );

        await orderRepo.createDebtLog({
            customer_id: order.customer_id,
            order_id: orderId,
            type: 'DECREASE',
            reason: 'CANCEL_ORDER',
            amount: totalAmount,
            balance_after: balanceAfter,
            description: `Giảm nợ do hủy đơn hàng #${orderId}`
        }, conn);

        await conn.commit();
        return { success: true, message: 'Hủy đơn hàng thành công' };

    } catch (err) {
        await conn.rollback();
        throw err;
    } finally {
        conn.release();
    }
};
