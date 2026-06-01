const path = require('path');

const inventoryRepository = require('./inventory.repository');
const productRepository = require('../products/product.repository');
const orderRepository = require('../orders/order.repository');
const mailService = require('../mail/mail.service');

const { pool: db } = require('../../config/database');

class InventoryService {

    /* =========================================================
       1. INVENTORY SUMMARY
       Lấy tất cả tồn kho dạng tổng hợp theo sản phẩm

       Dùng cho:
       - GET /api/inventory
       - Dashboard tổng quan tồn kho
    ========================================================= */
    async getAllInventory() {
        return await inventoryRepository.findAll();
    }

    /* =========================================================
       2. INVENTORY DETAILS
       Lấy tồn kho chi tiết theo từng lô hàng

       Dùng cho:
       - GET /api/inventory/details
       - Trang warehouse import-management
       - Frontend cần BatchNumber, LocationRack, ExpiryDate, SKU...
    ========================================================= */
    async getDetails() {
        return await inventoryRepository.findDetails();
    }

    /* =========================================================
       3. INVENTORY BY ID
       Lấy chi tiết 1 dòng tồn kho theo InventoryID

       Dùng cho:
       - GET /api/inventory/:id
    ========================================================= */
    async getInventoryById(id) {
        const inventoryId = Number(id);

        if (!inventoryId) {
            throw new Error('ID tồn kho không hợp lệ');
        }

        const item = await inventoryRepository.findById(inventoryId);

        if (!item) {
            throw new Error('Không tìm thấy dòng tồn kho này');
        }

        return item;
    }

    /* =========================================================
       4. WAREHOUSE STOCK SEARCH
       Lấy tồn kho có lọc theo tên sản phẩm / hết hạn

       Dùng cho:
       - GET /api/inventory/search

       Lưu ý:
       - Nếu inventoryRepository chưa có getWarehouseStock()
         thì bạn cần comment route /search lại.
    ========================================================= */
    async getWarehouseStock(filters = {}) {
        if (typeof inventoryRepository.getWarehouseStock !== 'function') {
            throw new Error('inventoryRepository.getWarehouseStock chưa được định nghĩa');
        }

        return await inventoryRepository.getWarehouseStock(filters);
    }

    /* =========================================================
       5. RESERVE STOCK AUTO
       Tự động treo hàng khi Sale tạo đơn

       Logic:
       - Tìm các lô còn hàng theo FEFO
       - Tăng AllocatedQuantity
       - Nếu không đủ hàng thì throw error
    ========================================================= */
    async reserveStockAuto(productId, totalQty, connection) {
        const finalProductId = Number(productId);
        let remaining = Number(totalQty);

        if (!finalProductId) {
            throw new Error('ProductID không hợp lệ');
        }

        if (!remaining || remaining <= 0) {
            throw new Error('Số lượng giữ hàng không hợp lệ');
        }

        const batches = await inventoryRepository.findAvailableBatchesFEFO(
            finalProductId,
            connection
        );

        for (const batch of batches) {
            if (remaining <= 0) break;

            const available =
                Number(batch.Quantity || 0) -
                Number(batch.AllocatedQuantity || 0);

            const take = Math.min(remaining, available);

            if (take <= 0) continue;

            await inventoryRepository.updateAllocatedQty(
                batch.InventoryID,
                take,
                connection
            );

            remaining -= take;
        }

        if (remaining > 0) {
            throw new Error(`Sản phẩm ID ${finalProductId} không đủ hàng khả dụng.`);
        }

        return true;
    }

    /* =========================================================
       6. CONFIRM ORDER EXPORT
       Thủ kho xác nhận xuất hàng thực tế theo đơn

       Logic:
       - Lấy order_details
       - Trừ kho theo các lô đã treo
       - Ghi inventory_logs
       - Cập nhật orders.status

       Lưu ý:
       - Hàm này giữ cho luồng xuất kho cũ.
       - Repository cần có:
         getOrderItems()
         confirmPhysicalExportByOrder()
         updateOrderStatus()
    ========================================================= */
    async confirmOrderExport(orderId, userId) {
        const connection = await db.getConnection();
        await connection.beginTransaction();

        try {
            // 1. lấy order items (ĐÚNG CHỖ)
            const items = await orderRepository.getOrderItems(orderId);

            if (items.length === 0) {
                throw new Error("Đơn hàng không có sản phẩm hoặc không tồn tại.");
            }

            // 2. trừ kho
            for (let item of items) {
                const success = await inventoryRepository.confirmPhysicalExportByOrder(
                    item.product_id,
                    item.quantity,
                    connection,
                    userId,
                    orderId
                );

                if (!success) {
                    throw new Error(`Không đủ hàng cho SP ${item.product_id}`);
                }
            }

            // 3. update trạng thái ORDER
            await orderRepository.updateOrderStatus(orderId, connection);

            await connection.commit();

            return {
                success: true,
                message: "Xuất kho + cập nhật SHIPPED thành công"
            };

        } catch (err) {
            await connection.rollback();
            throw err;
        } finally {
            connection.release();
        }
    }

