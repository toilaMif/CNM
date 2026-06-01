const express = require('express');
const router = express.Router();

const inventoryController = require('./inventory.controller');

const { verifyAccessToken } = require('../../core/middlewares/auth.middleware');
const { authorizeRoles } = require('../../core/middlewares/role.middleware');
const { uploadStocktakeImages } = require('../../core/middlewares/uploadStocktakeImages.middleware');
const { uploadGoodsReceiptImages } = require('../../core/middlewares/uploadGoodsReceiptImages.middleware');

/* =========================================================
   INVENTORY ROUTES

   Lưu ý:
   - Route cụ thể phải đặt trước route động /:id.
   - Goods Receipt thuộc module inventory.
   - Kiểm kê kho vật tư đặt trước /:id.
========================================================= */


/* =========================================================
   NHÓM 0: DASHBOARD
========================================================= */

router.get(
    '/dashboard',
    verifyAccessToken,
    authorizeRoles('ADMIN', 'MANAGER', 'WAREHOUSE_EMPLOYEE'),
    inventoryController.getWarehouseDashboard
);


/* =========================================================
   NHÓM 1: GOODS RECEIPTS / PHIẾU NHẬN HÀNG
========================================================= */

router.get(
    '/goods-receipts',
    verifyAccessToken,
    authorizeRoles('ADMIN', 'MANAGER', 'WAREHOUSE_EMPLOYEE', 'PRODUCT_MANAGER'),
    inventoryController.getGoodsReceipts
);

router.post(
    '/goods-receipts',
    verifyAccessToken,
    authorizeRoles('WAREHOUSE_EMPLOYEE', 'ADMIN'),
    uploadGoodsReceiptImages.any(),
    inventoryController.createGoodsReceipt
);

router.post(
    '/goods-receipts/:id/send-issue-email',
    verifyAccessToken,
    authorizeRoles('PRODUCT_MANAGER', 'ADMIN'),
    inventoryController.sendGoodsReceiptIssueEmail
);

router.get(
    '/goods-receipts/:id',
    verifyAccessToken,
    authorizeRoles('ADMIN', 'MANAGER', 'WAREHOUSE_EMPLOYEE', 'PRODUCT_MANAGER'),
    inventoryController.getGoodsReceiptById
);


/* =========================================================
   NHÓM 2: KIỂM KÊ KHO VẬT TƯ
   Warehouse tạo phiếu.
   Product Manager duyệt / từ chối.
   Phải đặt trước /:id.
========================================================= */

// Lấy danh sách vật tư/lô hàng để tạo phiếu kiểm kê
router.get(
    '/stocktakes/inventory-items',
    verifyAccessToken,
    authorizeRoles('ADMIN', 'MANAGER', 'WAREHOUSE_EMPLOYEE', 'PRODUCT_MANAGER'),
    inventoryController.getStocktakeInventoryItems
);

// Xem danh sách phiếu kiểm kê
router.get(
    '/stocktakes',
    verifyAccessToken,
    authorizeRoles('ADMIN', 'MANAGER', 'WAREHOUSE_EMPLOYEE', 'PRODUCT_MANAGER'),
    inventoryController.getStocktakes
);

router.post(
    '/stocktakes',
    verifyAccessToken,
    authorizeRoles('WAREHOUSE_EMPLOYEE', 'ADMIN'),
    uploadStocktakeImages.any(),
    inventoryController.createStocktake
);

// Warehouse gửi phiếu nháp sang duyệt
router.post(
    '/stocktakes/:id/submit',
    verifyAccessToken,
    authorizeRoles('WAREHOUSE_EMPLOYEE', 'ADMIN'),
    inventoryController.submitStocktake
);

// Product Manager duyệt phiếu kiểm kê
router.post(
    '/stocktakes/:id/approve',
    verifyAccessToken,
    authorizeRoles('PRODUCT_MANAGER', 'ADMIN'),
    inventoryController.approveStocktake
);

// Product Manager từ chối phiếu kiểm kê
router.post(
    '/stocktakes/:id/reject',
    verifyAccessToken,
    authorizeRoles('PRODUCT_MANAGER', 'ADMIN'),
    inventoryController.rejectStocktake
);

// Xem chi tiết phiếu kiểm kê
router.get(
    '/stocktakes/:id',
    verifyAccessToken,
    authorizeRoles('ADMIN', 'MANAGER', 'WAREHOUSE_EMPLOYEE', 'PRODUCT_MANAGER'),
    inventoryController.getStocktakeById
);


/* =========================================================
   NHÓM 3: TRA CỨU TỒN KHO
========================================================= */

router.get(
    '/details',
    verifyAccessToken,
    authorizeRoles('ADMIN', 'MANAGER', 'WAREHOUSE_EMPLOYEE', 'SALE', 'PRODUCT_MANAGER'),
    inventoryController.getDetails
);

router.get(
    '/lots/:productId',
    verifyAccessToken,
    authorizeRoles('ADMIN', 'MANAGER', 'WAREHOUSE_EMPLOYEE', 'SALE', 'PRODUCT_MANAGER'),
    inventoryController.getLots
);

router.get(
    '/search',
    verifyAccessToken,
    authorizeRoles('ADMIN', 'MANAGER', 'WAREHOUSE_EMPLOYEE'),
    inventoryController.search
);


/* =========================================================
   NHÓM 4: NGHIỆP VỤ NHẬP / XUẤT KHO
========================================================= */

router.post(
    '/confirm-export/:orderId',
    verifyAccessToken,
    authorizeRoles('WAREHOUSE_EMPLOYEE', 'ADMIN'),
    inventoryController.confirmExport
);

router.post(
    '/import',
    verifyAccessToken,
    authorizeRoles('WAREHOUSE_EMPLOYEE'),
    inventoryController.importGoods
);

router.post(
    '/export',
    verifyAccessToken,
    authorizeRoles('WAREHOUSE_EMPLOYEE'),
    inventoryController.exportGoods
);


/* =========================================================
   NHÓM 5: TỒN KHO CƠ BẢN
========================================================= */

router.get(
    '/',
    verifyAccessToken,
    authorizeRoles('ADMIN', 'MANAGER', 'WAREHOUSE_EMPLOYEE', 'SALE', 'PRODUCT_MANAGER'),
    inventoryController.getAll
);

router.get(
    '/products/inventory-summary',
    verifyAccessToken,
    authorizeRoles(['ADMIN', 'MANAGER', 'WAREHOUSE_EMPLOYEE', 'PRODUCT_MANAGER']),
    inventoryController.getProductInventorySummary
);

router.get(
    '/products/:productId/inventory-logs',
    verifyAccessToken,
    authorizeRoles(['ADMIN', 'MANAGER', 'WAREHOUSE_EMPLOYEE', 'PRODUCT_MANAGER']),
    inventoryController.getProductInventoryLogs
);
/* =========================================================
   NHÓM 6: ROUTE ĐỘNG
   Luôn để cuối cùng.
========================================================= */

router.get(
    '/:id',
    verifyAccessToken,
    authorizeRoles('ADMIN', 'MANAGER', 'WAREHOUSE_EMPLOYEE', 'SALE', 'PRODUCT_MANAGER'),
    inventoryController.getById
);

module.exports = router;