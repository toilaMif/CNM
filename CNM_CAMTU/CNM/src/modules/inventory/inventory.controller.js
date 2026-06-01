const inventoryService = require('./inventory.service');

class InventoryController {

    /* =========================================================
       1. INVENTORY SUMMARY
       GET /api/inventory

       Lấy tồn kho tổng hợp theo sản phẩm.
    ========================================================= */
    async getAll(req, res) {
        try {
            const data = await inventoryService.getAllInventory();

            return res.json({
                success: true,
                data
            });

        } catch (error) {
            return res.status(500).json({
                success: false,
                message: error.message
            });
        }
    }

    /* =========================================================
       2. INVENTORY DETAILS
       GET /api/inventory/details

       Lấy tồn kho chi tiết theo từng lô hàng.
    ========================================================= */
    async getDetails(req, res) {
        try {
            const data = await inventoryService.getDetails();

            return res.json({
                success: true,
                data
            });

        } catch (error) {
            return res.status(500).json({
                success: false,
                message: error.message
            });
        }
    }

    /* =========================================================
       3. INVENTORY BY ID
       GET /api/inventory/:id

       Lấy chi tiết một dòng tồn kho theo InventoryID.
    ========================================================= */
    async getById(req, res) {
        try {
            const data = await inventoryService.getInventoryById(
                req.params.id
            );

            return res.json({
                success: true,
                data
            });

        } catch (error) {
            return res.status(404).json({
                success: false,
                message: error.message
            });
        }
    }

    /* =========================================================
       4. SEARCH INVENTORY
       GET /api/inventory/search

       Tìm kiếm tồn kho.
    ========================================================= */
    async search(req, res) {
        try {
            const filters = {
                productName: req.query.name,
                sku: req.query.sku,
                batchNumber: req.query.batch,
                warehouseId: req.query.warehouseId,
                isExpired: req.query.isExpired === 'true'
            };

            const data = await inventoryService.getWarehouseStock(filters);

            return res.json({
                success: true,
                data
            });

        } catch (error) {
            return res.status(500).json({
                success: false,
                message: error.message
            });
        }
    }

    /* =========================================================
       5. CONFIRM EXPORT
       POST /api/inventory/confirm-export/:orderId

       Thủ kho xác nhận xuất kho thực tế cho đơn hàng.
    ========================================================= */
    async confirmExport(req, res) {
        try {
            const { orderId } = req.params;

            if (!orderId) {
                return res.status(400).json({
                    success: false,
                    message: 'Thiếu orderId'
                });
            }

            const result = await inventoryService.confirmOrderExport(
                orderId,
                req.user.id
            );

            return res.status(200).json(result);

        } catch (error) {
            console.error('❌ Export Error:', error.message);

            return res.status(400).json({
                success: false,
                message: error.message
            });
        }
    }

    /* =========================================================
       6. PRODUCT LOTS
       GET /api/inventory/lots/:productId

       Lấy danh sách lô tồn kho theo sản phẩm.
    ========================================================= */
    async getLots(req, res) {
        try {
            const data = await inventoryService.getLotsByProduct(
                req.params.productId
            );

            return res.json({
                success: true,
                data
            });

        } catch (err) {
            return res.status(500).json({
                success: false,
                message: err.message
            });
        }
    }