    /* =========================================================
       7. UPDATE INVENTORY
       Cập nhật số lượng tồn kho và tự đồng bộ trạng thái sản phẩm

       Dùng cho:
       - Các luồng cũ đang gọi updateInventory()

       Lưu ý:
       - Không dùng cho nhập hàng theo PO.
       - Nhập hàng theo PO dùng createGoodsReceipt().
    ========================================================= */
    async updateInventory(productId, quantity) {
        const finalProductId = Number(productId);
        const finalQuantity = Number(quantity);

        if (!finalProductId) {
            throw new Error('ProductID không hợp lệ');
        }

        if (Number.isNaN(finalQuantity) || finalQuantity < 0) {
            throw new Error('Số lượng tồn kho không hợp lệ');
        }

        await inventoryRepository.updateQuantity(
            finalProductId,
            finalQuantity
        );

        await productRepository.syncStatusByInventory(finalProductId);
    }

    /* =========================================================
       8. PRODUCT LOTS BY PRODUCT
       Lấy danh sách lô tồn kho theo sản phẩm

       Dùng cho:
       - GET /api/inventory/lots/:productId
    ========================================================= */
    async getLotsByProduct(productId) {
        const finalProductId = Number(productId);

        if (!finalProductId) {
            throw new Error('ProductID không hợp lệ');
        }

        return await inventoryRepository.findLotsByProduct(finalProductId);
    }

        // Thêm vào trong class InventoryService ở file inventory.service.js của bạn:
    async getTotalProductsCount() {
        // Thay đổi tùy theo DB bạn xài (Dưới đây là ví dụ cho MySQL/Sequelize hoặc Knex)
        // Nếu dùng MySQL thuần: const [rows] = await db.execute('SELECT COUNT(*) as total FROM products'); return rows[0].total;
        // Tạm thời nếu chưa cấu hình DB ở service, bạn có thể return một số cứng để test, ví dụ: return 150;

        const [rows] = await db.execute('SELECT COUNT(*) as total FROM products');
        return rows[0]?.total || 0;
    }

    /* =========================================================
       20. DASHBOARD SUMMARY NUMBERS // tú như
       Lấy số liệu tổng hợp cho màn hình Dashboard của thủ kho
    ========================================================= */
    async getDashboardSummary() {
        // 1. Đếm tổng số sản phẩm độc nhất hiện có trong kho
        const [totalProducts] = await db.execute('SELECT COUNT(DISTINCT ProductID) as count FROM inventory WHERE Quantity > 0');

        // 2. Đếm số lượng lô nông sản/sản phẩm sắp hết hạn (Ví dụ: còn dưới 30 ngày)
        const [expiringSoon] = await db.execute('SELECT COUNT(*) as count FROM inventory WHERE ExpiryDate IS NOT NULL AND ExpiryDate <= DATE_ADD(CURDATE(), INTERVAL 30 DAY) AND Quantity > 0');

        // 3. Đếm số lượng đơn hàng đang ở trạng thái chờ xuất kho/chờ vận chuyển (Ví dụ: trạng thái 'processing' hoặc 'pending')
        const [pendingOrders] = await db.execute("SELECT COUNT(*) as count FROM orders WHERE status = 'processing' OR status = 'pending'");

        // 4. Đếm số lượng phiếu nhập kho đang xử lý (Ví dụ trạng thái 'PENDING' trong bảng hàng nhập)
        const [pendingReceipts] = await db.execute("SELECT COUNT(*) as count FROM goods_receipts WHERE status = 'PENDING'");

        return {
            totalProducts: totalProducts[0]?.count || 0,
            expiringSoon: expiringSoon[0]?.count || 0,
            pendingOrders: pendingOrders[0]?.count || 0,
            pendingReceipts: pendingReceipts[0]?.count || 0
        };
    }

