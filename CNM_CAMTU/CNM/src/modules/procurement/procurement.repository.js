const { pool } = require('../../config/database');

class ProcurementRepository {

    /* =========================================================
       SUPPLIER - FIND ALL
    ========================================================= */
    async findAllSuppliers() {
        const [rows] = await pool.query(`
            SELECT
                supplier_id,
                supplier_name,
                contact_name,
                phone_number,
                email,
                address,
                tax_code,
                status,
                created_by,
                updated_by,
                created_at,
                updated_at
            FROM suppliers
            ORDER BY created_at DESC
        `);

        return rows;
    }

    /* =========================================================
       SUPPLIER - FIND BY ID
    ========================================================= */
    async findSupplierById(supplierId) {
        const [rows] = await pool.query(`
            SELECT
                supplier_id,
                supplier_name,
                contact_name,
                phone_number,
                email,
                address,
                tax_code,
                status,
                created_by,
                updated_by,
                created_at,
                updated_at
            FROM suppliers
            WHERE supplier_id = ?
            LIMIT 1
        `, [supplierId]);

        return rows[0] || null;
    }

    /* =========================================================
       SUPPLIER - FIND BY EMAIL
    ========================================================= */
    async findSupplierByEmail(email) {
        const [rows] = await pool.query(`
            SELECT
                supplier_id,
                supplier_name,
                email
            FROM suppliers
            WHERE email = ?
            LIMIT 1
        `, [email]);

        return rows[0] || null;
    }

    /* =========================================================
       SUPPLIER - FIND BY TAX CODE
    ========================================================= */
    async findSupplierByTaxCode(taxCode) {
        const [rows] = await pool.query(`
            SELECT
                supplier_id,
                supplier_name,
                tax_code
            FROM suppliers
            WHERE tax_code = ?
            LIMIT 1
        `, [taxCode]);

        return rows[0] || null;
    }

    /* =========================================================
       SUPPLIER - CREATE
    ========================================================= */
    async createSupplier(data) {
        const [result] = await pool.query(`
            INSERT INTO suppliers (
                supplier_name,
                contact_name,
                phone_number,
                email,
                address,
                tax_code,
                status,
                created_by,
                updated_by
            )
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
        `, [
            data.supplier_name,
            data.contact_name,
            data.phone_number,
            data.email,
            data.address,
            data.tax_code,
            data.status,
            data.created_by,
            data.updated_by
        ]);

        return result.insertId;
    }



