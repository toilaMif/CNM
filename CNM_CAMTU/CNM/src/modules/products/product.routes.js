const express = require('express');

const router = express.Router();

const productController = require('./product.controller');

const {
  verifyAccessToken
} = require('../../core/middlewares/auth.middleware');

const {
  authorizeRoles
} = require('../../core/middlewares/role.middleware');

const uploadProductImage = require('../../core/middlewares/uploadProductImage.middleware');

/* =========================================================
   PUBLIC ROUTES
   Không cần đăng nhập
========================================================= */

/* =========================================================
   CATEGORY WITH PRODUCTS
   GET /api/products/categories-with-products
========================================================= */
router.get(
  '/categories-with-products',
  productController.getCategoriesWithProducts
);

/* =========================================================
   SEARCH
   GET /api/products/search?q=...
========================================================= */
router.get(
  '/search',
  productController.search
);

/* =========================================================
   CATEGORY FILTER
   GET /api/products/category/:id
========================================================= */
router.get(
  '/category/:id',
  productController.getByCategory
);

/* =========================================================
   ACTIVE PRODUCT BANNER
   GET /api/products/banner/active

   Public:
   - Customer home lấy banner quảng cáo
========================================================= */
router.get(
  '/banner/active',
  productController.getActiveBanner
);

/* =========================================================
   PROTECTED STATIC ROUTES
   Các route cụ thể phải đặt trước /:id
========================================================= */

/* =========================================================
   PRODUCT MANAGER DASHBOARD
   GET /api/products/dashboard

   Role:
   - PRODUCT_MANAGER
   - MANAGER
========================================================= */
router.get(
  '/dashboard',
  verifyAccessToken,
  authorizeRoles(
    'PRODUCT_MANAGER',
    'MANAGER'
  ),
  productController.getDashboard
);

/* =========================================================
   GET CATEGORIES
   GET /api/products/categories

   Role:
   - PRODUCT_MANAGER
   - WAREHOUSE_EMPLOYEE
   - SALE
   - MANAGER
========================================================= */
router.get(
  '/categories',
  verifyAccessToken,
  authorizeRoles(
    'PRODUCT_MANAGER',
    'WAREHOUSE_EMPLOYEE',
    'SALE',
    'MANAGER'
  ),
  productController.getCategories
);

/* =========================================================
   GET UNITS
   GET /api/products/units

   Role:
   - PRODUCT_MANAGER
   - WAREHOUSE_EMPLOYEE
   - SALE
   - MANAGER
========================================================= */
router.get(
  '/units',
  verifyAccessToken,
  authorizeRoles(
    'PRODUCT_MANAGER',
    'WAREHOUSE_EMPLOYEE',
    'SALE',
    'MANAGER'
  ),
  productController.getUnits
);

/* =========================================================
   GET STATUSES
   GET /api/products/statuses

   Role:
   - PRODUCT_MANAGER
   - WAREHOUSE_EMPLOYEE
   - SALE
   - MANAGER
========================================================= */
router.get(
  '/statuses',
  verifyAccessToken,
  authorizeRoles(
    'PRODUCT_MANAGER',
    'WAREHOUSE_EMPLOYEE',
    'SALE',
    'MANAGER'
  ),
  productController.getStatuses
);

/* =========================================================
   GET CROPS
   GET /api/products/crops

   Role:
   - PRODUCT_MANAGER
   - MANAGER
========================================================= */
router.get(
  '/crops',
  verifyAccessToken,
  authorizeRoles(
    'PRODUCT_MANAGER',
    'MANAGER'
  ),
  productController.getCrops
);

/* =========================================================
   GET PESTS
   GET /api/products/pests

   Role:
   - PRODUCT_MANAGER
   - MANAGER
========================================================= */
router.get(
  '/pests',
  verifyAccessToken,
  authorizeRoles(
    'PRODUCT_MANAGER',
    'MANAGER'
  ),
  productController.getPests
);

/* =========================================================
   GET TOXICITY LEVELS
   GET /api/products/toxicity-levels

   Role:
   - PRODUCT_MANAGER
   - MANAGER
========================================================= */
router.get(
  '/toxicity-levels',
  verifyAccessToken,
  authorizeRoles(
    'PRODUCT_MANAGER',
    'MANAGER'
  ),
  productController.getToxicityLevels
);

/* =========================================================
   GET PRODUCT BANNERS
   GET /api/products/banners

   Role:
   - PRODUCT_MANAGER
   - MANAGER
========================================================= */
router.get(
  '/banners',
  verifyAccessToken,
  authorizeRoles(
    'PRODUCT_MANAGER',
    'MANAGER'
  ),
  productController.getBanners
);

/* =========================================================
   UPDATE PRODUCT BANNER
   PUT /api/products/banners/:id

   Role:
   - PRODUCT_MANAGER
========================================================= */
router.put(
  '/banners/:id',
  verifyAccessToken,
  authorizeRoles(
    'PRODUCT_MANAGER'
  ),
  productController.updateBanner
);

/* =========================================================
   GET PRODUCTS
   GET /api/products

   Hiện tại đang public giống file cũ.
   Nếu muốn bảo vệ route này thì mở verifyAccessToken + authorizeRoles.
========================================================= */
router.get(
  '/',
  productController.getAll
);

/* =========================================================
   CREATE PRODUCT
   POST /api/products

   Role:
   - ADMIN
   - PRODUCT_MANAGER

   Lưu ý:
   - Frontend phải gửi multipart/form-data
   - Field file ảnh phải tên là image
========================================================= */
router.post(
  '/',
  verifyAccessToken,
  authorizeRoles(
    'ADMIN',
    'PRODUCT_MANAGER'
  ),
  uploadProductImage.single('image'),
  productController.createProduct
);

/* =========================================================
   UPDATE PRODUCT
   PUT /api/products/:id

   Role:
   - PRODUCT_MANAGER

   Lưu ý:
   - Có uploadProductImage.single('image') để sửa ảnh sản phẩm
   - Nếu không đổi ảnh, frontend nên gửi ImageID hiện tại
========================================================= */
router.put(
  '/:id',
  verifyAccessToken,
  authorizeRoles(
    'PRODUCT_MANAGER'
  ),
  uploadProductImage.single('image'),
  productController.updateProduct
);

/* =========================================================
   DELETE PRODUCT - SOFT DELETE
   DELETE /api/products/:id

   Role:
   - PRODUCT_MANAGER
========================================================= */
router.delete(
  '/:id',
  verifyAccessToken,
  authorizeRoles(
    'PRODUCT_MANAGER'
  ),
  productController.deleteProduct
);

/* =========================================================
   GET PRODUCT DETAIL
   GET /api/products/:id

   Lưu ý:
   - Route /:id phải để cuối cùng
========================================================= */
router.get(
  '/:id',
  productController.getById
);

module.exports = router;