    /* =========================================================
       9. GOODS RECEIPT - CREATE
       Tạo phiếu nhận hàng thực tế theo Purchase Order

       Dùng cho:
       - POST /api/inventory/goods-receipts

       Luồng xử lý:
       1. Kiểm tra PO tồn tại và đang được phép nhận hàng.
       2. Tạo goods_receipts.
       3. Nếu có hàng lỗi:
          - has_rejected_items = 1
          - issue_status = WAITING_REVIEW
       4. Nếu không có hàng lỗi:
          - has_rejected_items = 0
          - issue_status = NONE
       5. Tạo goods_receipt_details.
       6. Tự sinh batch_number nội bộ.
       7. Lưu manufacturer_batch nếu Warehouse nhập.
       8. Lưu ảnh hàng lỗi vào goods_receipt_details.fault_images.
       9. Cộng accepted_quantity vào inventory.
       10. Không cộng rejected_quantity vào inventory.
       11. Ghi inventory_logs.
       12. Cập nhật received_quantity của purchase_order_details.
       13. Cập nhật trạng thái PO:
           - PARTIAL_RECEIVED nếu nhận chưa đủ.
           - COMPLETED nếu nhận đủ.
    ========================================================= */
    async createGoodsReceipt(payload, userId, files = []) {
        const purchaseOrderId = Number(payload.purchase_order_id);
        const items = Array.isArray(payload.items) ? payload.items : [];

        if (!purchaseOrderId) {
            throw new Error('Thiếu phiếu đặt hàng');
        }

        if (!items.length) {
            throw new Error('Phiếu nhận hàng cần ít nhất 1 sản phẩm');
        }

        const conn = await db.getConnection();

        try {
            await conn.beginTransaction();

            const purchaseOrder =
                await inventoryRepository.findPurchaseOrderForReceiving(
                    conn,
                    purchaseOrderId
                );

            if (!purchaseOrder) {
                throw new Error('Không tìm thấy phiếu đặt hàng');
            }

            if (!['ORDERED', 'PARTIAL_RECEIVED'].includes(purchaseOrder.status)) {
                throw new Error('Phiếu đặt hàng không ở trạng thái có thể nhận hàng');
            }

            const receiptCode = this.generateReceiptCode();

            const hasRejectedItems = items.some(item => {
                return Number(item.rejected_quantity || 0) > 0;
            });

            const goodsReceiptId =
                await inventoryRepository.createGoodsReceipt(
                    conn,
                    {
                        receipt_code: receiptCode,
                        purchase_order_id: purchaseOrderId,
                        supplier_id: purchaseOrder.supplier_id,
                        received_by: userId,
                        created_by: userId,
                        updated_by: userId,
                        status: 'COMPLETED',
                        has_rejected_items: hasRejectedItems ? 1 : 0,

                        // NOTE:
                        // Warehouse chỉ tạo phiếu.
                        // Product Manager là người xem và gửi email xử lý hàng lỗi.
                        issue_status: hasRejectedItems ? 'WAITING_REVIEW' : 'NONE',

                        note: payload.note || null
                    }
                );

            for (const item of items) {
                const purchaseOrderDetailId = Number(item.purchase_order_detail_id);
                const productId = Number(item.product_id);

                const receivedQuantity = Number(item.received_quantity || 0);
                const acceptedQuantity = Number(item.accepted_quantity || 0);
                const rejectedQuantity = Number(item.rejected_quantity || 0);

                if (!purchaseOrderDetailId || !productId) {
                    throw new Error('Dữ liệu sản phẩm không hợp lệ');
                }

                if (receivedQuantity <= 0) {
                    throw new Error('Số lượng thực nhận phải lớn hơn 0');
                }

                if (acceptedQuantity < 0 || rejectedQuantity < 0) {
                    throw new Error('Số lượng đạt/lỗi không hợp lệ');
                }

                if (acceptedQuantity + rejectedQuantity > receivedQuantity) {
                    throw new Error('Số lượng đạt + lỗi không được vượt quá số lượng thực nhận');
                }

                if (rejectedQuantity > 0 && !item.reject_reason) {
                    throw new Error('Có hàng lỗi thì cần nhập lý do lỗi');
                }

                if (acceptedQuantity > 0 && !item.location_rack) {
                    throw new Error('Hàng đạt cần có vị trí kệ');
                }

                const poDetail =
                    await inventoryRepository.findPurchaseOrderDetailForReceiving(
                        conn,
                        purchaseOrderDetailId
                    );

                if (!poDetail) {
                    throw new Error('Không tìm thấy chi tiết phiếu đặt hàng');
                }

                if (Number(poDetail.purchase_order_id) !== purchaseOrderId) {
                    throw new Error('Sản phẩm không thuộc phiếu đặt hàng này');
                }

                if (Number(poDetail.product_id) !== productId) {
                    throw new Error('Sản phẩm nhận không khớp với phiếu đặt hàng');
                }

                const remainingQuantity =
                    Number(poDetail.ordered_quantity || 0) -
                    Number(poDetail.received_quantity || 0);

                if (receivedQuantity > remainingQuantity) {
                    throw new Error(
                        `Số lượng nhận của ${poDetail.ProductName} vượt quá số lượng còn lại`
                    );
                }

                const batchNumber = this.generateBatchNumber(productId);

                const missingQuantity = Math.max(
                    0,
                    remainingQuantity - receivedQuantity
                );

                const faultImages = this.getFaultImagesByPODetailId(
                    files,
                    purchaseOrderDetailId
                );

                this.validateFaultImages(
                    rejectedQuantity,
                    faultImages
                );

                await inventoryRepository.createGoodsReceiptDetail(
                    conn,
                    {
                        receipt_id: goodsReceiptId,
                        purchase_order_detail_id: purchaseOrderDetailId,
                        product_id: productId,

                        received_quantity: receivedQuantity,
                        faulty_quantity: rejectedQuantity,
                        missing_quantity: missingQuantity,

                        unit_price: Number(item.unit_price || poDetail.unit_price || 0),
                        manufacture_date: item.manufacture_date || null,
                        expiry_date: item.expiry_date || null,
                        batch_number: batchNumber,
                        manufacturer_batch: item.manufacturer_batch || null,
                        location_rack: item.location_rack || null,

                        // NOTE:
                        // Lý do lỗi hàng được lưu vào note của goods_receipt_details.
                        note: item.reject_reason || null,

                        // NOTE:
                        // Ảnh lỗi lưu dạng JSON array trong goods_receipt_details.fault_images.
                        // Ví dụ:
                        // ["/uploads/goods-receipts/a.jpg", "/uploads/goods-receipts/b.jpg"]
                        fault_images: faultImages,

                        created_by: userId,
                        updated_by: userId
                    }
                );

                await inventoryRepository.increasePurchaseOrderDetailReceived(
                    conn,
                    purchaseOrderDetailId,
                    receivedQuantity
                );

                if (acceptedQuantity > 0) {
                    const existedBatch =
                        await inventoryRepository.findInventoryBatch(
                            conn,
                            productId,
                            batchNumber
                        );

                    if (existedBatch) {
                        await inventoryRepository.increaseInventoryBatch(
                            conn,
                            existedBatch.InventoryID,
                            acceptedQuantity
                        );

                        await inventoryRepository.createInventoryLog(
                            {
                                InventoryID: existedBatch.InventoryID,
                                ChangeQuantity: acceptedQuantity,
                                LogType: 'IMPORT',
                                ReferenceID: goodsReceiptId,
                                PerformedBy: userId,
                                Note: `Nhập kho từ phiếu ${receiptCode}`
                            },
                            conn
                        );

                    } else {
                        const inventoryId =
                            await inventoryRepository.createInventoryBatch(
                                conn,
                                {
                                    product_id: productId,
                                    batch_number: batchNumber,
                                    manufacturer_batch: item.manufacturer_batch || null,
                                    quantity: acceptedQuantity,
                                    expiry_date: item.expiry_date || null,
                                    location_rack: item.location_rack || null,
                                    min_stock_level: 10
                                }
                            );

                        await inventoryRepository.createInventoryLog(
                            {
                                InventoryID: inventoryId,
                                ChangeQuantity: acceptedQuantity,
                                LogType: 'IMPORT',
                                ReferenceID: goodsReceiptId,
                                PerformedBy: userId,
                                Note: `Nhập kho từ phiếu ${receiptCode}`
                            },
                            conn
                        );
                    }
                }
            }

            const summary =
                await inventoryRepository.getPurchaseOrderReceiveSummary(
                    conn,
                    purchaseOrderId
                );

            const totalOrdered = Number(summary.total_ordered || 0);
            const totalReceived = Number(summary.total_received || 0);

            const nextStatusCode =
                totalReceived >= totalOrdered
                    ? 'COMPLETED'
                    : 'PARTIAL_RECEIVED';

            const nextStatus =
                await inventoryRepository.findPurchaseOrderStatusByCode(
                    conn,
                    nextStatusCode
                );

            if (!nextStatus) {
                throw new Error(`Thiếu trạng thái ${nextStatusCode} trong purchase_order_statuses`);
            }

            await inventoryRepository.updatePurchaseOrderStatus(
                conn,
                purchaseOrderId,
                nextStatus.status_id
            );

            await inventoryRepository.createPurchaseOrderStatusLog(
                conn,
                {
                    purchase_order_id: purchaseOrderId,
                    old_status_id: purchaseOrder.status_id,
                    new_status_id: nextStatus.status_id,
                    changed_by: userId,
                    note: `Warehouse tạo phiếu nhận hàng ${receiptCode}`
                }
            );

            await conn.commit();

            return {
                goods_receipt_id: goodsReceiptId,
                receipt_code: receiptCode,
                purchase_order_id: purchaseOrderId,
                has_rejected_items: hasRejectedItems ? 1 : 0,
                issue_status: hasRejectedItems ? 'WAITING_REVIEW' : 'NONE',
                po_status: nextStatusCode
            };

        } catch (err) {
            await conn.rollback();
            throw err;
        } finally {
            conn.release();
        }
    }

