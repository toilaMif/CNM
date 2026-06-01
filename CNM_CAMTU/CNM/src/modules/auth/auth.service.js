const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');

const authRepo = require('./auth.repository');
const mailService = require('../mail/mail.service');
const ROLES = require('../../core/constants/roles');

const ACCESS_SECRET = process.env.ACCESS_TOKEN_SECRET;
const REFRESH_SECRET = process.env.REFRESH_TOKEN_SECRET;

const MAX_ATTEMPTS = 5;

/* =========================================================
   UTILS
========================================================= */

function generateAccessToken(user) {
  return jwt.sign(
    {
      id: user.id,
      role_name: user.role_name,
    },
    ACCESS_SECRET,
    {
      expiresIn: '15m',
    }
  );
}

function generateRefreshToken(user) {
  return jwt.sign(
    {
      id: user.id,
    },
    REFRESH_SECRET,
    {
      expiresIn: '7d',
    }
  );
}

function generatePassword() {
  return Math.floor(
    10000000 + Math.random() * 90000000
  ).toString();
}

function validatePassword(password) {
  return /^(?=.*[A-Za-z])(?=.*\d)(?=.*[A-Z]|.*[^A-Za-z0-9]).{8,}$/.test(password);
}

/* =========================================================
   SERVICE
========================================================= */

  const authService = {

    /* ================= LOGIN ================= */

  async login(email, password, ip) {

    const user = await authRepo.findByEmail(email);

    if (!user) {
      return {
        success: false,
        status: 401,
        message: "Invalid email or password"
      };
    }

    // account disabled
    if (!user.is_active) {
      return {
        success: false,
        status: 403,
        message: "Account disabled"
      };
    }

    // locked account
    if (user.locked_until && new Date(user.locked_until) > new Date()) {
      return {
        success: false,
        status: 403,
        message: "Account locked. Try later"
      };
    }

    // password check
    const matched = await bcrypt.compare(password, user.password);

    if (!matched) {
      const attempts = (user.failed_attempts || 0) + 1;

      await authRepo.updateFailedAttempts(user.id, attempts);
      await authRepo.saveAuditLog(user.id, "LOGIN_FAILED", null, ip);

      if (attempts >= MAX_ATTEMPTS) {
        const lockTime = new Date(Date.now() + 15 * 60 * 1000);

        await authRepo.lockAccount(user.id, lockTime);
        await authRepo.saveAuditLog(user.id, "ACCOUNT_LOCKED", null, ip);
      }

      return {
        success: false,
        status: 401,
        message: "Invalid email or password"
      };
    }

    // reset attempts
    await authRepo.resetLoginAttempts(user.id);

    // generate tokens
    const accessToken = generateAccessToken(user);
    const refreshToken = generateRefreshToken(user);

    // store hashed refresh token
    const hashedRefreshToken = await bcrypt.hash(refreshToken, 10);

    await authRepo.saveRefreshToken(
      user.id,
      hashedRefreshToken,
      new Date(Date.now() + 7 * 24 * 60 * 60 * 1000)
    );

    await authRepo.saveAuditLog(user.id, "LOGIN", null, ip);

    return {
      success: true,
      accessToken,
      refreshToken,
      requireChangePassword: user.is_first_login === 1,
      user: {
        id: user.id,
        email: user.email,
        role: user.role_name,
        accessToken,
      }
    };
  },

  /* ================= CHANGE PASSWORD ================= */

  async changePassword(
    userId,
    oldPassword,
    newPassword
  ) {

    if (!validatePassword(newPassword)) {
      throw new Error('Weak password');
    }

    const user = await authRepo.findById(userId);

    if (!user) {
      throw new Error('User not found');
    }

    const matched = await bcrypt.compare(
      oldPassword,
      user.password
    );

    if (!matched) {
      throw new Error('Old password incorrect');
    }

    const hashedPassword =
      await bcrypt.hash(newPassword, 10);

    await authRepo.updatePassword(
      userId,
      hashedPassword
    );

    await authRepo.revokeAllUserTokens(userId);

    await authRepo.saveAuditLog(
      userId,
      'CHANGE_PASSWORD'
    );

    return {
      success: true,
    };
  },

  /* ================= REFRESH TOKEN ================= */

  async refreshToken(token) {

    if (!token) {
      throw new Error('Refresh token required');
    }

    let payload;

    try {
      payload = jwt.verify(
        token,
        REFRESH_SECRET
      );
    } catch {
      throw new Error('Invalid refresh token');
    }

    const tokens =
      await authRepo.findTokensByUserId(
        payload.id
      );

    let matchedToken = null;

    for (const item of tokens) {

      const matched = await bcrypt.compare(
        token,
        item.token_hash
      );

      if (matched) {
        matchedToken = item;
        break;
      }
    }

    if (!matchedToken) {

      await authRepo.revokeAllUserTokens(
        payload.id
      );

      throw new Error('Invalid refresh token');
    }

    if (matchedToken.is_revoked) {

      await authRepo.revokeAllUserTokens(
        payload.id
      );

      throw new Error('Token reuse detected');
    }

    if (
      new Date(matchedToken.expires_at) <
      new Date()
    ) {
      throw new Error('Refresh token expired');
    }

    const user = await authRepo.findById(
      payload.id
    );

    if (!user) {
      throw new Error('User not found');
    }

    const newAccessToken =
      generateAccessToken(user);

    const newRefreshToken =
      generateRefreshToken(user);

    const hashedNewToken =
      await bcrypt.hash(newRefreshToken, 10);

    await authRepo.revokeRefreshToken(
      matchedToken.id
    );

    await authRepo.saveRefreshToken(
      user.id,
      hashedNewToken,
      new Date(
        Date.now() + 7 * 24 * 60 * 60 * 1000
      )
    );

   return {
      success: true,
      accessToken: newAccessToken,
      refreshToken: newRefreshToken,

      user: {
        id: user.id,
        email: user.email,
        role: user.role_name,
        role_name: user.role_name,
      },
    };
  },

  /* ================= LOGOUT ================= */

  async logout(token, userId) {

    if (!token) {
      return { success: true };
    }

    let payload;

    try {
      payload = jwt.verify(token, REFRESH_SECRET);
    } catch {
      return { success: true };
    }

    const tokens = await authRepo.findTokensByUserId(payload.id);

    if (Array.isArray(tokens)) {
      for (const item of tokens) {

        if (!item?.token_hash) continue;

        const matched = await bcrypt.compare(token, item.token_hash);

        if (matched) {
          await authRepo.revokeRefreshToken(item.id);
          break;
        }
      }
    }

    await authRepo.saveAuditLog(
      userId || payload.id,
      'LOGOUT'
    );

    return { success: true };
  },

  async logoutAllDevices(userId) {

    await authRepo.revokeAllUserTokens(
      userId
    );

    await authRepo.saveAuditLog(
      userId,
      'LOGOUT_ALL_DEVICES'
    );

    return {
      success: true,
    };
  },

};

module.exports = authService;