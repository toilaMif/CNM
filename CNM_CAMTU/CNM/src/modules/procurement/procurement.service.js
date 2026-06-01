const { pool } = require('../../config/database');

const procurementRepository = require('./procurement.repository');
const mailService = require('../mail/mail.service');

class ProcurementService {

    /* =========================================================
       SUPPLIER 
    ========================================================= */

    async getSuppliers() {
        return await procurementRepository.findAllSuppliers();
    }

    async createSupplier(payload, userId) {
        const supplierName = payload.supplier_name?.trim();

        if (!supplierName) {
            throw new Error('Tên nhà cung cấp không được để trống');
        }

        const supplierId = await procurementRepository.createSupplier({
            supplier_name: supplierName,
            contact_name: payload.contact_name?.trim() || null,
            phone_number: payload.phone_number?.trim() || null,
            email: payload.email?.trim() || null,
            address: payload.address?.trim() || null,
            tax_code: payload.tax_code?.trim() || null,
            status: payload.status || 'ACTIVE',
            created_by: userId,
            updated_by: userId
        });

        return await procurementRepository.findSupplierById(supplierId);
    }

    /* =========================================================
       PURCHASE ORDER - LIST
    ========================================================= */

    async getPurchaseOrders() {
        return await procurementRepository.findAllPurchaseOrders();
    }

    /* =========================================================
       PURCHASE ORDER - CREATE
    ========================================================= */
    async createPurchaseOrder(payload, userId) {
        const supplierId = Number(payload.supplier_id);
        const items = Array.isArray(payload.items) ? payload.items : [];

        if (!supplierId) {
            throw new Error('Vui lòng chọn nhà cung cấp');
        }

        if (!items.length) {
            throw new Error('Phiếu đặt hàng cần ít nhất 1 sản phẩm');
        }

        const supplier = await procurementRepository.findSupplierById(supplierId);

        if (!supplier) {
            throw new Error('Không tìm thấy nhà cung cấp');
        }

        if (supplier.status !== 'ACTIVE') {
            throw new Error('Nhà cung cấp đang không hoạt động');
        }

        const orderedStatus = await procurementRepository.findPurchaseOrderStatusByCode('ORDERED');

        if (!orderedStatus) {
            throw new Error('Thiếu trạng thái ORDERED trong purchase_order_statuses');
        }

        const normalizedItems = [];

        for (const item of items) {
            const productId = Number(item.product_id);
            const orderedQuantity = Number(item.ordered_quantity);
            const unitPrice = Number(item.unit_price || 0);

            if (!productId) {
                throw new Error('Sản phẩm không hợp lệ');
            }

            if (!orderedQuantity || orderedQuantity <= 0) {
                throw new Error('Số lượng đặt phải lớn hơn 0');
            }

            if (unitPrice < 0) {
                throw new Error('Giá nhập không hợp lệ');
            }

            const product = await procurementRepository.findProductById(productId);

            if (!product || Number(product.IsActive) !== 1) {
                throw new Error(`Sản phẩm ID ${productId} không tồn tại hoặc đã ngừng hoạt động`);
            }

            normalizedItems.push({
                product_id: productId,
                ordered_quantity: orderedQuantity,
                unit_price: unitPrice,
                note: item.note || null
            });
        }

        const totalAmount = normalizedItems.reduce((sum, item) => {
            return sum + item.ordered_quantity * item.unit_price;
        }, 0);

        const poCode = this.generatePOCode();

        const conn = await pool.getConnection();

        let purchaseOrderId;

        try {
            await conn.beginTransaction();

            purchaseOrderId = await procurementRepository.createPurchaseOrder(conn, {
                po_code: poCode,
                supplier_id: supplierId,
                created_by: userId,
                approved_by: null,
                updated_by: userId,
                status_id: orderedStatus.status_id,
                email_status: 'NOT_SENT',
                email_sent_at: null,
                expected_delivery_date: payload.expected_delivery_date || null,
                total_amount: totalAmount,
                note: payload.note?.trim() || null
            });

            for (const item of normalizedItems) {
                await procurementRepository.createPurchaseOrderDetail(conn, {
                    purchase_order_id: purchaseOrderId,
                    product_id: item.product_id,
                    ordered_quantity: item.ordered_quantity,
                    received_quantity: 0,
                    unit_price: item.unit_price,
                    note: item.note,
                    created_by: userId,
                    updated_by: userId
                });
            }

            await procurementRepository.createPurchaseOrderStatusLog(conn, {
                purchase_order_id: purchaseOrderId,
                old_status_id: null,
                new_status_id: orderedStatus.status_id,
                changed_by: userId,
                note: 'Product Manager tạo phiếu đặt hàng'
            });

            await conn.commit();

        } catch (err) {
            await conn.rollback();
            throw err;
        } finally {
            conn.release();
        }

        /* =========================================================
        Gửi email sau khi commit thành công
        ========================================================= */

        const purchaseOrder = await procurementRepository.findPurchaseOrderById(
            purchaseOrderId
        );

        const purchaseOrderDetails = await procurementRepository.findPurchaseOrderDetailsByPOId(
            purchaseOrderId
        );

        try {
            const supplierForMail = {
                supplier_id: supplier.supplier_id,
                supplier_name: supplier.supplier_name,
                email: supplier.email
            };

            await mailService.sendPurchaseOrderEmail({
                supplier: supplierForMail,
                purchaseOrder,
                items: purchaseOrderDetails
            });

            await procurementRepository.updatePurchaseOrderEmailStatus(
                purchaseOrderId,
                'SENT'
            );

            purchaseOrder.email_status = 'SENT';
            purchaseOrder.email_sent_at = new Date();

        } catch (mailErr) {
            console.error('SEND PURCHASE ORDER EMAIL ERROR:', mailErr.message);

            await procurementRepository.updatePurchaseOrderEmailStatus(
                purchaseOrderId,
                'FAILED'
            );

            purchaseOrder.email_status = 'FAILED';
        }

        return purchaseOrder;
    }

    generatePOCode() {
        const now = new Date();

        const y = now.getFullYear();
        const m = String(now.getMonth() + 1).padStart(2, '0');
        const d = String(now.getDate()).padStart(2, '0');

        const random = Math.floor(1000 + Math.random() * 9000);

        return `PO-${y}${m}${d}-${random}`;
    }


    /* =========================================================
   PURCHASE ORDER - PENDING RECEIVE LIST
   Warehouse dùng để xem danh sách PO đang chờ nhận hàng
========================================================= */
async getPendingReceivePurchaseOrders() {
    return await procurementRepository.findPendingReceivePurchaseOrders();
}


/* =========================================================
   PURCHASE ORDER - GET DETAIL
   Lấy chi tiết 1 PO gồm:
   - thông tin phiếu
   - nhà cung cấp
   - danh sách sản phẩm
   - số lượng còn phải nhận
========================================================= */
async getPurchaseOrderById(purchaseOrderId) {
    if (!purchaseOrderId || Number.isNaN(Number(purchaseOrderId))) {
        throw new Error('ID phiếu đặt hàng không hợp lệ');
    }

    const purchaseOrder = await procurementRepository.findPurchaseOrderHeaderById(
        purchaseOrderId
    );

    if (!purchaseOrder) {
        throw new Error('Không tìm thấy phiếu đặt hàng');
    }

    const items = await procurementRepository.findPurchaseOrderDetailsByPOId(
        purchaseOrderId
    );

    return {
        ...purchaseOrder,
        items
    };
}
}

module.exports = new ProcurementService();