    /* =========================================================
       10. GOODS RECEIPT - LIST
       Lấy danh sách phiếu nhận hàng

       Dùng cho:
       - Warehouse xem lịch sử nhập hàng.
       - Product Manager xem phiếu có hàng lỗi.
       - Product Manager lọc phiếu chờ xử lý lỗi.

       API:
       - GET /api/inventory/goods-receipts
       - GET /api/inventory/goods-receipts?has_rejected_items=1
       - GET /api/inventory/goods-receipts?issue_status=WAITING_REVIEW
    ========================================================= */
    async getGoodsReceipts(query = {}) {
        const filters = {};

        if (query.has_rejected_items !== undefined) {
            filters.has_rejected_items = Number(query.has_rejected_items);
        }

        if (query.issue_status) {
            filters.issue_status = query.issue_status;
        }

        return await inventoryRepository.findGoodsReceipts(filters);
    }

    /* =========================================================
       11. GOODS RECEIPT - DETAIL
       Lấy chi tiết một phiếu nhận hàng

       Dùng cho:
       - Product Manager xem phiếu nhập có hàng lỗi.
       - Warehouse xem lại phiếu đã nhận.
       - Hàm gửi email NCC lấy dữ liệu từ đây.

       Kết quả items sẽ có:
       - rejected_quantity
       - reject_reason
       - fault_images
    ========================================================= */
    async getGoodsReceiptById(goodsReceiptId) {
        const id = Number(goodsReceiptId);

        if (!id) {
            throw new Error('ID phiếu nhận hàng không hợp lệ');
        }

        const receipt = await inventoryRepository.findGoodsReceiptById(id);

        if (!receipt) {
            throw new Error('Không tìm thấy phiếu nhận hàng');
        }

        const items = await inventoryRepository.findGoodsReceiptDetails(id);

        return {
            ...receipt,
            items
        };
    }

