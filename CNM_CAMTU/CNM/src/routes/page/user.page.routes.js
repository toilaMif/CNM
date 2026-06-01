module.exports = (app) => {

  console.log('authRoutes:', authRoutes);
  console.log('userRoutes:', userRoutes);
  console.log('productRoutes:', productRoutes);

  console.log('authPageRoutes:', authPageRoutes);
  console.log('userPageRoutes:', userPageRoutes);
  console.log('adminPageRoutes:', adminPageRoutes);

  app.use('/api/auth', authRoutes);
  app.use('/api/users', userRoutes);
  app.use('/api/products', productRoutes);

  app.use('/', authPageRoutes);
  app.use('/', userPageRoutes);
  app.use('/admin', adminPageRoutes);
};const express = require('express');
const router = express.Router();

const {verifyPageAuth} = require('../../core/middlewares/verifyPageAuth.middleware');

/* =========================================================
   USER DASHBOARD
========================================================= */
router.get(
  '/dashboard',
  verifyPageAuth,
  (req, res) => {

    res.render('/user/dashboard', {
      title: 'User Dashboard',
      user: req.user
    });

  }
);

/* =========================================================
   CHANGE PASSWORD PAGE
========================================================= */
router.get(
  '/change-password',
  verifyPageAuth,
  (req, res) => {

    res.render('/user/change-password', {
      title: 'Change Password',
      user: req.user,
      error: null,
      success: null
    });

  }
);

/* =========================================================
   USER SETTINGS
========================================================= */
router.get(
  '/settings',
  verifyPageAuth,
  (req, res) => {

    res.render('/user/settings', {
      title: 'Settings',
      user: req.user
    });

  }
);

module.exports = router;