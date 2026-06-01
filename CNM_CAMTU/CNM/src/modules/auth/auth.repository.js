const { pool } = require('../../config/database');

const authRepository = {

  /* ================= FIND USER ================= */
  async findByEmail(email) {
    const [rows] = await pool.execute(
      `SELECT u.*, r.name AS role_name
       FROM users u
       JOIN roles r ON u.role_id = r.id
       WHERE u.email = ?`,
      [email]
    );
    return rows[0];
  },

  async findById(id) {
    const [rows] = await pool.execute(
      `SELECT u.*, r.name AS role_name
       FROM users u
       JOIN roles r ON u.role_id = r.id
       WHERE u.id = ?`,
      [id]
    );
    return rows[0];
  },

  /* ================= PASSWORD ================= */
  async updatePassword(userId, password) {
    await pool.execute(
      `UPDATE users SET password = ?, is_first_login = FALSE WHERE id = ?`,
      [password, userId]
    );
  },

  /* ================= LOGIN ATTEMPTS ================= */
  async updateFailedAttempts(userId, attempts) {
    await pool.execute(
      `UPDATE users SET failed_attempts = ? WHERE id = ?`,
      [attempts, userId]
    );
  },

  async lockAccount(userId, locked_until) {
    await pool.execute(
      `UPDATE users SET locked_until = ? WHERE id = ?`,
      [locked_until, userId]
    );
  },

  async resetLoginAttempts(userId) {
    await pool.execute(
      `UPDATE users SET failed_attempts = 0, locked_until = NULL WHERE id = ?`,
      [userId]
    );
  },
/* ================= REFRESH TOKEN ================= */
  async saveRefreshToken(user_id, token_hash, expires_at) {
    await pool.execute(
      `INSERT INTO refresh_tokens (user_id, token_hash, expires_at)
      VALUES (?, ?, ?)`,
      [user_id, token_hash, expires_at]
    );
  },

  async findTokensByUserId(userId) {
    const [rows] = await pool.execute(
      `SELECT * FROM refresh_tokens WHERE user_id = ?`,
      [userId]
    );
    return rows;
  },

  async revokeRefreshToken(id) {
    await pool.execute(
      `UPDATE refresh_tokens SET is_revoked = TRUE WHERE id = ?`,
      [id]
    );
  },

  async revokeAllUserTokens(userId) {
    await pool.execute(
      `UPDATE refresh_tokens SET is_revoked = TRUE WHERE user_id = ?`,
      [userId]
    );
  },
  /* ================= AUDIT ================= */
  async saveAuditLog(user_id, action, target_id = null, ip = null) {
    await pool.execute(
      `INSERT INTO audit_logs (user_id, action, target_id, ip_address)
       VALUES (?, ?, ?, ?)`,
      [user_id, action, target_id, ip]
    );
  },
  /* ================= Cập nhật tài khoản isActive = 0( Xóa mềm ) ================= */
  async updateIsActive(userID, isActive) {
  return pool.query(
    `UPDATE users
     SET isActive = ?
     WHERE userID = ?`,
    [isActive, userID]
  );
}
};

module.exports = authRepository;