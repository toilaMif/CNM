const { pool: db } = require('../../config/database');

class InventoryRepository {

    /* =========================================================
       INVENTORY REPOSITORY

       Vai trò:
       - Truy vấn tồn kho tổng hợp.
       - Truy vấn tồn kho chi tiết theo từng lô.
       - Xử lý giữ hàng / xuất kho theo FEFO.
       - Ghi log biến động kho.
       - Xử lý Goods Receipt / nhập kho thực tế từ PO.
       - Hỗ trợ ảnh hàng lỗi và trạng thái xử lý lỗi cho Product Manager.

       Kiến trúc nghiệp vụ:
       - Procurement tạo PO và gửi email đặt hàng cho nhà cung cấp.
       - Inventory tạo Goods Receipt và cập nhật tồn kho.
       - Warehouse tạo phiếu nhận hàng + upload ảnh lỗi.
       - Product Manager xem phiếu lỗi và gửi email phản hồi nhà cung cấp.
       - Supplier CRUD đã chuyển sang module procurement.
    ========================================================= */


    /* =========================================================
       1. INVENTORY SUMMARY
       Lấy tồn kho tổng hợp theo sản phẩm.
    ========================================================= */
    async findAll() {
        const query = `
            SELECT 
                p.ProductID,
                p.ProductName,

                COALESCE(SUM(i.Quantity), 0) AS TotalPhysicalQty,

                -- FIX: không dùng AvailableQuantity nữa
                COALESCE(SUM(i.Quantity - i.AllocatedQuantity), 0) AS TotalAvailableQty,

                COALESCE(SUM(i.AllocatedQuantity), 0) AS TotalAllocatedQty,

                COALESCE(MIN(i.MinStockLevel), 0) AS MinStockLevel,

                -- FIX: đổi tên đúng bản chất (nhiều kệ)
                COALESCE(
                    GROUP_CONCAT(DISTINCT i.LocationRack SEPARATOR ', '),
                    ''
                ) AS LocationRacks

            FROM products p
            LEFT JOIN inventory i 
                ON p.ProductID = i.ProductID

            GROUP BY p.ProductID, p.ProductName
        `;

        const [rows] = await db.query(query);
        return rows;
    }


    /* =========================================================
       2. INVENTORY DETAILS
       Lấy tồn kho chi tiết theo từng lô hàng.
    ========================================================= */
    async findDetails() {
        const query = `
            SELECT
                i.InventoryID,
                p.ProductID,

                p.ProductName,
                p.SKU,
                p.Price,
                p.IsActive,
                p.CategoryID,

                c.CategoryName,
                pu.Name AS UnitName,
                ps.Name AS StatusName,

                COALESCE(i.Quantity, 0) AS Quantity,
                COALESCE(i.AllocatedQuantity, 0) AS AllocatedQuantity,
                COALESCE(i.Quantity - i.AllocatedQuantity, 0) AS AvailableQuantity,
                COALESCE(i.MinStockLevel, 10) AS MinStockLevel,

                i.LocationRack,
                i.ExpiryDate,
                i.BatchNumber,
                i.ManufacturerBatch,
                i.UpdatedAt,

                CASE
                    WHEN i.InventoryID IS NULL THEN 0
                    ELSE 1
                END AS HasInventory

            FROM products p

            LEFT JOIN inventory i
                ON p.ProductID = i.ProductID

            LEFT JOIN category c
                ON p.CategoryID = c.CategoryID

            LEFT JOIN product_unit pu
                ON p.UnitID = pu.PUnitID

            LEFT JOIN product_status ps
                ON p.StatusID = ps.StatusID

            WHERE p.IsActive = 1

            ORDER BY
                p.ProductName ASC,
                i.ExpiryDate ASC,
                i.InventoryID ASC
        `;

        const [rows] = await db.query(query);
        return rows;
    }


    /* =========================================================
       3. INVENTORY DETAIL BY ID
       Lấy chi tiết một dòng tồn kho theo InventoryID.
    ========================================================= */
    async findById(inventoryId) {
        const query = `
            SELECT
                i.InventoryID,
                i.ProductID,

                p.ProductName,
                p.SKU,
                p.Price,
                p.IsActive,

                c.CategoryName,
                pu.Name AS UnitName,
                ps.Name AS StatusName,

                i.Quantity,
                i.AllocatedQuantity,
                (i.Quantity - i.AllocatedQuantity) AS AvailableQuantity,
                i.MinStockLevel,
                i.LocationRack,
                i.ExpiryDate,
                i.BatchNumber,
                i.ManufacturerBatch,
                i.UpdatedAt

            FROM inventory i

            INNER JOIN products p
                ON i.ProductID = p.ProductID

            LEFT JOIN category c
                ON p.CategoryID = c.CategoryID

            LEFT JOIN product_unit pu
                ON p.UnitID = pu.PUnitID

            LEFT JOIN product_status ps
                ON p.StatusID = ps.StatusID

            WHERE i.InventoryID = ?

            LIMIT 1
        `;

        const [rows] = await db.query(query, [inventoryId]);
        return rows[0] || null;
    }


    /* =========================================================
       4. FIND AVAILABLE BATCHES FEFO
       Tìm các lô còn hàng khả dụng theo FEFO.
    ========================================================= */
    async findAvailableBatchesFEFO(productId, connection) {
        const query = `
            SELECT * FROM inventory 
            WHERE ProductID = ? AND (Quantity - AllocatedQuantity) > 0
            ORDER BY 
                CASE WHEN ExpiryDate IS NULL THEN 1 ELSE 0 END,
                ExpiryDate ASC,
                InventoryID ASC
            FOR UPDATE
        `;
        const executor = connection || db;
        const [rows] = await executor.query(query, [productId]);
        return rows;
    }


