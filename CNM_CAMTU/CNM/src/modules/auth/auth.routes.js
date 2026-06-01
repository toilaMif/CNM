const express = require('express');
const router = express.Router();

const authController = require('./auth.controller');

const { verifyAccessToken } = require('../../core/middlewares/auth.middleware');
const { validateAuth, validateChangePassword } = require('../../core/middlewares/validate.middleware');

/* ================= AUTH ================= */

router.post('/login', validateAuth, authController.login);

router.post('/refresh', authController.refresh);

router.post('/logout', authController.logout);

router.post(
  '/change-password',
  verifyAccessToken,
  validateChangePassword,
  authController.changePassword
);

module.exports = router;