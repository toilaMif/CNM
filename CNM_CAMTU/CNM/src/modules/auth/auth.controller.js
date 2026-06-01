const authService = require('./auth.service');

/* =========================================================
   COOKIE CONFIG
========================================================= */

const COOKIE_OPTIONS = {
  httpOnly: true,
  secure: process.env.NODE_ENV === 'production',
  sameSite: 'Lax',
  path: '/',
};

const ACCESS_COOKIE_OPTIONS = {
  ...COOKIE_OPTIONS,
  maxAge: 15 * 60 * 1000, // 15 phút
};

const REFRESH_COOKIE_OPTIONS = {
  ...COOKIE_OPTIONS,
  maxAge: 7 * 24 * 60 * 60 * 1000, // 7 ngày
};

/* =========================================================
   CONTROLLER
========================================================= */

const authController = {

  /* ================= LOGIN ================= */

  async login(req, res, next) {
    try {
      const { email, password } = req.body;

      if (!email || !password) {
        return res.status(400).json({
          success: false,
          message: "Email & password required"
        });
      }

      const data = await authService.login(email, password, req.ip);

      // handle service response
      if (!data.success) {
        return res.status(data.status).json({
          success: false,
          message: data.message
        });
      }

      res.cookie("accessToken", data.accessToken, ACCESS_COOKIE_OPTIONS);
      res.cookie("refreshToken", data.refreshToken, REFRESH_COOKIE_OPTIONS);

      return res.json({
        success: true,
        requireChangePassword: data.requireChangePassword,
        user: data.user
      });

    } catch (err) {
      console.error(err);

      return res.status(500).json({
        success: false,
        message: err.message
      });
    }
  },
  /* ================= CHANGE PASSWORD ================= */

  async changePassword(
    req,
    res,
    next
  ) {

    try {

      const {
        oldPassword,
        newPassword,
      } = req.body;

      await authService.changePassword(
        req.user.id,
        oldPassword,
        newPassword
      );

      return res.json({
        success: true,
        message: 'Password changed',
      });

    } catch (err) {

      next(err);
    }
  },

  /* ================= REFRESH TOKEN ================= */

  async refresh(req, res) {
    try {
      const token = req.cookies?.refreshToken;

      const data = await authService.refreshToken(token);

      if (!data.success) {
        res.clearCookie("accessToken");
        res.clearCookie("refreshToken");

        return res.status(data.status || 401).json({
          success: false,
          message: data.message || "Refresh token failed"
        });
      }

      res.cookie("accessToken", data.accessToken, ACCESS_COOKIE_OPTIONS);
      res.cookie("refreshToken", data.refreshToken, REFRESH_COOKIE_OPTIONS);

      return res.json({
        success: true,
        user: data.user
      });

    } catch (err) {
      res.clearCookie("accessToken");
      res.clearCookie("refreshToken");

      return res.status(401).json({
        success: false,
        message: err.message
      });
    }
  },
  /* ================= LOGOUT ================= */

  async logout(req, res, next) {
    try {

      const token = req.cookies?.refreshToken;

      await authService.logout(token, null);

      res.clearCookie('accessToken');
      res.clearCookie('refreshToken');

      return res.json({
        success: true,
        message: 'Logout success'
      });

    } catch (err) {
      next(err);
    }
  },
  /* ================= LOGOUT ALL DEVICES ================= */

  async logoutAllDevices(
    req,
    res,
    next
  ) {

    try {

      await authService.logoutAllDevices(
        req.user.id
      );

      res.clearCookie(
        'accessToken',
        COOKIE_OPTIONS
      );

      res.clearCookie(
        'refreshToken',
        COOKIE_OPTIONS
      );

      return res.json({
        success: true,
        message:
          'Logged out all devices',
      });

    } catch (err) {

      next(err);
    }
  },
};

module.exports = authController;