    /* =========================================================
       5. UPDATE ALLOCATED QUANTITY
       Cập nhật số lượng treo / giữ hàng.
    ========================================================= */
    async updateAllocatedQty(inventoryId, changeQty, connection) {
        const query = `
            UPDATE inventory 
            SET AllocatedQuantity = AllocatedQuantity + ?, UpdatedAt = NOW() 
            WHERE InventoryID = ?`;
        const [result] = await connection.query(query, [changeQty, inventoryId]);
        return result.affectedRows > 0;
    }

    /* =========================================================
       6. CONFIRM PHYSICAL EXPORT BY ORDER
       Xác nhận xuất kho thực tế theo đơn hàng.
    ========================================================= */

    async confirmPhysicalExportByOrder(productId, totalQty, connection, userId, orderId) {
        let remaining = totalQty;

        // --- BƯỚC 1: ƯU TIÊN TRỪ TRÊN CÁC LÔ ĐÃ ĐƯỢC GIỮ HÀNG (ALLOCATED) ---
        const [allocatedBatches] = await connection.query(
            `SELECT InventoryID, Quantity, AllocatedQuantity 
             FROM inventory 
             WHERE ProductID = ? AND AllocatedQuantity > 0 
             ORDER BY 
                CASE WHEN ExpiryDate IS NULL THEN 1 ELSE 0 END,
                ExpiryDate ASC
             FOR UPDATE`,
            [productId]
        );

        for (const batch of allocatedBatches) {
            if (remaining <= 0) break;

            const take = Math.min(remaining, batch.AllocatedQuantity);

            await connection.query(
                `UPDATE inventory 
                 SET Quantity = Quantity - ?, 
                     AllocatedQuantity = AllocatedQuantity - ?, 
                     UpdatedAt = NOW() 
                 WHERE InventoryID = ?`,
                [take, take, batch.InventoryID]
            );

            await connection.query(
                `INSERT INTO inventory_logs (
                    InventoryID, LogType, ChangeQuantity, ReferenceID, PerformedBy, Note, CreatedAt
                ) VALUES (?, 'EXPORT', ?, ?, ?, ?, NOW())`,
                [batch.InventoryID, -take, orderId, userId, `Xuất kho thực tế (Trừ hàng giữ chỗ) cho đơn hàng #${orderId}`]
            );

            remaining -= take;
        }

        // --- BƯỚC 2: NẾU VẪN THIẾU HÀNG (DỮ LIỆU ALLOCATED BỊ LỆCH), QUÉT TIẾP QUA KHO THỰC TẾ ---
        if (remaining > 0) {
            const [availableBatches] = await connection.query(
                `SELECT InventoryID, Quantity, AllocatedQuantity, (Quantity - AllocatedQuantity) AS AvailableQty
                 FROM inventory 
                 WHERE ProductID = ? AND (Quantity - AllocatedQuantity) > 0
                 ORDER BY 
                    CASE WHEN ExpiryDate IS NULL THEN 1 ELSE 0 END,
                    ExpiryDate ASC
                 FOR UPDATE`,
                [productId]
            );

            for (const batch of availableBatches) {
                if (remaining <= 0) break;

                const take = Math.min(remaining, batch.AvailableQty);

                await connection.query(
                    `UPDATE inventory 
                     SET Quantity = Quantity - ?, 
                         UpdatedAt = NOW() 
                     WHERE InventoryID = ?`,
                    [take, batch.InventoryID]
                );

                await connection.query(
                    `INSERT INTO inventory_logs (
                        InventoryID, LogType, ChangeQuantity, ReferenceID, PerformedBy, Note, CreatedAt
                    ) VALUES (?, 'EXPORT', ?, ?, ?, ?, NOW())`,
                    [batch.InventoryID, -take, orderId, userId, `Xuất kho thực tế (Trừ trực tiếp tồn khả dụng) cho đơn hàng #${orderId}`]
                );

                remaining -= take;
            }
        }

        // Nếu remaining === 0 nghĩa là đã xuất đủ số lượng hàng theo yêu cầu đơn hàng
        return remaining === 0;
    }


    /* =========================================================
       7. UPDATE INVENTORY QUANTITY
       Cập nhật Quantity trực tiếp theo ProductID.

       Lưu ý:
       - Không nên dùng cho nghiệp vụ nhập/xuất theo lô.
       - Nhập kho theo PO dùng Goods Receipt.
    ========================================================= */
    async updateQuantity(productId, quantity) {
        const sql = `
            UPDATE inventory
            SET
                Quantity = ?,
                UpdatedAt = NOW()
            WHERE ProductID = ?
        `;

        await db.execute(sql, [
            quantity,
            productId
        ]);
    }



    /* =========================================================
       8. INVENTORY LOGS
       Ghi log biến động kho bằng object động.
    ========================================================= */
    async createLog(logData, connection) {
        const query = `INSERT INTO inventory_logs SET ?, CreatedAt = NOW()`; // FIX: CreatedAt
        const executor = connection || db;
        const [result] = await executor.query(query, logData);
        return result.insertId;
    }


    /* =========================================================
       9. CREATE INVENTORY LOG EXPLICIT
       Ghi log bằng field rõ ràng.
    ========================================================= */
    async createInventoryLog(data, connection = null) {
        const executor = connection || db;

        const query = `
            INSERT INTO inventory_logs (
                InventoryID,
                ChangeQuantity,
                LogType,
                ReferenceID,
                PerformedBy,
                Note,
                CreatedAt
            )
            VALUES (?, ?, ?, ?, ?, ?, NOW())
        `;

        const params = [
            data.InventoryID,
            data.ChangeQuantity,
            data.LogType,
            data.ReferenceID || null,
            data.PerformedBy || null,
            data.Note || null
        ];

        const [result] = await executor.query(query, params);
        return result.insertId;
    }


