const express = require('express');
const router = express.Router();

const procurementController = require('./procurement.controller');

const { verifyAccessToken } = require('../../core/middlewares/auth.middleware');
const { authorizeRoles } = require('../../core/middlewares/role.middleware');

/* =========================================================
   SUPPLIERS
========================================================= */

/*
   Product Manager, Warehouse, Admin đều được xem supplier.
   Warehouse cần xem để nhận hàng sau này.
*/
router.get(
    '/suppliers',
    verifyAccessToken,
    authorizeRoles('PRODUCT_MANAGER', 'WAREHOUSE_EMPLOYEE', 'ADMIN'),
    procurementController.getSuppliers
);

/*
   Chỉ Product Manager/Admin được tạo supplier.
*/
router.post(
    '/suppliers',
    verifyAccessToken,
    authorizeRoles('PRODUCT_MANAGER', 'ADMIN'),
    procurementController.createSupplier
);


/* =========================================================
   PURCHASE ORDERS
========================================================= */

router.get(
    '/purchase-orders',
    verifyAccessToken,
    authorizeRoles('PRODUCT_MANAGER', 'WAREHOUSE_EMPLOYEE', 'ADMIN'),
    procurementController.getPurchaseOrders
);

router.post(
    '/purchase-orders',
    verifyAccessToken,
    authorizeRoles('PRODUCT_MANAGER', 'ADMIN'),
    procurementController.createPurchaseOrder
);

/* =========================================================
   PURCHASE ORDERS - PENDING RECEIVE
   Warehouse xem các PO đang chờ nhận hàng
========================================================= */
router.get(
    '/purchase-orders/pending-receive',
    verifyAccessToken,
    authorizeRoles('WAREHOUSE_EMPLOYEE', 'PRODUCT_MANAGER', 'ADMIN'),
    procurementController.getPendingReceivePurchaseOrders
);


/* =========================================================
   PURCHASE ORDERS - DETAIL
   Xem chi tiết 1 PO
========================================================= */
router.get(
    '/purchase-orders/:id',
    verifyAccessToken,
    authorizeRoles('WAREHOUSE_EMPLOYEE', 'PRODUCT_MANAGER', 'ADMIN'),
    procurementController.getPurchaseOrderById
);

module.exports = router;