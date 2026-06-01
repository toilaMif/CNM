const express = require('express');
const router = express.Router();

const paymentController = require('./payment.controller');

const {
  verifyAccessToken
} = require('../../core/middlewares/auth.middleware');

const {
  authorizeRoles
} = require('../../core/middlewares/role.middleware');

/* =========================================================
   Tạo đợt thanh toán
   POST /api/payments/orders/:orderId/installments
========================================================= */

router.post(
  '/orders/:orderId/installments',
  verifyAccessToken,
  authorizeRoles('SALE', 'ADMIN', 'MANAGER'),
  paymentController.createPaymentInstallment
);

/* =========================================================
   Xem các đợt thanh toán của đơn hàng
   GET /api/payments/orders/:orderId/installments
========================================================= */

router.get(
  '/orders/:orderId/installments',
  verifyAccessToken,
  authorizeRoles('SALE', 'ADMIN', 'MANAGER'),
  paymentController.getOrderInstallments
);

/* =========================================================
   Webhook SePay
   POST /api/payments/webhook

   Không dùng JWT.
   SePay không có access token của user hệ thống.
========================================================= */

router.post(
  '/webhook',
  paymentController.handlePaymentWebhook
);

module.exports = router;