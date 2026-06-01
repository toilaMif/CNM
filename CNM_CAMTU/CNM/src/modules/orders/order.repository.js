const { pool: db } = require('../../config/database');

class OrderRepository {

    // ================= CREATE ORDER =================
    async createOrder(orderData, connection) {
        const {
            customer_id,
            staff_id,
            create_by,
            total_amount,
            paid_amount = 0,
            remaining_amount = total_amount,
            payment_status = 'UNPAID',
            shipping_address
        } = orderData;

        const query = `
            INSERT INTO orders 
            (customer_id, staff_id, create_by, total_amount, paid_amount, remaining_amount, shipping_address, status, payment_status, created_at, updated_at)
            VALUES (?, ?, ?, ?, ?, ?, ?, 'PENDING', ?, NOW(), NOW())
        `;

        const params = [
            customer_id,
            staff_id,
            create_by,
            total_amount,
            paid_amount,
            remaining_amount,
            shipping_address,
            payment_status
        ];

        const [result] = await connection.execute(query, params);
        return result.insertId;
    }

    // ================= ORDER DETAIL =================
    async createOrderDetail(orderId, item, connection) {
        const query = `
            INSERT INTO order_details 
            (order_id, product_id, quantity, price)
            VALUES (?, ?, ?, ?)
        `;

        await connection.execute(query, [
            orderId,
            item.product_id,
            item.quantity,
            item.price
        ]);
    }

    // ================= PAYMENT TERM TEMPLATE =================
    async getPaymentTermTemplateForUpdate(paymentTermTemplateId, connection) {
        const [rows] = await connection.execute(
            `
            SELECT *
            FROM payment_term_templates
            WHERE payment_term_template_id = ?
              AND is_active = 1
            FOR UPDATE
            `,
            [paymentTermTemplateId]
        );

        return rows[0];
    }

    // ================= ORDER PAYMENT TERM =================
    async createOrderPaymentTerm({ order_id, payment_term_template }, connection) {
        const [dateRows] = await connection.execute(
            `SELECT DATE_ADD(CURDATE(), INTERVAL ? DAY) AS due_date`,
            [payment_term_template.credit_days]
        );

        const dueDate = dateRows[0].due_date;

        await connection.execute(
            `
            INSERT INTO order_payment_terms (
                order_id,
                payment_term_template_id,
                term_name,
                credit_days,
                early_commission_rate_per_day,
                late_interest_rate_per_day,
                order_date,
                due_date,
                created_at
            )
            VALUES (?, ?, ?, ?, ?, ?, CURDATE(), ?, NOW())
            `,
            [
                order_id,
                payment_term_template.payment_term_template_id,
                payment_term_template.term_name,
                payment_term_template.credit_days,
                payment_term_template.early_commission_rate_per_day,
                payment_term_template.late_interest_rate_per_day,
                dueDate
            ]
        );

        return dueDate;
    }

    async updateOrderPaymentDueDate(orderId, dueDate, connection) {
        await connection.execute(
            `
            UPDATE orders
            SET payment_due_date = ?, updated_at = NOW()
            WHERE order_id = ?
            `,
            [dueDate, orderId]
        );
    }

    // ================= UPDATE CUSTOMER DEBT =================
    async updateCustomerDebt(customerId, amount, connection) {
        const query = `
            UPDATE customers 
            SET current_debt = GREATEST(current_debt + ?, 0)
            WHERE customer_id = ?
        `;

        await connection.execute(query, [amount, customerId]);
    }

    // ================= GET ALL ORDERS =================
    async findAll() {
        const query = `
            SELECT 
                o.order_id,
                o.created_at,
                o.total_amount,
                o.paid_amount,
                o.remaining_amount,
                o.payment_due_date,
                o.fully_paid_at,
                o.early_payment_days,
                o.late_payment_days,
                o.early_commission_total,
                o.late_interest_total,
                o.status,
                o.payment_status,

                o.staff_id,
                u.email AS created_by_email,

                o.customer_id,
                c.company_name AS customer_name,

                opt.term_name,
                opt.credit_days,
                opt.due_date,

                COUNT(od.order_detail_id) AS total_items,
                SUM(od.quantity) AS total_quantity

            FROM orders o
            LEFT JOIN users u ON o.staff_id = u.id
            LEFT JOIN customers c ON o.customer_id = c.customer_id
            LEFT JOIN order_payment_terms opt ON o.order_id = opt.order_id
            LEFT JOIN order_details od ON o.order_id = od.order_id

            GROUP BY 
                o.order_id,
                o.created_at,
                o.total_amount,
                o.paid_amount,
                o.remaining_amount,
                o.payment_due_date,
                o.fully_paid_at,
                o.early_payment_days,
                o.late_payment_days,
                o.early_commission_total,
                o.late_interest_total,
                o.status,
                o.payment_status,
                o.staff_id,
                u.email,
                o.customer_id,
                c.company_name,
                opt.term_name,
                opt.credit_days,
                opt.due_date

            ORDER BY o.created_at DESC
        `;

        const [rows] = await db.query(query);
        return rows;
    }