    /* =========================================================
       12. SEND GOODS RECEIPT ISSUE EMAIL
       Product Manager gửi email thông báo hàng lỗi cho nhà cung cấp.

       Dùng cho:
       - POST /api/inventory/goods-receipts/:id/send-issue-email

       Luồng:
       1. Product Manager bấm gửi email.
       2. Hệ thống lấy phiếu nhận hàng + chi tiết hàng lỗi.
       3. Kiểm tra phiếu có hàng lỗi không.
       4. Lọc sản phẩm có rejected_quantity > 0.
       5. Lấy ảnh lỗi từ fault_images và đính kèm email.
       6. Gửi email cho supplier_email.
       7. Cập nhật issue_status = EMAIL_SENT.
       8. Ghi log email nếu repository có createGoodsReceiptSupplierEmailLog().
    ========================================================= */
    async sendGoodsReceiptIssueEmail(goodsReceiptId, userId) {
        const id = Number(goodsReceiptId);

        if (!id) {
            throw new Error('ID phiếu nhận hàng không hợp lệ');
        }

        const receipt = await this.getGoodsReceiptById(id);

        if (!receipt) {
            throw new Error('Không tìm thấy phiếu nhận hàng');
        }

        if (Number(receipt.has_rejected_items || 0) !== 1) {
            throw new Error('Phiếu này không có hàng lỗi để gửi email');
        }

        if (!receipt.supplier_email) {
            throw new Error('Nhà cung cấp chưa có email');
        }

        const faultyItems = (receipt.items || []).filter(item => {
            return Number(item.rejected_quantity || 0) > 0;
        });

        if (!faultyItems.length) {
            throw new Error('Không tìm thấy sản phẩm lỗi trong phiếu');
        }

        const attachments = this.buildIssueEmailAttachments(faultyItems);

        const subject = `Thông báo hàng lỗi - Phiếu ${receipt.receipt_code}`;

        const content = `
            Phiếu nhận hàng ${receipt.receipt_code}
            thuộc PO ${receipt.po_code || '-'} có phát sinh hàng lỗi.
        `;

        try {
            await mailService.sendGoodsReceiptIssueEmail(
                receipt.supplier_email,
                receipt,
                faultyItems,
                attachments
            );
        } catch (err) {
            throw new Error(`Gửi email thất bại: ${err.message}`);
        }

        const conn = await db.getConnection();

        try {
            await conn.beginTransaction();

            await inventoryRepository.markGoodsReceiptIssueEmailSent(
                conn,
                id,
                userId
            );

            if (typeof inventoryRepository.createGoodsReceiptSupplierEmailLog === 'function') {
                await inventoryRepository.createGoodsReceiptSupplierEmailLog(conn, {
                    receipt_id: id,
                    supplier_id: receipt.supplier_id,
                    sent_to: receipt.supplier_email,
                    subject,
                    content,
                    status: 'SENT',
                    error_message: null,
                    sent_by: userId
                });
            }

            await conn.commit();

            return {
                receipt_id: id,
                receipt_code: receipt.receipt_code,
                sent_to: receipt.supplier_email,
                faulty_items: faultyItems.length,
                attachments: attachments.length,
                issue_status: 'EMAIL_SENT'
            };

        } catch (err) {
            await conn.rollback();
            throw err;
        } finally {
            conn.release();
        }
    }