    /* =========================================================
       7. GOODS RECEIPTS - CREATE
       POST /api/inventory/goods-receipts

       Warehouse tạo phiếu nhận hàng thực tế từ PO.

       Hỗ trợ 2 kiểu request:

       1. JSON thường:
          req.body = {
              purchase_order_id,
              note,
              items
          }

       2. multipart/form-data:
          req.body.payload = JSON.stringify(...)
          req.files = ảnh hàng lỗi từ multer

       Ảnh hàng lỗi sẽ được service map theo field:
       fault_images_${purchase_order_detail_id}

       Ví dụ:
       fault_images_15
    ========================================================= */
    async createGoodsReceipt(req, res) {
        try {
            let payload = req.body;

            /*
               Khi frontend gửi FormData:
               formData.append('payload', JSON.stringify(payload))

               Khi đó:
               - dữ liệu phiếu nằm trong req.body.payload
               - ảnh nằm trong req.files
            */
            if (req.body && req.body.payload) {
                try {
                    payload = JSON.parse(req.body.payload);
                } catch (parseError) {
                    return res.status(400).json({
                        success: false,
                        message: 'Payload không hợp lệ'
                    });
                }
            }

            const result = await inventoryService.createGoodsReceipt(
                payload,
                req.user.id,
                req.files || []
            );

            return res.status(201).json({
                success: true,
                message: 'Tạo phiếu nhận hàng thành công',
                data: result
            });

        } catch (error) {
            console.error('CREATE GOODS RECEIPT ERROR:', error);

            return res.status(400).json({
                success: false,
                message: error.message
            });
        }
    }

    /* =========================================================
       8. GOODS RECEIPTS - LIST
       GET /api/inventory/goods-receipts

       Lấy danh sách phiếu nhận hàng.

       Dùng cho:
       - Warehouse xem lịch sử nhập hàng.
       - Product Manager xem phiếu có hàng lỗi.
       - Product Manager xem phiếu đang chờ xử lý lỗi.

       Filter:
       - ?has_rejected_items=1
       - ?issue_status=WAITING_REVIEW
       - ?issue_status=EMAIL_SENT
       - ?issue_status=RESOLVED
    ========================================================= */
    async getGoodsReceipts(req, res) {
        try {
            const data = await inventoryService.getGoodsReceipts(req.query);

            return res.json({
                success: true,
                data
            });

        } catch (error) {
            return res.status(500).json({
                success: false,
                message: error.message
            });
        }
    }

    /* =========================================================
       9. GOODS RECEIPTS - DETAIL
       GET /api/inventory/goods-receipts/:id

       Lấy chi tiết một phiếu nhận hàng.

       Product Manager dùng để xem:
       - Sản phẩm lỗi
       - Số lượng lỗi
       - Lý do lỗi
       - Ảnh hàng lỗi trong fault_images
    ========================================================= */
    async getGoodsReceiptById(req, res) {
        try {
            const data = await inventoryService.getGoodsReceiptById(
                req.params.id
            );

            return res.json({
                success: true,
                data
            });

        } catch (error) {
            return res.status(404).json({
                success: false,
                message: error.message
            });
        }
    }

    /* =========================================================
       10. GOODS RECEIPT ISSUE EMAIL
       POST /api/inventory/goods-receipts/:id/send-issue-email

       Product Manager gửi email thông báo hàng lỗi cho nhà cung cấp.

       Luồng:
       1. Product Manager mở chi tiết phiếu có hàng lỗi.
       2. Bấm gửi email cho nhà cung cấp.
       3. Service lấy:
          - receipt header
          - supplier_email
          - items có rejected_quantity > 0
          - fault_images để đính kèm email
       4. Gửi email.
       5. Cập nhật:
          - issue_status = EMAIL_SENT
          - issue_email_sent_at = NOW()
          - issue_email_sent_by = req.user.id
    ========================================================= */
    async sendGoodsReceiptIssueEmail(req, res) {
        try {
            const result = await inventoryService.sendGoodsReceiptIssueEmail(
                req.params.id,
                req.user.id
            );

            return res.status(200).json({
                success: true,
                message: 'Đã gửi email thông báo hàng lỗi cho nhà cung cấp',
                data: result
            });

        } catch (error) {
            console.error('SEND GOODS RECEIPT ISSUE EMAIL ERROR:', error);

            return res.status(400).json({
                success: false,
                message: error.message
            });
        }
    }

/* =========================================================
    20. Warehouse - GET DASHBOARD
========================================================= */
    async getWarehouseDashboard(req, res) {
        try {
            // Giả sử đây là logic bạn lấy dữ liệu từ service của bạn
            const summary = await inventoryService.getDashboardSummary(); 
            const activeOrders = await inventoryService.getRecentShippingOrders();

            // ÉP CHẶT cấu trúc dữ liệu trả về cho View
            return res.render('pages/warehouse/dashboard', { 
                // Bắt buộc phải là key 'stats' viết thường
                stats: {
                    totalProducts: summary?.totalProducts || 0,
                    expiringSoonCount: summary?.expiringSoon || 0,
                    shippingOrdersCount: summary?.pendingOrders || 0,
                    pendingReceiptsCount: summary?.pendingReceipts || 0
                },
                // Bắt buộc phải là key 'orders' viết thường
                orders: activeOrders || [] 
            });

        } catch (error) {
            console.error("Lỗi tại getWarehouseDashboard Controller:", error);
            return res.status(500).send("Lỗi tải trang dashboard");
        }
    }