    // ================= GET BY ID =================
    async findById(id) {
        const orderQuery = `
            SELECT 
                o.*,
                u.email AS created_by_email,
                c.company_name AS customer_name,
                opt.term_name,
                opt.credit_days,
                opt.early_commission_rate_per_day,
                opt.late_interest_rate_per_day,
                opt.due_date
            FROM orders o
            LEFT JOIN users u ON o.staff_id = u.id
            LEFT JOIN customers c ON o.customer_id = c.customer_id
            LEFT JOIN order_payment_terms opt ON o.order_id = opt.order_id
            WHERE o.order_id = ?
        `;

        const [orderRows] = await db.query(orderQuery, [id]);
        const order = orderRows[0];

        if (!order) return null;

        const itemsQuery = `
            SELECT 
                od.order_detail_id,
                od.product_id,
                p.ProductName,
                od.quantity,
                od.price,
                (od.quantity * od.price) AS subtotal
            FROM order_details od
            LEFT JOIN products p ON od.product_id = p.ProductID
            WHERE od.order_id = ?
        `;

        const [items] = await db.query(itemsQuery, [id]);

        const [installments] = await db.query(
            `
            SELECT 
                pi.*,
                pq.payment_qr_id,
                pq.transfer_content,
                pq.qr_image_url,
                pq.status AS qr_status
            FROM payment_installments pi
            LEFT JOIN payment_qr_codes pq
                ON pi.payment_installment_id = pq.payment_installment_id
            WHERE pi.order_id = ?
            ORDER BY pi.installment_no ASC
            `,
            [id]
        );

        const [commissions] = await db.query(
            `
            SELECT *
            FROM dealer_commissions
            WHERE order_id = ?
            ORDER BY created_at DESC
            `,
            [id]
        );

        return {
            ...order,
            items,
            installments,
            commissions
        };
    }

    // ================= GET PRODUCT PRICE =================
    async getProductPrice(productId, connection) {
        const [rows] = await connection.execute(
            `SELECT Price FROM products WHERE ProductID = ?`,
            [productId]
        );
        return rows[0];
    }

    // ================= GET CUSTOMER FOR UPDATE =================
    async getCustomerForUpdate(customerId, connection) {
        const [rows] = await connection.execute(
            `SELECT customer_id, current_debt, credit_limit
            FROM customers 
            WHERE customer_id = ? FOR UPDATE`,
            [customerId]
        );
        return rows[0];
    }

    // ================= INSERT DEBT LOG =================
    async createDebtLog(data, connection) {
        const [result] = await connection.execute(
            `
            INSERT INTO debt_logs 
            (customer_id, order_id, payment_id, type, reason, amount, balance_after, description, created_at)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW())
            `,
            [
                data.customer_id,
                data.order_id || null,
                data.payment_id || null,
                data.type || 'INCREASE',
                data.reason || null,
                data.amount,
                data.balance_after || null,
                data.description || null
            ]
        );
        return result.insertId;
    }

    async updateOrderStatus(orderId, connection) {
        await connection.execute(
            `UPDATE orders 
            SET status = 'SHIPPED', updated_at = NOW()
            WHERE order_id = ?`,
            [orderId]
        );
    }

    // ================= GET ORDER ITEMS FOR EXPORT =================
    async getOrderItems(orderId, connection) {
        const query = `
            SELECT 
                order_detail_id,
                product_id,
                quantity,
                price
            FROM order_details
            WHERE order_id = ?
        `;

        const client = connection || db;
        const [rows] = await client.execute(query, [orderId]);
        return rows;
    }
}

module.exports = new OrderRepository();