    /* =========================================================
       13. BUILD ISSUE EMAIL ATTACHMENTS
       Chuyển fault_images thành attachments cho nodemailer.

       fault_images đang lưu dạng:
       [
         "/uploads/goods-receipts/xxx.jpg",
         "/uploads/goods-receipts/yyy.png"
       ]

       Lưu ý:
       - path.join(process.cwd(), 'public', imageUrl)
         sẽ trỏ tới file thật trong public/uploads/goods-receipts.
    ========================================================= */
    buildIssueEmailAttachments(items = []) {
        const attachments = [];

        for (const item of items) {
            const images = Array.isArray(item.fault_images)
                ? item.fault_images
                : [];

            for (const imageUrl of images) {
                if (!imageUrl) continue;

                    attachments.push({
                    filename: path.basename(imageUrl),
                    path: path.join(process.cwd(), 'src', 'public', imageUrl)
                });
            }
        }

        return attachments;
    }

    /* =========================================================
       14. GET FAULT IMAGES BY PO DETAIL ID
       Lấy danh sách ảnh hàng lỗi theo từng dòng PO

       Frontend gửi file field name dạng:
       fault_images_${purchase_order_detail_id}

       Ví dụ:
       fault_images_15
    ========================================================= */
    getFaultImagesByPODetailId(files = [], purchaseOrderDetailId) {
        return files
            .filter(file => {
                return file.fieldname === `fault_images_${purchaseOrderDetailId}`;
            })
            .map(file => {
                return `/images/uploads/good-receips/${file.filename}`;
            });
    }

    /* =========================================================
       15. VALIDATE FAULT IMAGES
       Có hàng lỗi thì có thể yêu cầu ảnh minh chứng

       Hiện tại:
       - Chưa bắt buộc upload ảnh để tránh kẹt nghiệp vụ.

       Nếu muốn bắt buộc ảnh:
       - Mở throw trong hàm này.
    ========================================================= */
    validateFaultImages(rejectedQuantity, faultImages = []) {
        if (Number(rejectedQuantity || 0) > 0 && !faultImages.length) {
            // Nếu muốn bắt buộc upload ảnh khi có hàng lỗi thì mở dòng này:
            // throw new Error('Có hàng lỗi thì cần upload ít nhất 1 ảnh minh chứng');
        }

        return true;
    }

    /* =========================================================
       16. GENERATE RECEIPT CODE
       Sinh mã phiếu nhận hàng nội bộ

       Format:
       GR-YYYYMMDD-RANDOM

       Ví dụ:
       GR-20260523-5821
    ========================================================= */
    generateReceiptCode() {
        const now = new Date();

        const y = now.getFullYear();
        const m = String(now.getMonth() + 1).padStart(2, '0');
        const d = String(now.getDate()).padStart(2, '0');

        const random = Math.floor(1000 + Math.random() * 9000);

        return `GR-${y}${m}${d}-${random}`;
    }

    /* =========================================================
       17. GENERATE BATCH NUMBER
       Sinh mã lô nội bộ cho hệ thống

       Format:
       LOT-YYYYMMDD-P{productId}-RANDOM

       Ví dụ:
       LOT-20260523-P10-4821

       Lưu ý:
       - Đây là mã lô nội bộ.
       - Số lô in trên bao bì là manufacturer_batch.
    ========================================================= */
    generateBatchNumber(productId) {
        const now = new Date();

        const y = now.getFullYear();
        const m = String(now.getMonth() + 1).padStart(2, '0');
        const d = String(now.getDate()).padStart(2, '0');

        const random = Math.floor(1000 + Math.random() * 9000);

        return `LOT-${y}${m}${d}-P${productId}-${random}`;
    }