    /* =========================================================
   PURCHASE ORDER - STATUS
========================================================= */

async findPurchaseOrderStatusByCode(statusCode) {
    const [rows] = await pool.query(`
        SELECT 
            status_id,
            status_code,
            status_name
        FROM purchase_order_statuses
        WHERE status_code = ?
        LIMIT 1
    `, [statusCode]);

    return rows[0] || null;
}

/* =========================================================
   PURCHASE ORDER - SUPPLIER
========================================================= */

async findSupplierById(supplierId) {
    const [rows] = await pool.query(`
        SELECT
            supplier_id,
            supplier_name,
            contact_name,
            phone_number,
            email,
            address,
            tax_code,
            status
        FROM suppliers
        WHERE supplier_id = ?
        LIMIT 1
    `, [supplierId]);

    return rows[0] || null;
}

/* =========================================================
   PURCHASE ORDER - PRODUCT
========================================================= */

async findProductById(productId) {
    const [rows] = await pool.query(`
        SELECT
            ProductID,
            ProductName,
            SKU,
            IsActive
        FROM products
        WHERE ProductID = ?
        LIMIT 1
    `, [productId]);

    return rows[0] || null;
}

/* =========================================================
   PURCHASE ORDER - LIST
========================================================= */

async findAllPurchaseOrders() {
    const [rows] = await pool.query(`
        SELECT
            po.purchase_order_id,
            po.po_code,
            po.supplier_id,
            s.supplier_name,

            po.created_by,
            po.approved_by,
            po.updated_by,

            po.status_id,
            pos.status_code AS status,
            pos.status_name,

            po.email_status,
            po.email_sent_at,

            po.expected_delivery_date,
            po.total_amount,
            po.note,
            po.created_at,
            po.updated_at

        FROM purchase_orders po

        INNER JOIN suppliers s
            ON po.supplier_id = s.supplier_id

        INNER JOIN purchase_order_statuses pos
            ON po.status_id = pos.status_id

        ORDER BY po.created_at DESC
    `);

    return rows;
}

/* =========================================================
   PURCHASE ORDER - CREATE HEADER
========================================================= */

async createPurchaseOrder(conn, data) {
    const [result] = await conn.query(`
        INSERT INTO purchase_orders (
            po_code,
            supplier_id,
            created_by,
            approved_by,
            updated_by,
            status_id,
            email_status,
            email_sent_at,
            expected_delivery_date,
            total_amount,
            note
        )
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `, [
        data.po_code,
        data.supplier_id,
        data.created_by,
        data.approved_by || null,
        data.updated_by || null,
        data.status_id,
        data.email_status || 'NOT_SENT',
        data.email_sent_at || null,
        data.expected_delivery_date || null,
        data.total_amount || 0,
        data.note || null
    ]);

    return result.insertId;
}

/* =========================================================
   PURCHASE ORDER - CREATE DETAIL
========================================================= */

async createPurchaseOrderDetail(conn, data) {
    const [result] = await conn.query(`
        INSERT INTO purchase_order_details (
            purchase_order_id,
            product_id,
            ordered_quantity,
            received_quantity,
            unit_price,
            note,
            created_by,
            updated_by
        )
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    `, [
        data.purchase_order_id,
        data.product_id,
        data.ordered_quantity,
        data.received_quantity || 0,
        data.unit_price,
        data.note || null,
        data.created_by || null,
        data.updated_by || null
    ]);

    return result.insertId;
}

/* =========================================================
   PURCHASE ORDER - STATUS LOG
========================================================= */

async createPurchaseOrderStatusLog(conn, data) {
    const [result] = await conn.query(`
        INSERT INTO purchase_order_status_logs (
            purchase_order_id,
            old_status_id,
            new_status_id,
            changed_by,
            note
        )
        VALUES (?, ?, ?, ?, ?)
    `, [
        data.purchase_order_id,
        data.old_status_id || null,
        data.new_status_id,
        data.changed_by || null,
        data.note || null
    ]);

    return result.insertId;
}

/* =========================================================
   PURCHASE ORDER - FIND BY ID
========================================================= */