    async getAll(req, res) {
        try {
            const data = await inventoryService.getAllInventory();

            return res.json({
                success: true,
                data
            });

        } catch (error) {
            return res.status(500).json({
                success: false,
                message: error.message
            });
        }
    }


        /* =========================================================
       5. IMPORT GOODS ---
       POST /api/inventory/import

       Nhập kho trực tiếp, tăng tồn thực tế.
       Giữ lại để không ảnh hưởng logic cũ.
    ========================================================= */

    async importGoods(req, res) {
        try {
            const result = await inventoryService.processImport({
                productId: req.body.productId,
                quantity: req.body.quantity,
                batchNumber: req.body.batchNumber,
                expiryDate: req.body.expiryDate,
                userId: req.user.id,
                note: req.body.note
            });

            return res.json({
                success: true,
                data: result
            });

        } catch (error) {
            return res.status(400).json({
                success: false,
                message: error.message
            });
        }
    }


    /* =========================================================
       6. EXPORT GOODS ----
       POST /api/inventory/export

       Xuất kho trực tiếp.
       Giữ lại để không ảnh hưởng logic cũ.
    ========================================================= */

    async exportGoods(req, res) {
        try {
            const result = await inventoryService.processExport({
                ...req.body,
                userId: req.user.id
            });

            return res.json({
                success: true,
                message: 'Xác nhận xuất kho thành công',
                data: result
            });

        } catch (error) {
            return res.status(400).json({
                success: false,
                message: error.message
            });
        }
    }
        /* =========================================================
       STOCKTAKE - GET INVENTORY ITEMS
       GET /api/inventory/stocktakes/inventory-items
    ========================================================= */
    async getStocktakeInventoryItems(req, res) {
        try {
            const data = await inventoryService.getStocktakeInventoryItems({
                categoryId: req.query.category_id,
                categoryName: req.query.category_name,
                sku: req.query.sku,
                keyword: req.query.keyword
            });

            return res.json({
                success: true,
                data
            });

        } catch (error) {
            return res.status(500).json({
                success: false,
                message: error.message
            });
        }
    }


    /* =========================================================
       STOCKTAKE - LIST
       GET /api/inventory/stocktakes
    ========================================================= */
    async getStocktakes(req, res) {
        try {
            const data = await inventoryService.getStocktakes({
                status: req.query.status,
                fromDate: req.query.from_date,
                toDate: req.query.to_date,
                keyword: req.query.keyword
            });

            return res.json({
                success: true,
                data
            });

        } catch (error) {
            return res.status(500).json({
                success: false,
                message: error.message
            });
        }
    }


    /* =========================================================
       STOCKTAKE - DETAIL
       GET /api/inventory/stocktakes/:id
    ========================================================= */
    async getStocktakeById(req, res) {
        try {
            const data = await inventoryService.getStocktakeById(req.params.id);

            return res.json({
                success: true,
                data
            });

        } catch (error) {
            return res.status(404).json({
                success: false,
                message: error.message
            });
        }
    }