        /* =========================================================
       STOCKTAKE - GET INVENTORY ITEMS
    ========================================================= */
    async getStocktakeInventoryItems(filters = {}) {
        return await inventoryRepository.getStocktakeInventoryItems(filters);
    }


    /* =========================================================
       STOCKTAKE - LIST
    ========================================================= */
    async getStocktakes(filters = {}) {
        return await inventoryRepository.findStocktakes(filters);
    }


    /* =========================================================
       STOCKTAKE - DETAIL
    ========================================================= */
    async getStocktakeById(stocktakeId) {
        const id = Number(stocktakeId);

        if (!id) {
            throw new Error('ID phiếu kiểm kê không hợp lệ');
        }

        const stocktake = await inventoryRepository.findStocktakeById(id);

        if (!stocktake) {
            throw new Error('Không tìm thấy phiếu kiểm kê');
        }

        const details = await inventoryRepository.findStocktakeDetails(id);

        return {
            ...stocktake,
            items: details
        };
    }


    /* =========================================================
       STOCKTAKE - CREATE
       Nhân viên kho tạo phiếu kiểm kê.
    ========================================================= */
    async createStocktake(payload = {}, userId) {
        const items = Array.isArray(payload.items) ? payload.items : [];

        if (!items.length) {
            throw new Error('Phiếu kiểm kê phải có ít nhất 1 vật tư');
        }

        const conn = await db.getConnection();

        try {
            await conn.beginTransaction();

            const status = payload.submit === true ? 'pending' : 'draft';

            const stocktakeId = await inventoryRepository.createStocktake(conn, {
                stocktake_code: this.generateStocktakeCode(),
                stocktake_date: payload.stocktake_date || new Date(),
                warehouse_area: payload.warehouse_area,
                note: payload.note,
                status,
                created_by: userId
            });

            for (const rawItem of items) {
                const inventoryId = Number(rawItem.inventory_id || rawItem.InventoryID);
                const actualQuantity = Number(rawItem.actual_quantity);

                if (!inventoryId) {
                    throw new Error('Có dòng vật tư thiếu inventory_id');
                }

                if (Number.isNaN(actualQuantity) || actualQuantity < 0) {
                    throw new Error('Số lượng thực tế không hợp lệ');
                }

                const inventory = await inventoryRepository.findInventoryForUpdate(
                    conn,
                    inventoryId
                );

                if (!inventory) {
                    throw new Error(`Không tìm thấy tồn kho InventoryID ${inventoryId}`);
                }

                const systemQuantity = Number(inventory.Quantity || 0);
                const differenceQuantity = actualQuantity - systemQuantity;

                await inventoryRepository.createStocktakeDetail(conn, {
                    stocktake_id: stocktakeId,
                    inventory_id: inventory.InventoryID,
                    product_id: inventory.ProductID,
                    system_quantity: systemQuantity,
                    actual_quantity: actualQuantity,
                    difference_quantity: differenceQuantity,
                    item_condition: rawItem.item_condition,
                    loss_reason: rawItem.loss_reason,
                    image_url: rawItem.image_url,
                    note: rawItem.note
                });
            }

            await conn.commit();

            return await this.getStocktakeById(stocktakeId);

        } catch (error) {
            await conn.rollback();
            throw error;

        } finally {
            conn.release();
        }
    }


    /* =========================================================
       STOCKTAKE - SUBMIT
       Gửi phiếu nháp sang quản lý sản phẩm duyệt.
    ========================================================= */
    async submitStocktake(stocktakeId, userId) {
        const id = Number(stocktakeId);

        if (!id) {
            throw new Error('ID phiếu kiểm kê không hợp lệ');
        }

        const conn = await db.getConnection();

        try {
            await conn.beginTransaction();

            const stocktake = await inventoryRepository.findStocktakeById(id, conn);

            if (!stocktake) {
                throw new Error('Không tìm thấy phiếu kiểm kê');
            }

            if (stocktake.status !== 'draft') {
                throw new Error('Chỉ phiếu nháp mới được gửi duyệt');
            }

            await inventoryRepository.updateStocktakeStatus(conn, id, {
                status: 'pending',
                user_id: userId
            });

            await conn.commit();

            return await this.getStocktakeById(id);

        } catch (error) {
            await conn.rollback();
            throw error;

        } finally {
            conn.release();
        }
    }