    /* =========================================================
       10. SUPPLIER - FIND BY ID
       Inventory chỉ đọc thông tin supplier khi cần.
    ========================================================= */
    async findSupplierById(supplierId) {
        const sql = `
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
        `;

        const [rows] = await db.execute(sql, [supplierId]);
        return rows[0] || null;
    }


    /* =========================================================
       12. SUPPLIERS - LIST
       Lấy danh sách nhà cung cấp

       Dùng cho:
       GET /api/inventory/suppliers
    ========================================================= */

    async findAllSuppliers() {
        const sql = `
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
        `;

        const [rows] = await db.execute(sql);
        return rows;
    }

    /* =========================================================
       11. PRODUCT LOTS BY PRODUCT
       Lấy danh sách lô tồn kho theo sản phẩm.
    ========================================================= */
    async findLotsByProduct(productId) {
        const query = `
            SELECT 
                InventoryID,
                ProductID,
                Quantity,
                AllocatedQuantity,
                (Quantity - AllocatedQuantity) AS AvailableQty,
                LocationRack,
                BatchNumber,
                ExpiryDate,

                -- FIX: thêm trạng thái hạn sử dụng (rất hữu ích cho FE)
                CASE 
                    WHEN ExpiryDate IS NULL THEN 'NO_EXPIRY'
                    WHEN ExpiryDate < CURDATE() THEN 'EXPIRED'
                    WHEN ExpiryDate < DATE_ADD(CURDATE(), INTERVAL 7 DAY) THEN 'WARNING'
                    ELSE 'OK'
                END AS ExpiryStatus,

                UpdatedAt
            FROM inventory
            WHERE ProductID = ?
            ORDER BY 
                CASE WHEN ExpiryDate IS NULL THEN 1 ELSE 0 END,
                ExpiryDate ASC
        `;

        const [rows] = await db.query(query, [productId]);
        return rows;
    }


    /* =========================================================
       12. GOODS RECEIPT - FIND PURCHASE ORDER FOR RECEIVING
       Lấy thông tin cơ bản của PO trước khi nhập kho.
    ========================================================= */
    async findPurchaseOrderForReceiving(conn, purchaseOrderId) {
        const [rows] = await conn.query(`
            SELECT
                po.purchase_order_id,
                po.po_code,
                po.supplier_id,
                po.status_id,
                pos.status_code AS status
            FROM purchase_orders po

            INNER JOIN purchase_order_statuses pos
                ON po.status_id = pos.status_id

            WHERE po.purchase_order_id = ?

            LIMIT 1
        `, [purchaseOrderId]);

        return rows[0] || null;
    }


    /* =========================================================
       13. GOODS RECEIPT - FIND PURCHASE ORDER DETAIL
       Lấy chi tiết một dòng sản phẩm trong PO.
    ========================================================= */
    async findPurchaseOrderDetailForReceiving(conn, purchaseOrderDetailId) {
        const [rows] = await conn.query(`
            SELECT
                pod.purchase_order_detail_id,
                pod.purchase_order_id,
                pod.product_id,
                pod.ordered_quantity,
                pod.received_quantity,
                pod.unit_price,

                p.ProductName,
                p.SKU

            FROM purchase_order_details pod

            INNER JOIN products p
                ON pod.product_id = p.ProductID

            WHERE pod.purchase_order_detail_id = ?

            LIMIT 1
        `, [purchaseOrderDetailId]);

        return rows[0] || null;
    }


    /* =========================================================
       14. GOODS RECEIPT - CREATE HEADER
       Tạo phiếu nhận hàng chính.

       issue_status:
       - NONE: không có hàng lỗi
       - WAITING_REVIEW: có hàng lỗi, chờ Product Manager xử lý
       - EMAIL_SENT: Product Manager đã gửi email NCC
       - RESOLVED: đã xử lý xong
    ========================================================= */
    async createGoodsReceipt(conn, data) {
        const [result] = await conn.query(`
            INSERT INTO goods_receipts (
                receipt_code,
                purchase_order_id,
                supplier_id,
                received_by,
                created_by,
                updated_by,
                status,
                has_rejected_items,
                issue_status,
                received_date,
                note
            )
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), ?)
        `, [
            data.receipt_code,
            data.purchase_order_id,
            data.supplier_id,
            data.received_by,
            data.created_by,
            data.updated_by || data.created_by,
            data.status || 'COMPLETED',
            data.has_rejected_items || 0,
            data.issue_status || 'NONE',
            data.note || null
        ]);

        return result.insertId;
    }


    /* =========================================================
       15. GOODS RECEIPT - CREATE DETAIL
       Tạo chi tiết phiếu nhận hàng.

       Lưu ý:
       - Hàng lỗi dùng faulty_quantity.
       - Lý do lỗi lưu vào note.
       - accepted_quantity không lưu trực tiếp, khi cần thì tính:
         accepted = received_quantity - faulty_quantity.
       - fault_images lưu dạng JSON array trong cùng dòng detail.
    ========================================================= */
    async createGoodsReceiptDetail(conn, data) {
        const [result] = await conn.query(`
            INSERT INTO goods_receipt_details (
                receipt_id,
                purchase_order_detail_id,
                product_id,

                received_quantity,
                faulty_quantity,
                missing_quantity,

                unit_price,
                manufacture_date,
                expiry_date,
                batch_number,
                manufacturer_batch,
                location_rack,
                note,
                fault_images,

                created_by,
                updated_by
            )
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        `, [
            data.receipt_id,
            data.purchase_order_detail_id,
            data.product_id,

            data.received_quantity,
            data.faulty_quantity || 0,
            data.missing_quantity || 0,

            data.unit_price || 0,
            data.manufacture_date || null,
            data.expiry_date || null,
            data.batch_number,
            data.manufacturer_batch || null,
            data.location_rack || null,
            data.note || null,
            JSON.stringify(data.fault_images || []),

            data.created_by || null,
            data.updated_by || data.created_by || null
        ]);

        return result.insertId;
    }


