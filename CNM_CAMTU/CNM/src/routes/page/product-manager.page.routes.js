const express = require('express');
const router = express.Router();

const userController = require('../../modules/users/user.controller');

const { verifyPageAuth } = require('../../core/middlewares/verifyPageAuth.middleware');
const { authorizeRoles } = require('../../core/middlewares/role.middleware');

const productService = require('../../modules/products/product.service');

/* =========================================================
   PRODUCT MANAGER GUARD
========================================================= */

const productManagerGuard = [
  verifyPageAuth,
  authorizeRoles('PRODUCT_MANAGER')
];

/* =========================================================
   APPLY GLOBAL GUARD
========================================================= */

router.use(productManagerGuard);

/* =========================================================
   DASHBOARD
   GET /product-manager/dashboard
========================================================= */

router.get('/dashboard', (req, res) => {
  res.render('product-manager/layout', {
    title: 'Dashboard quản lý sản phẩm',
    user: req.user,
    activeMenu: 'dashboard',

    pageClass: 'dashboard-page',
    pageView: './dashboard',

    pageCss: '/css/pages/product-manager/dashboard.css',
    pageJs: '/js/pages/product-manager/dashboard.js'
  });
});

/* =========================================================
   PRODUCT MANAGEMENT
   GET /product-manager/products
========================================================= */

router.get('/products', async (req, res) => {
  try {
    const categories = await productService.getCategoriesFromProducts();

    return res.render('product-manager/layout', {
      title: 'Quản lý sản phẩm',
      user: req.user,
      categories,
      activeMenu: 'products',

      pageClass: 'products-page',
      pageView: './products',

      pageCss: '/css/pages/product-manager/products.css',
      pageJs: '/js/pages/product-manager/products.js'
    });

  } catch (err) {
    console.error('❌ Product manager products page error:', err.message);

    return res.render('product-manager/layout', {
      title: 'Quản lý sản phẩm',
      user: req.user,
      categories: [],
      activeMenu: 'products',

      pageClass: 'products-page',
      pageView: './products',

      pageCss: '/css/pages/product-manager/products.css',
      pageJs: '/js/pages/product-manager/products.js'
    });
  }
});

/* =========================================================
   IMPORT / PROCUREMENT MANAGEMENT
   GET /product-manager/import-management
========================================================= */

router.get('/import-management', (req, res) => {
  res.render('product-manager/layout', {
    title: 'Quản lý nhập hàng',
    user: req.user,
    activeMenu: 'import-management',

    pageClass: 'import-management-page',
    pageView: './import-management',

    pageCss: '/css/pages/product-manager/import-management.css',
    pageJs: '/js/pages/product-manager/import-management.js'
  });
});

/* =========================================================
   GOODS RECEIPTS HISTORY
   GET /product-manager/goods-receipts
========================================================= */

router.get('/goods-receipts', (req, res) => {
  res.render('product-manager/layout', {
    title: 'Lịch sử phiếu nhận hàng',
    user: req.user,
    activeMenu: 'goods-receipts',

    pageClass: 'goods-receipts-page',
    pageView: './goods-receipts',

    pageCss: '/css/pages/product-manager/goods-receipts.css',
    pageJs: '/js/pages/product-manager/goods-receipts.js'
  });
});

/* =========================================================
   PAYMENT PROGRAM MANAGEMENT
   GET /product-manager/payment-program-management
========================================================= */

router.get('/payment-program-management', (req, res) => {
  res.render('product-manager/layout', {
    title: 'Quản lý chương trình khuyến mãi',
    user: req.user,
    activeMenu: 'payment-programs',

    pageClass: 'program-page',
    pageView: './payment-program-management',

    pageCss: '/css/pages/product-manager/payment-program-management.css',
    pageJs: '/js/pages/product-manager/payment-program-management.js'
  });
});

/* =========================================================
   STOCKTAKES APPROVAL
   GET /product-manager/stocktakes
========================================================= */

router.get('/stocktakes', (req, res) => {
  res.render('product-manager/layout', {
    title: 'Duyệt phiếu kiểm kê',
    user: req.user,
    activeMenu: 'stocktakes',

    pageClass: 'pm-stocktake-page',
    pageView: './stocktakes',

    pageCss: '/css/pages/product-manager/stocktakes.css',
    pageJs: '/js/pages/product-manager/stocktakes.js'
  });
});

/* =========================================================
   PROFILE
   GET /product-manager/profile
========================================================= */

router.get('/profile', userController.profilePage);

module.exports = router;