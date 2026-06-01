// src/core/middlewares/auth.middleware.js

const jwt = require('jsonwebtoken');
const { pool } = require('../../config/database');

const ACCESS_SECRET =
  process.env.ACCESS_TOKEN_SECRET;

/* =========================================================
   VERIFY ACCESS TOKEN
========================================================= */

async function verifyAccessToken(
  req,
  res,
  next
) {

  try {

    /* =====================================================
       GET TOKEN FROM COOKIE
    ===================================================== */

    const token =
      req.cookies?.accessToken;

    /* ================= NO TOKEN ================= */

    if (!token) {

      return res.status(401).json({
        success: false,
        message: 'No token provided',
      });
    }

    /* =====================================================
       VERIFY JWT
    ===================================================== */

    const decoded =
      jwt.verify(token, ACCESS_SECRET);

    /* =====================================================
       GET USER
    ===================================================== */

    const [rows] = await pool.execute(
      `
      SELECT
        u.id,
        u.email,
        u.role_id,
        u.is_active,
        u.is_first_login,
        r.name AS role_name
      FROM users u
      JOIN roles r
        ON u.role_id = r.id
      WHERE u.id = ?
      LIMIT 1
      `,
      [decoded.id]
    );

    const user = rows[0];

    /* ================= USER NOT FOUND ================= */

    if (!user) {

      return res.status(401).json({
        success: false,
        message: 'User not found',
      });
    }

    /* ================= ACCOUNT DISABLED ================= */

    if (!user.is_active) {

      return res.status(403).json({
        success: false,
        message: 'Account disabled',
      });
    }

    /* =====================================================
       SAVE USER
    ===================================================== */

    req.user = user;

    next();

  } catch (err) {

    console.error(err);

    /* ================= TOKEN EXPIRED ================= */

    if (
      err.name === 'TokenExpiredError'
    ) {

      return res.status(401).json({
        success: false,
        message: 'Token expired',
      });
    }

    /* ================= INVALID TOKEN ================= */

    if (
      err.name === 'JsonWebTokenError'
    ) {

      return res.status(401).json({
        success: false,
        message: 'Invalid token',
      });
    }

    /* ================= SERVER ERROR ================= */

    return res.status(500).json({
      success: false,
      message: err.message,
    });
  }
}

module.exports = {
  verifyAccessToken,
};