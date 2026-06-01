const express = require('express');
const router = express.Router();

const userController = require('../../modules/users/user.controller');
const ordersService = require('../../modules/orders/order.service');

const { verifyPageAuth } = require('../../core/middlewares/verifyPageAuth.middleware');
const { authorizeRoles } = require('../../core/middlewares/role.middleware');

/* ======================================================
   SALE GUARD
====================================================== */

const saleGuard = [
  verifyPageAuth,
  authorizeRoles('SALE')
];

/* ======================================================
   APPLY GLOBAL GUARD
====================================================== */

router.use(saleGuard);

/* ======================================================
   DASHBOARD PAGE
   GET /sale/dashboard
====================================================== */

router.get('/dashboard', (req, res) => {
  res.render('sale/layout', {
    title: 'Dashboard Sale',
    user: req.user,
    activeMenu: 'dashboard',

    pageClass: 'sale-dashboard-page',
    pageView: './dashboard',

    pageCss: '/css/pages/sale/dashboard.css',
    pageJs: '/js/pages/sale/dashboard.js'
  });
});

/* ======================================================
   CUSTOMER MANAGER PAGE
   GET /sale/customer-manager
====================================================== */

router.get('/customer-manager', (req, res) => {
  res.render('sale/layout', {
    title: 'Quản lý khách hàng',
    user: req.user,
    activeMenu: 'customer-manager',

    pageClass: 'sale-customer-page',
    pageView: './customer-manager',

    pageCss: '/css/pages/sale/customer-manager.css',
    pageJs: '/js/pages/sale/customer-manager.js'
  });
});

/* ======================================================
   ORDER MANAGER PAGE
   GET /sale/order-manager
====================================================== */

router.get('/order-manager', async (req, res) => {
  try {
    const orders = await ordersService.findAll();

    let displayIdentifier = 'Nhân viên Sale';

    if (req.user) {
      if (req.user.email) {
        displayIdentifier = req.user.email;
      } else if (req.user.username) {
        displayIdentifier = req.user.username;
      } else {
        displayIdentifier = `${req.user.role_name}_${req.user.id}`;
      }
    }

    const currentUser = {
      id: req.user ? req.user.id : '',
      role_name: req.user ? req.user.role_name : '',
      email: req.user ? (req.user.email || '') : '',
      full_name: displayIdentifier
    };

    return res.render('sale/layout', {
      title: 'Quản lý đơn hàng',
      user: req.user,
      currentUser,
      activeMenu: 'order-manager',
      orders: orders || [],

      pageClass: 'sale-order-page',
      pageView: './order-manager',

      pageCss: '/css/pages/sale/order-manager.css',
      pageJs: '/js/pages/sale/order-manager.js'
    });

  } catch (err) {
    console.error('LỖI HỆ THỐNG TẠI ROUTE ORDER-MANAGER:', err);

    const currentUser = {
      id: req.user ? req.user.id : '',
      role_name: req.user ? req.user.role_name : '',
      email: req.user ? (req.user.email || '') : '',
      full_name: 'Nhân viên Sale'
    };

    return res.render('sale/layout', {
      title: 'Quản lý đơn hàng',
      user: req.user,
      currentUser,
      activeMenu: 'order-manager',
      orders: [],

      pageClass: 'sale-order-page',
      pageView: './order-manager',

      pageCss: '/css/pages/sale/order-manager.css',
      pageJs: '/js/pages/sale/order-manager.js'
    });
  }
});

/* ======================================================
   ORDER DETAIL API
   GET /sale/order/:id
====================================================== */

router.get('/order/:id', async (req, res) => {
  try {
    const order = await ordersService.findById(req.params.id);

    if (!order) {
      return res.status(404).json({
        success: false,
        message: 'Order not found'
      });
    }

    return res.json(order);

  } catch (err) {
    console.error(err);

    return res.status(500).json({
      success: false,
      message: 'Server error'
    });
  }
});

/* ======================================================
   PROFILE PAGE
   GET /sale/profile

   Không render sale/layout ở đây.
   Để userController.profilePage tự lấy user đầy đủ từ DB
   và tự chọn layout theo role.
====================================================== */

router.get('/profile', userController.profilePage);

module.exports = router;