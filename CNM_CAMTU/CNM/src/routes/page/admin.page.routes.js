const express = require('express');
const router = express.Router();


const userController = require('../../modules/users/user.controller');

const { verifyPageAuth } = require('../../core/middlewares/verifyPageAuth.middleware');
const { authorizeRoles } = require('../../core/middlewares/role.middleware');

/* =========================================================
   ADMIN GUARD
========================================================= */

const adminGuard = [
  verifyPageAuth,
  authorizeRoles('ADMIN')
];

/* =========================================================
   APPLY GLOBAL GUARD
========================================================= */

router.use(adminGuard);

/* =========================================================
   PAGE VALIDATION MIDDLEWARE
========================================================= */

function validateUserId(req, res, next) {
  const { id } = req.params;

  if (!id || isNaN(Number(id))) {
    return res.redirect('/admin/users');
  }

  next();
}

/* =========================================================
   ADMIN DASHBOARD
   GET /admin/dashboard
========================================================= */

router.get('/dashboard', (req, res) => {
  res.render('admin/layout', {
    title: 'Dashboard',
    user: req.user,
    activeMenu: 'dashboard',
    currentPage: 'admin.dashboard',

    pageClass: 'admin-dashboard-page',
    pageView: './dashboard',

    pageCss: '/css/pages/admin/dashboard.css',
    pageJs: '/js/pages/admin/dashboard.js'
  });
});

/* =========================================================
   USER MANAGEMENT
   GET /admin/users
========================================================= */

router.get('/users', (req, res) => {
  res.render('admin/layout', {
    title: 'Quản lý tài khoản',
    user: req.user,
    activeMenu: 'users',
    currentPage: 'admin.users',

    pageClass: 'admin-users-page',
    pageView: './users',

    pageCss: '/css/pages/admin/users.css',
    pageJs: '/js/pages/admin/users.js'
  });
});

/* =========================================================
   CREATE USER
   GET /admin/users/create
========================================================= */

router.get('/users/create', (req, res) => {
  res.render('admin/layout', {
    title: 'Tạo tài khoản mới',
    user: req.user,
    activeMenu: 'users',
    currentPage: 'admin.users',

    pageClass: 'admin-create-user-page',
    pageView: './create-user',

    pageCss: '/css/pages/admin/create-user.css',
    pageJs: '/js/pages/admin/create-user.js'
  });
});

/* =========================================================
   EDIT USER
   GET /admin/users/edit/:id
========================================================= */

router.get('/users/edit/:id', validateUserId, (req, res) => {
  res.render('admin/layout', {
    title: 'Chỉnh sửa tài khoản',
    user: req.user,
    userId: req.params.id,
    activeMenu: 'users',
    currentPage: 'admin.users',

    pageClass: 'admin-edit-user-page',
    pageView: './edit-user',

    pageCss: '/css/pages/admin/edit-user.css',
    pageJs: '/js/pages/admin/edit-user.js'
  });
});

/* =========================================================
   ROLES
   GET /admin/roles
========================================================= */

router.get('/roles', (req, res) => {
  res.render('admin/layout', {
    title: 'Phân quyền',
    user: req.user,
    activeMenu: 'roles',
    currentPage: 'admin.roles',

    pageClass: 'admin-roles-page',
    pageView: './roles',

    pageCss: '/css/pages/admin/roles.css',
    pageJs: '/js/pages/admin/roles.js'
  });
});

/* =========================================================
   SETTINGS
   GET /admin/settings
========================================================= */

router.get('/settings', (req, res) => {
  res.render('admin/layout', {
    title: 'Cài đặt',
    user: req.user,
    activeMenu: 'settings',
    currentPage: 'admin.settings',

    pageClass: 'admin-settings-page',
    pageView: './settings',

    pageCss: '/css/pages/admin/settings.css',
    pageJs: '/js/pages/admin/settings.js'
  });
});


router.get('/profile', userController.profilePage);

module.exports = router;