    /* =========================================================
       16. INVENTORY - FIND BATCH
    ========================================================= */
    async findInventoryBatch(conn, productId, batchNumber) {
        const [rows] = await conn.query(`
            SELECT
                InventoryID,
                ProductID,
                BatchNumber,
                Quantity,
                AllocatedQuantity,
                AvailableQuantity
            FROM inventory
            WHERE ProductID = ?
              AND BatchNumber = ?
            LIMIT 1
        `, [
            productId,
            batchNumber
        ]);

        return rows[0] || null;
    }


    /* =========================================================
       17. INVENTORY - CREATE BATCH
       Tạo dòng tồn kho mới.
    ========================================================= */
    async createInventoryBatch(conn, data) {
        const [result] = await conn.query(`
            INSERT INTO inventory (
                ProductID,
                Quantity,
                AllocatedQuantity,
                MinStockLevel,
                LocationRack,
                ExpiryDate,
                BatchNumber,
                ManufacturerBatch
            )
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        `, [
            data.product_id,
            data.quantity,
            0,
            data.min_stock_level || 10,
            data.location_rack || null,
            data.expiry_date || null,
            data.batch_number,
            data.manufacturer_batch || null
        ]);

        return result.insertId;
    }


    /* =========================================================
       18. INVENTORY - INCREASE BATCH QUANTITY
       Cộng thêm số lượng vào lô đã tồn tại.
    ========================================================= */
    async increaseInventoryBatch(conn, inventoryId, quantity) {
        const [result] = await conn.query(`
            UPDATE inventory
            SET
                Quantity = Quantity + ?,
                UpdatedAt = NOW()
            WHERE InventoryID = ?
        `, [
            quantity,
            inventoryId
        ]);

        return result.affectedRows > 0;
    }


    /* =========================================================
       19. PURCHASE ORDER DETAIL - UPDATE RECEIVED
    ========================================================= */
    async increasePurchaseOrderDetailReceived(conn, purchaseOrderDetailId, quantity) {
        const [result] = await conn.query(`
            UPDATE purchase_order_details
            SET
                received_quantity = received_quantity + ?,
                updated_at = NOW()
            WHERE purchase_order_detail_id = ?
        `, [
            quantity,
            purchaseOrderDetailId
        ]);

        return result.affectedRows > 0;
    }


    /* =========================================================
       20. PURCHASE ORDER - RECEIVE SUMMARY
    ========================================================= */
    async getPurchaseOrderReceiveSummary(conn, purchaseOrderId) {
        const [rows] = await conn.query(`
            SELECT
                SUM(ordered_quantity) AS total_ordered,
                SUM(received_quantity) AS total_received
            FROM purchase_order_details
            WHERE purchase_order_id = ?
        `, [purchaseOrderId]);

        return rows[0] || {
            total_ordered: 0,
            total_received: 0
        };
    }