    /* =========================================================
       STOCKTAKE - APPROVE
       Product Manager duyệt phiếu và cập nhật tồn kho.
    ========================================================= */
    async approveStocktake(stocktakeId, userId) {
        const id = Number(stocktakeId);

        if (!id) {
            throw new Error('ID phiếu kiểm kê không hợp lệ');
        }

        const conn = await db.getConnection();

        try {
            await conn.beginTransaction();

            const stocktake = await inventoryRepository.findStocktakeById(id, conn);

            if (!stocktake) {
                throw new Error('Không tìm thấy phiếu kiểm kê');
            }

            if (stocktake.status !== 'pending') {
                throw new Error('Chỉ phiếu đang chờ duyệt mới được duyệt');
            }

            const details = await inventoryRepository.findStocktakeDetails(id, conn);

            if (!details.length) {
                throw new Error('Phiếu kiểm kê chưa có vật tư');
            }

            for (const item of details) {
                const inventory = await inventoryRepository.findInventoryForUpdate(
                    conn,
                    item.inventory_id
                );

                if (!inventory) {
                    throw new Error(`Không tìm thấy tồn kho InventoryID ${item.inventory_id}`);
                }

                const currentQuantity = Number(inventory.Quantity || 0);
                const actualQuantity = Number(item.actual_quantity || 0);
                const changeQuantity = actualQuantity - currentQuantity;

                await inventoryRepository.updateInventoryQuantityByStocktake(
                    conn,
                    item.inventory_id,
                    actualQuantity
                );

                if (changeQuantity !== 0) {
                    await inventoryRepository.createInventoryLog({
                        InventoryID: item.inventory_id,
                        ChangeQuantity: changeQuantity,
                        LogType: 'STOCKTAKE_ADJUSTMENT',
                        ReferenceID: id,
                        PerformedBy: userId,
                        Note: `Duyệt phiếu kiểm kê ${stocktake.stocktake_code}. Tồn cũ: ${currentQuantity}, thực tế: ${actualQuantity}`
                    }, conn);
                }
            }

            await inventoryRepository.updateStocktakeStatus(conn, id, {
                status: 'approved',
                user_id: userId
            });

            await conn.commit();

            return await this.getStocktakeById(id);

        } catch (error) {
            await conn.rollback();
            throw error;

        } finally {
            conn.release();
        }
    }


    /* =========================================================
       STOCKTAKE - REJECT
       Product Manager từ chối phiếu.
    ========================================================= */
    async rejectStocktake(stocktakeId, userId, reason) {
        const id = Number(stocktakeId);

        if (!id) {
            throw new Error('ID phiếu kiểm kê không hợp lệ');
        }

        const conn = await db.getConnection();

        try {
            await conn.beginTransaction();

            const stocktake = await inventoryRepository.findStocktakeById(id, conn);

            if (!stocktake) {
                throw new Error('Không tìm thấy phiếu kiểm kê');
            }

            if (stocktake.status !== 'pending') {
                throw new Error('Chỉ phiếu đang chờ duyệt mới được từ chối');
            }

            await inventoryRepository.updateStocktakeStatus(conn, id, {
                status: 'rejected',
                user_id: userId,
                reject_reason: reason || 'Không đạt yêu cầu kiểm kê'
            });

            await conn.commit();

            return await this.getStocktakeById(id);

        } catch (error) {
            await conn.rollback();
            throw error;

        } finally {
            conn.release();
        }
    }


    /* =========================================================
       STOCKTAKE - CODE GENERATOR
    ========================================================= */
    generateStocktakeCode() {
        const now = new Date();

        const y = now.getFullYear();
        const m = String(now.getMonth() + 1).padStart(2, '0');
        const d = String(now.getDate()).padStart(2, '0');
        const random = Math.floor(1000 + Math.random() * 9000);

        return `STK-${y}${m}${d}-${random}`;
    }

    async getProductInventorySummary(query = {}) {
    return inventoryRepository.findProductInventorySummary({
        keyword: query.keyword || null,
        categoryId: query.categoryId || null
    });
}

async getProductInventoryLogs(productId, query = {}) {
    const productIdNumber = Number(productId);

    if (!productIdNumber || Number.isNaN(productIdNumber)) {
        const error = new Error('ProductID không hợp lệ');
        error.statusCode = 400;
        throw error;
    }

    return inventoryRepository.findInventoryLogsByProductId(productIdNumber, {
        logType: query.logType || null,
        fromDate: query.fromDate || null,
        toDate: query.toDate || null
    });
}
}

module.exports = new InventoryService();