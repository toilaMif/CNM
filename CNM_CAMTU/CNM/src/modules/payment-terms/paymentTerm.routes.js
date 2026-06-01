const express = require('express');
const router = express.Router();

const paymentTermController = require('./paymentTerm.controller');

const {
  verifyAccessToken
} = require('../../core/middlewares/auth.middleware');

const {
  authorizeRoles
} = require('../../core/middlewares/role.middleware');

const uploadPromotionImages = require('../../core/middlewares/uploadPromotion.middleware');

/* =========================================================
   PUBLIC HOME PROMOTIONS
   GET /api/payment-terms/home-promotions
========================================================= */
router.get(
  '/home-promotions',
  paymentTermController.findHomePromotions
);

/* =========================================================
   SALE GET ACTIVE TERMS
   GET /api/payment-terms
========================================================= */
router.get(
  '/',
  verifyAccessToken,
  authorizeRoles('SALE', 'PRODUCT_MANAGER', 'MANAGER', 'ADMIN'),
  paymentTermController.findAllActive
);

/* =========================================================
   MANAGER GET ALL TERMS
   GET /api/payment-terms/all
========================================================= */
router.get(
  '/all',
  verifyAccessToken,
  authorizeRoles('PRODUCT_MANAGER', 'MANAGER', 'ADMIN'),
  paymentTermController.findAll
);

/* =========================================================
   GET DETAIL
   GET /api/payment-terms/:id
========================================================= */
router.get(
  '/:id',
  verifyAccessToken,
  authorizeRoles('PRODUCT_MANAGER', 'MANAGER', 'ADMIN'),
  paymentTermController.findById
);

/* =========================================================
   CREATE WITH IMAGE UPLOAD
   POST /api/payment-terms

   FormData fields:
   - image_file
   - banner_file
========================================================= */
router.post(
  '/',
  verifyAccessToken,
  authorizeRoles('PRODUCT_MANAGER', 'MANAGER', 'ADMIN'),
  uploadPromotionImages.fields([
    { name: 'image_file', maxCount: 1 },
    { name: 'banner_file', maxCount: 1 }
  ]),
  paymentTermController.create
);

/* =========================================================
   UPDATE WITH IMAGE UPLOAD
   PUT /api/payment-terms/:id

   FormData fields:
   - image_file
   - banner_file
========================================================= */
router.put(
  '/:id',
  verifyAccessToken,
  authorizeRoles('PRODUCT_MANAGER', 'MANAGER', 'ADMIN'),
  uploadPromotionImages.fields([
    { name: 'image_file', maxCount: 1 },
    { name: 'banner_file', maxCount: 1 }
  ]),
  paymentTermController.update
);

/* =========================================================
   UPDATE ACTIVE STATUS
   PATCH /api/payment-terms/:id/status
========================================================= */
router.patch(
  '/:id/status',
  verifyAccessToken,
  authorizeRoles('PRODUCT_MANAGER', 'MANAGER', 'ADMIN'),
  paymentTermController.updateStatus
);

/* =========================================================
   UPDATE HOME DISPLAY
   PATCH /api/payment-terms/:id/home-display
========================================================= */
router.patch(
  '/:id/home-display',
  verifyAccessToken,
  authorizeRoles('PRODUCT_MANAGER', 'MANAGER', 'ADMIN'),
  paymentTermController.updateHomeDisplay
);

/* =========================================================
   UPDATE SALE VISIBILITY
   PATCH /api/payment-terms/:id/sale-visibility
========================================================= */
router.patch(
  '/:id/sale-visibility',
  verifyAccessToken,
  authorizeRoles('PRODUCT_MANAGER', 'MANAGER', 'ADMIN'),
  paymentTermController.updateSaleVisibility
);

/* =========================================================
   DELETE / DEACTIVATE
   DELETE /api/payment-terms/:id
========================================================= */
router.delete(
  '/:id',
  verifyAccessToken,
  authorizeRoles('PRODUCT_MANAGER', 'MANAGER', 'ADMIN'),
  paymentTermController.deactivate
);

module.exports = router;