    async findPurchaseOrderById(purchaseOrderId) {
        const [rows] = await pool.query(`
            SELECT
                po.purchase_order_id,
                po.po_code,
                po.supplier_id,
                s.supplier_name,
                s.email AS supplier_email,

                po.created_by,
                po.status_id,
                pos.status_code AS status,
                pos.status_name,

                po.email_status,
                po.email_sent_at,

                po.expected_delivery_date,
                po.total_amount,
                po.note,
                po.created_at,
                po.updated_at

            FROM purchase_orders po

            INNER JOIN suppliers s
                ON po.supplier_id = s.supplier_id

            INNER JOIN purchase_order_statuses pos
                ON po.status_id = pos.status_id

            WHERE po.purchase_order_id = ?
            LIMIT 1
        `, [purchaseOrderId]);

        return rows[0] || null;
    }


/* =========================================================
   PURCHASE ORDER - FIND DETAILS BY PO ID
   Lấy danh sách sản phẩm trong phiếu đặt hàng để gửi email
========================================================= */
    async findPurchaseOrderDetailsByPOId(purchaseOrderId) {
        const [rows] = await pool.query(`
            SELECT
                pod.purchase_order_detail_id,
                pod.purchase_order_id,
                pod.product_id,

                p.ProductName,
                p.SKU,

                pod.ordered_quantity,
                pod.received_quantity,
                pod.unit_price,
                pod.note

            FROM purchase_order_details pod

            INNER JOIN products p
                ON pod.product_id = p.ProductID

            WHERE pod.purchase_order_id = ?

            ORDER BY pod.purchase_order_detail_id ASC
        `, [purchaseOrderId]);

        return rows;
    }
/* =========================================================
   PURCHASE ORDER - UPDATE EMAIL STATUS
   Cập nhật trạng thái gửi email:
   - SENT
   - FAILED
   - NOT_SENT
========================================================= */
async updatePurchaseOrderEmailStatus(purchaseOrderId, emailStatus) {
    const emailSentAt = emailStatus === 'SENT' ? new Date() : null;

    const [result] = await pool.query(`
        UPDATE purchase_orders
        SET
            email_status = ?,
            email_sent_at = ?,
            updated_at = NOW()
        WHERE purchase_order_id = ?
    `, [
        emailStatus,
        emailSentAt,
        purchaseOrderId
    ]);

    return result.affectedRows > 0;
}

/* =========================================================
   PURCHASE ORDER - FIND BY ID
========================================================= */
async findPurchaseOrderById(purchaseOrderId) {
    const [rows] = await pool.query(`
        SELECT
            po.purchase_order_id,
            po.po_code,
            po.supplier_id,

            s.supplier_name,
            s.email AS supplier_email,

            po.created_by,
            po.approved_by,
            po.updated_by,

            po.status_id,
            pos.status_code AS status,
            pos.status_name,

            po.email_status,
            po.email_sent_at,

            po.expected_delivery_date,
            po.total_amount,
            po.note,
            po.created_at,
            po.updated_at

        FROM purchase_orders po

        INNER JOIN suppliers s
            ON po.supplier_id = s.supplier_id

        INNER JOIN purchase_order_statuses pos
            ON po.status_id = pos.status_id

        WHERE po.purchase_order_id = ?

        LIMIT 1
    `, [purchaseOrderId]);

    return rows[0] || null;
}

/* =========================================================
   PURCHASE ORDER - PENDING RECEIVE LIST
   Lấy danh sách PO đang chờ kho nhận hàng

   Dùng cho:
   GET /api/procurement/purchase-orders/pending-receive

   Trạng thái lấy:
   - ORDERED: đã đặt hàng
   - PARTIAL_RECEIVED: đã nhận một phần
========================================================= */
async findPendingReceivePurchaseOrders() {
    const [rows] = await pool.query(`
        SELECT
            po.purchase_order_id,
            po.po_code,

            po.supplier_id,
            s.supplier_name,
            s.email AS supplier_email,
            s.phone_number AS supplier_phone,

            po.status_id,
            pos.status_code AS status,
            pos.status_name,

            po.email_status,
            po.email_sent_at,

            po.expected_delivery_date,
            po.total_amount,
            po.note,

            po.created_by,
            po.created_at,
            po.updated_at

        FROM purchase_orders po

        INNER JOIN suppliers s
            ON po.supplier_id = s.supplier_id

        INNER JOIN purchase_order_statuses pos
            ON po.status_id = pos.status_id

        WHERE pos.status_code IN ('ORDERED', 'PARTIAL_RECEIVED')

        ORDER BY po.created_at DESC
    `);

    return rows;
}

/* =========================================================
   PURCHASE ORDER - FIND HEADER BY ID
========================================================= */
async findPurchaseOrderHeaderById(purchaseOrderId) {
    const [rows] = await pool.query(`
        SELECT
            po.purchase_order_id,
            po.po_code,

            po.supplier_id,
            s.supplier_name,
            s.contact_name,
            s.phone_number AS supplier_phone,
            s.email AS supplier_email,
            s.address AS supplier_address,

            po.created_by,
            creator.email AS created_by_email,

            po.status_id,
            pos.status_code AS status,
            pos.status_name,

            po.email_status,
            po.email_sent_at,

            po.expected_delivery_date,
            po.total_amount,
            po.note,

            po.created_at,
            po.updated_at

        FROM purchase_orders po

        INNER JOIN suppliers s
            ON po.supplier_id = s.supplier_id

        INNER JOIN purchase_order_statuses pos
            ON po.status_id = pos.status_id

        LEFT JOIN users creator
            ON po.created_by = creator.id

        WHERE po.purchase_order_id = ?

        LIMIT 1
    `, [purchaseOrderId]);

    return rows[0] || null;
}
/* =========================================================
   PURCHASE ORDER - FIND DETAILS BY PO ID
   Lấy chi tiết sản phẩm trong PO

   remaining_quantity:
   - Số lượng còn lại chưa nhận
========================================================= */
async findPurchaseOrderDetailsByPOId(purchaseOrderId) {
    const [rows] = await pool.query(`
        SELECT
            pod.purchase_order_detail_id,
            pod.purchase_order_id,
            pod.product_id,

            p.ProductName,
            p.SKU,

            pod.ordered_quantity,
            pod.received_quantity,

            (pod.ordered_quantity - pod.received_quantity) AS remaining_quantity,

            pod.unit_price,
            pod.note

        FROM purchase_order_details pod

        INNER JOIN products p
            ON pod.product_id = p.ProductID

        WHERE pod.purchase_order_id = ?

        ORDER BY pod.purchase_order_detail_id ASC
    `, [purchaseOrderId]);

    return rows;
}

}
module.exports = new ProcurementRepository();