    /* =========================================================
    STOCKTAKE - CREATE
    POST /api/inventory/stocktakes

    Hỗ trợ:
    1. JSON thường:
        req.body = { stocktake_date, items, submit }

    2. multipart/form-data:
        req.body.payload = JSON.stringify(...)
        req.files = ảnh kiểm kê

    Frontend gửi ảnh theo field:
    stocktake_image_0
    stocktake_image_1
    stocktake_image_2
    ========================================================= */
    async createStocktake(req, res) {
        try {
            let payload = req.body;

            if (req.body && req.body.payload) {
                try {
                    payload = JSON.parse(req.body.payload);
                } catch (parseError) {
                    return res.status(400).json({
                        success: false,
                        message: 'Payload kiểm kê không hợp lệ'
                    });
                }
            }

            const files = Array.isArray(req.files) ? req.files : [];

            if (Array.isArray(payload.items)) {
                payload.items = payload.items.map((item, index) => {
                    const imageFieldName = `stocktake_images_${index}`;

                    const matchedFiles = files
                        .filter(file => file.fieldname === imageFieldName)
                        .slice(0, 5);

                    const imageUrls = matchedFiles.map(file => {
                        return `/images/uploads/stocktakes/${file.filename}`;
                    });

                    return {
                        ...item,
                        image_url: imageUrls.length
                            ? JSON.stringify(imageUrls)
                            : item.image_url || null
                    };
                });
            }

            const data = await inventoryService.createStocktake(
                payload,
                req.user.id
            );

            return res.status(201).json({
                success: true,
                message: payload.submit === true
                    ? 'Tạo và gửi duyệt phiếu kiểm kê thành công'
                    : 'Lưu nháp phiếu kiểm kê thành công',
                data
            });

        } catch (error) {
            console.error('CREATE STOCKTAKE ERROR:', error);

            return res.status(400).json({
                success: false,
                message: error.message
            });
        }
    }


    /* =========================================================
       STOCKTAKE - SUBMIT
       POST /api/inventory/stocktakes/:id/submit
    ========================================================= */
    async submitStocktake(req, res) {
        try {
            const data = await inventoryService.submitStocktake(
                req.params.id,
                req.user.id
            );

            return res.json({
                success: true,
                message: 'Gửi duyệt phiếu kiểm kê thành công',
                data
            });

        } catch (error) {
            return res.status(400).json({
                success: false,
                message: error.message
            });
        }
    }


    /* =========================================================
       STOCKTAKE - APPROVE
       POST /api/inventory/stocktakes/:id/approve
    ========================================================= */
    async approveStocktake(req, res) {
        try {
            const data = await inventoryService.approveStocktake(
                req.params.id,
                req.user.id
            );

            return res.json({
                success: true,
                message: 'Duyệt phiếu kiểm kê và cập nhật tồn kho thành công',
                data
            });

        } catch (error) {
            return res.status(400).json({
                success: false,
                message: error.message
            });
        }
    }


    /* =========================================================
       STOCKTAKE - REJECT
       POST /api/inventory/stocktakes/:id/reject
    ========================================================= */
    async rejectStocktake(req, res) {
        try {
            const data = await inventoryService.rejectStocktake(
                req.params.id,
                req.user.id,
                req.body.reason
            );

            return res.json({
                success: true,
                message: 'Từ chối phiếu kiểm kê thành công',
                data
            });

        } catch (error) {
            return res.status(400).json({
                success: false,
                message: error.message
            });
        }
    }

    async getProductInventorySummary(req, res, next) {
    try {
        const data = await inventoryService.getProductInventorySummary(req.query);

        return res.json({
            success: true,
            message: 'Lấy danh sách tồn kho sản phẩm thành công',
            data
        });
    } catch (error) {
        next(error);
    }
}

async getProductInventoryLogs(req, res, next) {
    try {
        const { productId } = req.params;

        const data = await inventoryService.getProductInventoryLogs(
            productId,
            req.query
        );

        return res.json({
            success: true,
            message: 'Lấy lịch sử nhập/xuất kho của sản phẩm thành công',
            data
        });
    } catch (error) {
        next(error);
    }
}

}

module.exports = new InventoryController();