    /* =========================================================
       21. PURCHASE ORDER STATUS - FIND BY CODE
    ========================================================= */
    async findPurchaseOrderStatusByCode(conn, statusCode) {
        const [rows] = await conn.query(`
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
       22. PURCHASE ORDER - UPDATE STATUS
    ========================================================= */
    async updatePurchaseOrderStatus(conn, purchaseOrderId, statusId) {
        const [result] = await conn.query(`
            UPDATE purchase_orders
            SET
                status_id = ?,
                updated_at = NOW()
            WHERE purchase_order_id = ?
        `, [
            statusId,
            purchaseOrderId
        ]);

        return result.affectedRows > 0;
    }


    /* =========================================================
       23. PURCHASE ORDER STATUS LOG - CREATE
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
       24. GOODS RECEIPT - FIND LIST
       Lấy danh sách phiếu nhận hàng.

       Filter hỗ trợ:
       - has_rejected_items
       - issue_status
    ========================================================= */
    async findGoodsReceipts(filters = {}) {
        const params = [];
        let where = `WHERE 1 = 1`;

        if (filters.has_rejected_items !== undefined) {
            where += ` AND gr.has_rejected_items = ?`;
            params.push(Number(filters.has_rejected_items));
        }

        if (filters.issue_status) {
            where += ` AND gr.issue_status = ?`;
            params.push(filters.issue_status);
        }

        const [rows] = await db.query(`
            SELECT
                gr.receipt_id AS goods_receipt_id,
                gr.receipt_id,
                gr.receipt_code,
                gr.purchase_order_id,
                po.po_code,

                gr.supplier_id,
                s.supplier_name,
                s.email AS supplier_email,

                gr.received_by,
                u.email AS received_by_email,

                gr.status,
                gr.has_rejected_items,
                gr.issue_status,
                gr.issue_email_sent_at,
                gr.issue_email_sent_by,
                sender.email AS issue_email_sent_by_email,

                gr.note,
                gr.received_date,
                gr.created_at,

                COALESCE(SUM(grd.received_quantity), 0) AS total_received_quantity,
                COALESCE(SUM(grd.received_quantity - grd.faulty_quantity), 0) AS total_accepted_quantity,
                COALESCE(SUM(grd.faulty_quantity), 0) AS total_rejected_quantity

            FROM goods_receipts gr

            LEFT JOIN purchase_orders po
                ON gr.purchase_order_id = po.purchase_order_id

            INNER JOIN suppliers s
                ON gr.supplier_id = s.supplier_id

            LEFT JOIN users u
                ON gr.received_by = u.id

            LEFT JOIN users sender
                ON gr.issue_email_sent_by = sender.id

            LEFT JOIN goods_receipt_details grd
                ON gr.receipt_id = grd.receipt_id

            ${where}

            GROUP BY gr.receipt_id

            ORDER BY gr.created_at DESC
        `, params);

        return rows;
    }


    /* =========================================================
       25. GOODS RECEIPT - FIND HEADER BY ID
       Lấy header phiếu nhận hàng, bao gồm email NCC.
    ========================================================= */
    async findGoodsReceiptById(goodsReceiptId) {
        const [rows] = await db.query(`
            SELECT
                gr.receipt_id AS goods_receipt_id,
                gr.receipt_id,
                gr.receipt_code,
                gr.purchase_order_id,
                po.po_code,

                gr.supplier_id,
                s.supplier_name,
                s.email AS supplier_email,

                gr.received_by,
                u.email AS received_by_email,

                gr.status,
                gr.has_rejected_items,
                gr.issue_status,
                gr.issue_email_sent_at,
                gr.issue_email_sent_by,
                sender.email AS issue_email_sent_by_email,

                gr.note,
                gr.received_date,
                gr.created_at

            FROM goods_receipts gr

            LEFT JOIN purchase_orders po
                ON gr.purchase_order_id = po.purchase_order_id

            INNER JOIN suppliers s
                ON gr.supplier_id = s.supplier_id

            LEFT JOIN users u
                ON gr.received_by = u.id

            LEFT JOIN users sender
                ON gr.issue_email_sent_by = sender.id

            WHERE gr.receipt_id = ?

            LIMIT 1
        `, [goodsReceiptId]);

        return rows[0] || null;
    }


    /* =========================================================
       26. GOODS RECEIPT - FIND DETAILS BY ID
       Lấy chi tiết phiếu nhận hàng, parse fault_images.
    ========================================================= */
    async findGoodsReceiptDetails(goodsReceiptId) {
        const [rows] = await db.query(`
            SELECT
                grd.receipt_detail_id AS goods_receipt_detail_id,
                grd.receipt_detail_id,
                grd.receipt_id AS goods_receipt_id,
                grd.receipt_id,
                grd.purchase_order_detail_id,
                grd.product_id,

                p.ProductName,
                p.SKU,

                grd.received_quantity,
                (grd.received_quantity - grd.faulty_quantity) AS accepted_quantity,
                grd.faulty_quantity AS rejected_quantity,
                grd.note AS reject_reason,

                grd.missing_quantity,
                grd.batch_number,
                grd.manufacturer_batch,
                grd.manufacture_date,
                grd.expiry_date,
                grd.location_rack,
                grd.unit_price,
                grd.fault_images

            FROM goods_receipt_details grd

            INNER JOIN products p
                ON grd.product_id = p.ProductID

            WHERE grd.receipt_id = ?

            ORDER BY grd.receipt_detail_id ASC
        `, [goodsReceiptId]);

        return rows.map(row => {
            let faultImages = [];

            try {
                if (Array.isArray(row.fault_images)) {
                    faultImages = row.fault_images;
                } else if (typeof row.fault_images === 'string' && row.fault_images.trim()) {
                    faultImages = JSON.parse(row.fault_images);
                } else {
                    faultImages = [];
                }
            } catch (err) {
                faultImages = [];
            }

            return {
                ...row,
                fault_images: faultImages
            };
        });
    }


    /* =========================================================
       27. GOODS RECEIPT - MARK ISSUE EMAIL SENT
       Product Manager gửi email NCC thành công thì cập nhật phiếu.
    ========================================================= */
    async markGoodsReceiptIssueEmailSent(conn, receiptId, userId) {
        const [result] = await conn.query(`
            UPDATE goods_receipts
            SET
                issue_status = 'EMAIL_SENT',
                issue_email_sent_at = NOW(),
                issue_email_sent_by = ?,
                updated_by = ?,
                updated_at = NOW()
            WHERE receipt_id = ?
        `, [
            userId,
            userId,
            receiptId
        ]);

        return result.affectedRows > 0;
    }


    /* =========================================================
       28. GOODS RECEIPT - MARK ISSUE RESOLVED
       Nếu sau này Product Manager xác nhận NCC đã xử lý xong.
    ========================================================= */
    async markGoodsReceiptIssueResolved(conn, receiptId, userId) {
        const [result] = await conn.query(`
            UPDATE goods_receipts
            SET
                issue_status = 'RESOLVED',
                updated_by = ?,
                updated_at = NOW()
            WHERE receipt_id = ?
        `, [
            userId,
            receiptId
        ]);

        return result.affectedRows > 0;
    }


    /* =========================================================
       29. GOODS RECEIPT SUPPLIER EMAIL - CREATE LOG
       Lưu lịch sử email phản hồi hàng lỗi cho NCC.
    ========================================================= */
    async createGoodsReceiptSupplierEmailLog(conn, data) {
        const [result] = await conn.query(`
            INSERT INTO goods_receipt_supplier_emails (
                receipt_id,
                supplier_id,
                sent_to,
                subject,
                content,
                status,
                error_message,
                sent_by
            )
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        `, [
            data.receipt_id,
            data.supplier_id,
            data.sent_to,
            data.subject,
            data.content || null,
            data.status || 'SENT',
            data.error_message || null,
            data.sent_by || null
        ]);

        return result.insertId;
    }
     /* =========================================================
       STOCKTAKE - INVENTORY ITEMS
       Lấy danh sách tồn kho/lô hàng để tạo phiếu kiểm kê.

       Chuẩn hóa:
       - DB dùng PascalCase: InventoryID, ProductID, ProductName...
       - JS/Frontend dùng snake_case: inventory_id, product_name...
    ========================================================= */
async getStocktakeInventoryItems(filters = {}) {
    const conditions = [
        'p.IsActive = 1',
        'i.InventoryID IS NOT NULL'
    ];

    const params = [];

    if (filters.categoryId) {
        conditions.push('p.CategoryID = ?');
        params.push(filters.categoryId);
    }

    if (filters.categoryName) {
        conditions.push(`
            c.CategoryName COLLATE utf8mb4_unicode_ci 
            LIKE ? COLLATE utf8mb4_unicode_ci
        `);
        params.push(`%${filters.categoryName}%`);
    }

    if (filters.sku) {
        conditions.push(`
            p.SKU COLLATE utf8mb4_unicode_ci 
            LIKE ? COLLATE utf8mb4_unicode_ci
        `);
        params.push(`%${filters.sku}%`);
    }

    if (filters.keyword) {
        conditions.push(`
            p.ProductName COLLATE utf8mb4_unicode_ci 
            LIKE ? COLLATE utf8mb4_unicode_ci
        `);
        params.push(`%${filters.keyword}%`);
    }

    const [rows] = await db.query(`
        SELECT
            i.InventoryID AS inventory_id,
            i.ProductID AS product_id,

            p.ProductName AS product_name,
            p.SKU AS sku,

            c.CategoryID AS category_id,
            c.CategoryName AS category_name,

            pu.Name AS unit_name,

            COALESCE(i.Quantity, 0) AS system_quantity,
            COALESCE(i.AllocatedQuantity, 0) AS allocated_quantity,
            COALESCE(
                i.AvailableQuantity,
                i.Quantity - i.AllocatedQuantity,
                i.Quantity,
                0
            ) AS available_quantity,

            i.BatchNumber AS batch_number,
            i.ManufacturerBatch AS manufacturer_batch,
            i.ExpiryDate AS expiry_date,
            i.LocationRack AS location_rack,

            COALESCE(MAX(grd.created_at), i.UpdatedAt) AS import_date,
            i.UpdatedAt AS updated_at

        FROM inventory i

        INNER JOIN products p
            ON p.ProductID = i.ProductID

        LEFT JOIN category c
            ON c.CategoryID = p.CategoryID

        LEFT JOIN product_unit pu
            ON pu.PUnitID = p.UnitID

        LEFT JOIN goods_receipt_details grd
            ON grd.product_id = i.ProductID

            AND (
                grd.batch_number IS NULL
                OR i.BatchNumber IS NULL
                OR grd.batch_number COLLATE utf8mb4_unicode_ci =
                   i.BatchNumber COLLATE utf8mb4_unicode_ci
            )

            AND (
                grd.manufacturer_batch IS NULL
                OR i.ManufacturerBatch IS NULL
                OR grd.manufacturer_batch COLLATE utf8mb4_unicode_ci =
                   i.ManufacturerBatch COLLATE utf8mb4_unicode_ci
            )

            AND (
                grd.location_rack IS NULL
                OR i.LocationRack IS NULL
                OR grd.location_rack COLLATE utf8mb4_unicode_ci =
                   i.LocationRack COLLATE utf8mb4_unicode_ci
            )

        WHERE ${conditions.join(' AND ')}

        GROUP BY
            i.InventoryID,
            i.ProductID,
            p.ProductName,
            p.SKU,
            c.CategoryID,
            c.CategoryName,
            pu.Name,
            i.Quantity,
            i.AllocatedQuantity,
            i.AvailableQuantity,
            i.BatchNumber,
            i.ManufacturerBatch,
            i.ExpiryDate,
            i.LocationRack,
            i.UpdatedAt

        ORDER BY
            p.ProductName ASC,
            import_date DESC,
            i.InventoryID DESC
    `, params);

    return rows;
}

    /* =========================================================
       STOCKTAKE - CREATE HEADER
       Tạo phiếu kiểm kê.
    ========================================================= */
    async createStocktake(conn, data) {
        const [result] = await conn.query(`
            INSERT INTO inventory_stocktakes (
                stocktake_code,
                stocktake_date,
                warehouse_area,
                note,
                status,
                created_by,
                submitted_at
            )
            VALUES (?, ?, ?, ?, ?, ?, ?)
        `, [
            data.stocktake_code,
            data.stocktake_date,
            data.warehouse_area || null,
            data.note || null,
            data.status || 'draft',
            data.created_by || null,
            data.status === 'pending' ? new Date() : null
        ]);

        return result.insertId;
    }


    /* =========================================================
       STOCKTAKE - CREATE DETAIL
       Tạo chi tiết vật tư kiểm kê.
    ========================================================= */
    async createStocktakeDetail(conn, data) {
        const [result] = await conn.query(`
            INSERT INTO inventory_stocktake_details (
                stocktake_id,
                inventory_id,
                product_id,
                system_quantity,
                actual_quantity,
                difference_quantity,
                item_condition,
                loss_reason,
                image_url,
                note
            )
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        `, [
            data.stocktake_id,
            data.inventory_id,
            data.product_id,
            data.system_quantity,
            data.actual_quantity,
            data.difference_quantity,
            data.item_condition || null,
            data.loss_reason || null,
            data.image_url || null,
            data.note || null
        ]);

        return result.insertId;
    }


    /* =========================================================
       STOCKTAKE - LIST
       Danh sách phiếu kiểm kê.

       Sửa lỗi cũ:
       - Không dùng users.UserID.
       - Không dùng users.FullName.
       - Join users.id -> profiles.user_id.
       - Lấy tên từ profiles.full_name.
    ========================================================= */
    async findStocktakes(filters = {}) {
        const conditions = ['1 = 1'];
        const params = [];

        if (filters.status) {
            conditions.push('st.status = ?');
            params.push(filters.status);
        }

        if (filters.fromDate) {
            conditions.push('st.stocktake_date >= ?');
            params.push(filters.fromDate);
        }

        if (filters.toDate) {
            conditions.push('st.stocktake_date <= ?');
            params.push(filters.toDate);
        }

        if (filters.keyword) {
            conditions.push(`
                (
                    st.stocktake_code LIKE ?
                    OR st.warehouse_area LIKE ?
                    OR creator_profile.full_name LIKE ?
                    OR creator.email LIKE ?
                )
            `);

            params.push(
                `%${filters.keyword}%`,
                `%${filters.keyword}%`,
                `%${filters.keyword}%`,
                `%${filters.keyword}%`
            );
        }

        const [rows] = await db.query(`
            SELECT
                st.stocktake_id,
                st.stocktake_code,
                st.stocktake_date,
                st.warehouse_area,
                st.note,
                st.status,

                st.created_by,
                COALESCE(
                    creator_profile.full_name,
                    creator.email,
                    CONCAT('User #', st.created_by)
                ) AS created_by_name,

                st.submitted_at,

                st.approved_by,
                COALESCE(
                    approver_profile.full_name,
                    approver.email,
                    CONCAT('User #', st.approved_by)
                ) AS approved_by_name,
                st.approved_at,

                st.rejected_by,
                COALESCE(
                    rejecter_profile.full_name,
                    rejecter.email,
                    CONCAT('User #', st.rejected_by)
                ) AS rejected_by_name,
                st.rejected_at,
                st.reject_reason,

                st.created_at,
                st.updated_at,

                COUNT(std.stocktake_detail_id) AS total_items,
                COALESCE(SUM(ABS(std.difference_quantity)), 0) AS total_difference_abs

            FROM inventory_stocktakes st

            LEFT JOIN users creator
                ON creator.id = st.created_by

            LEFT JOIN profiles creator_profile
                ON creator_profile.user_id = creator.id

            LEFT JOIN users approver
                ON approver.id = st.approved_by

            LEFT JOIN profiles approver_profile
                ON approver_profile.user_id = approver.id

            LEFT JOIN users rejecter
                ON rejecter.id = st.rejected_by

            LEFT JOIN profiles rejecter_profile
                ON rejecter_profile.user_id = rejecter.id

            LEFT JOIN inventory_stocktake_details std
                ON std.stocktake_id = st.stocktake_id

            WHERE ${conditions.join(' AND ')}

            GROUP BY
                st.stocktake_id,
                st.stocktake_code,
                st.stocktake_date,
                st.warehouse_area,
                st.note,
                st.status,

                st.created_by,
                creator_profile.full_name,
                creator.email,

                st.submitted_at,

                st.approved_by,
                approver_profile.full_name,
                approver.email,
                st.approved_at,

                st.rejected_by,
                rejecter_profile.full_name,
                rejecter.email,
                st.rejected_at,
                st.reject_reason,

                st.created_at,
                st.updated_at

            ORDER BY st.created_at DESC
        `, params);

        return rows;
    }


    /* =========================================================
       STOCKTAKE - HEADER BY ID
       Xem thông tin chính của 1 phiếu kiểm kê.
    ========================================================= */
    async findStocktakeById(stocktakeId, conn = null) {
        const executor = conn || db;

        const [rows] = await executor.query(`
            SELECT
                st.stocktake_id,
                st.stocktake_code,
                st.stocktake_date,
                st.warehouse_area,
                st.note,
                st.status,

                st.created_by,
                COALESCE(
                    creator_profile.full_name,
                    creator.email,
                    CONCAT('User #', st.created_by)
                ) AS created_by_name,

                st.submitted_at,

                st.approved_by,
                COALESCE(
                    approver_profile.full_name,
                    approver.email,
                    CONCAT('User #', st.approved_by)
                ) AS approved_by_name,
                st.approved_at,

                st.rejected_by,
                COALESCE(
                    rejecter_profile.full_name,
                    rejecter.email,
                    CONCAT('User #', st.rejected_by)
                ) AS rejected_by_name,
                st.rejected_at,
                st.reject_reason,

                st.created_at,
                st.updated_at

            FROM inventory_stocktakes st

            LEFT JOIN users creator
                ON creator.id = st.created_by

            LEFT JOIN profiles creator_profile
                ON creator_profile.user_id = creator.id

            LEFT JOIN users approver
                ON approver.id = st.approved_by

            LEFT JOIN profiles approver_profile
                ON approver_profile.user_id = approver.id

            LEFT JOIN users rejecter
                ON rejecter.id = st.rejected_by

            LEFT JOIN profiles rejecter_profile
                ON rejecter_profile.user_id = rejecter.id

            WHERE st.stocktake_id = ?

            LIMIT 1
        `, [stocktakeId]);

        return rows[0] || null;
    }


    /* =========================================================
       STOCKTAKE - DETAILS BY ID
       Lấy chi tiết vật tư trong phiếu kiểm kê.
    ========================================================= */
    async findStocktakeDetails(stocktakeId, conn = null) {
        const executor = conn || db;

        const [rows] = await executor.query(`
            SELECT
                std.stocktake_detail_id,
                std.stocktake_id,
                std.inventory_id,
                std.product_id,

                p.ProductName AS product_name,
                p.SKU AS sku,
                pu.Name AS unit_name,

                std.system_quantity,
                std.actual_quantity,
                std.difference_quantity,

                std.item_condition,
                std.loss_reason,
                std.image_url,
                std.note,

                i.BatchNumber AS batch_number,
                i.ManufacturerBatch AS manufacturer_batch,
                i.ExpiryDate AS expiry_date,
                i.LocationRack AS location_rack,

                std.created_at,
                std.updated_at

            FROM inventory_stocktake_details std

            INNER JOIN products p
                ON p.ProductID = std.product_id

            LEFT JOIN product_unit pu
                ON pu.PUnitID = p.UnitID

            LEFT JOIN inventory i
                ON i.InventoryID = std.inventory_id

            WHERE std.stocktake_id = ?

            ORDER BY std.stocktake_detail_id ASC
        `, [stocktakeId]);

        return rows;
    }


    /* =========================================================
       STOCKTAKE - UPDATE STATUS
       Cập nhật trạng thái phiếu kiểm kê.
    ========================================================= */
    async updateStocktakeStatus(conn, stocktakeId, data) {
        const fields = ['status = ?', 'updated_at = NOW()'];
        const params = [data.status];

        if (data.status === 'pending') {
            fields.push('submitted_at = NOW()');
        }

        if (data.status === 'approved') {
            fields.push('approved_by = ?', 'approved_at = NOW()');
            params.push(data.user_id || null);
        }

        if (data.status === 'rejected') {
            fields.push(
                'rejected_by = ?',
                'rejected_at = NOW()',
                'reject_reason = ?'
            );

            params.push(
                data.user_id || null,
                data.reject_reason || null
            );
        }

        params.push(stocktakeId);

        const [result] = await conn.query(`
            UPDATE inventory_stocktakes
            SET ${fields.join(', ')}
            WHERE stocktake_id = ?
        `, params);

        return result.affectedRows > 0;
    }


    /* =========================================================
       STOCKTAKE - LOCK INVENTORY ROW
       Khóa dòng tồn kho khi tạo/duyệt để tránh cập nhật trùng.
    ========================================================= */
    async findInventoryForUpdate(conn, inventoryId) {
        const [rows] = await conn.query(`
            SELECT
                InventoryID,
                ProductID,
                Quantity,
                AllocatedQuantity,
                BatchNumber,
                ExpiryDate,
                LocationRack
            FROM inventory
            WHERE InventoryID = ?
            FOR UPDATE
        `, [inventoryId]);

        return rows[0] || null;
    }


    /* =========================================================
       STOCKTAKE - UPDATE INVENTORY QUANTITY
       Cập nhật tồn kho sau khi Product Manager duyệt kiểm kê.
    ========================================================= */
    async updateInventoryQuantityByStocktake(conn, inventoryId, actualQuantity) {
        const [result] = await conn.query(`
            UPDATE inventory
            SET
                Quantity = ?,
                UpdatedAt = NOW()
            WHERE InventoryID = ?
        `, [
            actualQuantity,
            inventoryId
        ]);

        return result.affectedRows > 0;
    }


    /* =========================================================
    INVENTORY PRODUCT SUMMARY
    Danh sách sản phẩm + tổng tồn kho để hiển thị màn hình log
    ========================================================= */
    async findProductInventorySummary(filters = {}) {
        const conditions = ['p.IsActive = 1'];
        const params = [];

        if (filters.keyword) {
            conditions.push(`
                (
                    p.ProductName LIKE ?
                    OR p.SKU LIKE ?
                )
            `);

            params.push(
                `%${filters.keyword}%`,
                `%${filters.keyword}%`
            );
        }

        if (filters.categoryId) {
            conditions.push('p.CategoryID = ?');
            params.push(filters.categoryId);
        }

        const [rows] = await db.query(`
            SELECT
                p.ProductID AS product_id,
                p.SKU AS sku,
                p.ProductName AS product_name,
                c.CategoryName AS category_name,
                pu.Name AS unit_name,

                COALESCE(SUM(i.Quantity), 0) AS total_quantity,
                COALESCE(SUM(i.AllocatedQuantity), 0) AS allocated_quantity,
                COALESCE(SUM(i.Quantity - i.AllocatedQuantity), 0) AS available_quantity,

                COUNT(i.InventoryID) AS total_batches,
                MAX(i.UpdatedAt) AS last_inventory_updated_at

            FROM products p

            LEFT JOIN inventory i
                ON i.ProductID = p.ProductID

            LEFT JOIN category c
                ON c.CategoryID = p.CategoryID

            LEFT JOIN product_unit pu
                ON pu.PUnitID = p.UnitID

            WHERE ${conditions.join(' AND ')}

            GROUP BY
                p.ProductID,
                p.SKU,
                p.ProductName,
                c.CategoryName,
                pu.Name

            ORDER BY p.ProductName ASC
        `, params);

        return rows;
    }

    /* =========================================================
    INVENTORY LOGS BY PRODUCT
    Xem tất cả lần nhập/xuất kho của một sản phẩm
    ========================================================= */
    async findInventoryLogsByProductId(productId, filters = {}) {
        const conditions = ['i.ProductID = ?'];
        const params = [productId];

        if (filters.logType) {
            conditions.push('il.LogType = ?');
            params.push(filters.logType);
        }

        if (filters.fromDate) {
            conditions.push('DATE(il.CreatedAt) >= ?');
            params.push(filters.fromDate);
        }

        if (filters.toDate) {
            conditions.push('DATE(il.CreatedAt) <= ?');
            params.push(filters.toDate);
        }

        const [rows] = await db.query(`
            SELECT
                il.LogID AS log_id,
                il.InventoryID AS inventory_id,
                il.LogType AS log_type,
                il.ChangeQuantity AS change_quantity,
                il.ReferenceID AS reference_id,
                il.PerformedBy AS performed_by,
                il.Note AS note,
                il.CreatedAt AS created_at,

                i.ProductID AS product_id,
                i.BatchNumber AS batch_number,
                i.ManufacturerBatch AS manufacturer_batch,
                i.LocationRack AS location_rack,
                i.ExpiryDate AS expiry_date,

                p.SKU AS sku,
                p.ProductName AS product_name,

                u.email AS performed_by_email,
                pf.full_name AS performed_by_name

            FROM inventory_logs il

            INNER JOIN inventory i
                ON i.InventoryID = il.InventoryID

            INNER JOIN products p
                ON p.ProductID = i.ProductID

            LEFT JOIN users u
                ON u.id = il.PerformedBy

            LEFT JOIN profiles pf
                ON pf.user_id = u.id

            WHERE ${conditions.join(' AND ')}

            ORDER BY il.CreatedAt DESC, il.LogID DESC
        `, params);

        return rows;
    }
    }

module.exports = new InventoryRepository();