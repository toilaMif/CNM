const { pool } = require("../../config/database");

const userRepository = {
  /* =========================================================
     FIND ALL USERS
  ========================================================= */
  async findAll() {
    const [rows] = await pool.query(`
      SELECT 
        u.id,
        u.email,
        u.role_id,
        r.name AS role_name,
        u.is_active,
        u.is_first_login,
        u.failed_attempts,
        u.locked_until,
        u.created_at,

        p.full_name,
        p.phone_number,
        p.gender,
        p.avatar_url,
        p.address,
        p.date_of_birth

      FROM users u
      LEFT JOIN roles r 
        ON u.role_id = r.id

      LEFT JOIN profiles p
        ON u.id = p.user_id

      ORDER BY u.id DESC
    `);

    return rows;
  },

  /* =========================================================
     FIND USER BY ID
  ========================================================= */
  async findById(id) {
    const [rows] = await pool.query(
      `
      SELECT 
        u.id,
        u.email,
        u.role_id,
        r.name AS role_name,
        u.is_active,
        u.is_first_login,
        u.failed_attempts,
        u.locked_until,
        u.created_at,

        p.full_name,
        p.phone_number,
        p.gender,
        p.avatar_url,
        p.address,
        p.date_of_birth

      FROM users u

      LEFT JOIN roles r 
        ON u.role_id = r.id

      LEFT JOIN profiles p
        ON u.id = p.user_id

      WHERE u.id = ?
      LIMIT 1
      `,
      [id]
    );

    return rows[0];
  },

  /* =========================================================
     FIND USER BY EMAIL
  ========================================================= */
  async findByEmail(email) {
    const [rows] = await pool.query(
      `
      SELECT 
        u.id,
        u.email,
        u.password,
        u.role_id,
        r.name AS role_name,
        u.is_active,
        u.is_first_login,
        u.failed_attempts,
        u.locked_until,
        u.created_at,

        p.full_name,
        p.phone_number,
        p.gender,
        p.avatar_url,
        p.address,
        p.date_of_birth

      FROM users u

      LEFT JOIN roles r 
        ON u.role_id = r.id

      LEFT JOIN profiles p
        ON u.id = p.user_id

      WHERE u.email = ?
      LIMIT 1
      `,
      [email]
    );

    return rows[0];
  },

  /* =========================================================
     CREATE USER
  ========================================================= */
  async create(userData) {
    const {
      email,
      password,
      role_id,
      created_by = null,
      full_name = null,
      phone_number = null,
      gender = "hidden",
      avatar_url = "default-avatar.png",
      address = null,
      date_of_birth = null,
    } = userData;

    const connection = await pool.getConnection();

    try {
      await connection.beginTransaction();

      // CREATE USER
      const [userResult] = await connection.query(
        `
        INSERT INTO users (
          email,
          password,
          role_id,
          created_by
        )
        VALUES (?, ?, ?, ?)
        `,
        [email, password, role_id, created_by]
      );

      const userId = userResult.insertId;

      // CREATE PROFILE
      await connection.query(
        `
        INSERT INTO profiles (
          user_id,
          full_name,
          phone_number,
          gender,
          avatar_url,
          address,
          date_of_birth
        )
        VALUES (?, ?, ?, ?, ?, ?, ?)
        `,
        [
          userId,
          full_name,
          phone_number,
          gender,
          avatar_url,
          address,
          date_of_birth,
        ]
      );

      await connection.commit();

      return userId;
    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  },

  /* =========================================================
     UPDATE USER
  ========================================================= */
  async update(id, userData) {
    const {
      role_id,
      is_active,
      full_name,
      phone_number,
      gender,
      avatar_url,
      address,
      date_of_birth,
    } = userData;

    const connection = await pool.getConnection();

    try {
      await connection.beginTransaction();

      // UPDATE USERS
      await connection.query(
        `
        UPDATE users
        SET
          role_id = ?,
          is_active = ?
        WHERE id = ?
        `,
        [role_id, is_active, id]
      );

      // UPDATE PROFILE
      await connection.query(
        `
        UPDATE profiles
        SET
          full_name = ?,
          phone_number = ?,
          gender = ?,
          avatar_url = ?,
          address = ?,
          date_of_birth = ?
        WHERE user_id = ?
        `,
        [
          full_name,
          phone_number,
          gender,
          avatar_url,
          address,
          date_of_birth,
          id,
        ]
      );

      await connection.commit();

      return true;
    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  },

  /* =========================================================
     FIND PASSWORD BY USER ID
     Dùng cho chức năng đổi mật khẩu trong profile

     Mục đích:
     - Lấy password hash hiện tại
     - Kiểm tra tài khoản còn active không
     - Sau đó service dùng bcrypt.compare()
  ========================================================= */
  async findPasswordById(id) {
    const [rows] = await pool.query(
      `
      SELECT
        id,
        email,
        password,
        is_active,
        is_first_login,
        failed_attempts,
        locked_until
      FROM users
      WHERE id = ?
      LIMIT 1
      `,
      [id]
    );

    return rows[0] || null;
  },

  /* =========================================================
     UPDATE PASSWORD
     Cập nhật mật khẩu mới cho user

     Dùng cho:
     - Admin reset password nếu có
     - User tự đổi mật khẩu trong profile

     Sau khi đổi mật khẩu:
     - is_first_login = 0
     - failed_attempts = 0
     - locked_until = NULL
  ========================================================= */
  async updatePassword(id, hashedPassword) {
    const [result] = await pool.query(
      `
      UPDATE users
      SET
        password = ?,
        is_first_login = 0,
        failed_attempts = 0,
        locked_until = NULL
      WHERE id = ?
      `,
      [hashedPassword, id]
    );

    return result;
  },

  /* =========================================================
     SEARCH USERS
  ========================================================= */
  async search(keyword) {
    const [rows] = await pool.query(
      `
      SELECT 
        u.id,
        u.email,
        r.name AS role_name,
        u.is_active,

        p.full_name,
        p.phone_number

      FROM users u

      LEFT JOIN roles r
        ON u.role_id = r.id

      LEFT JOIN profiles p
        ON u.id = p.user_id

      WHERE 
        u.email LIKE ?
        OR p.full_name LIKE ?
        OR p.phone_number LIKE ?

      ORDER BY u.id DESC
      `,
      [`%${keyword}%`, `%${keyword}%`, `%${keyword}%`]
    );

    return rows;
  },

  /* =========================================================
     RESET LOGIN ATTEMPTS
     Dùng sau khi đăng nhập thành công

     DB đang dùng:
     - failed_attempts
     - locked_until
  ========================================================= */
  async resetLoginAttempts(id) {
    const [result] = await pool.query(
      `
      UPDATE users
      SET
        failed_attempts = 0,
        locked_until = NULL
      WHERE id = ?
      `,
      [id]
    );

    return result;
  },

  /* =========================================================
     INCREMENT LOGIN ATTEMPTS
     Dùng khi đăng nhập sai mật khẩu
  ========================================================= */
  async incrementLoginAttempts(id) {
    const [result] = await pool.query(
      `
      UPDATE users
      SET
        failed_attempts = COALESCE(failed_attempts, 0) + 1
      WHERE id = ?
      `,
      [id]
    );

    return result;
  },

  /* =========================================================
     LOCK USER UNTIL
     Dùng nếu muốn khóa tạm thời do sai mật khẩu nhiều lần
  ========================================================= */
  async lockUntil(id, lockedUntil) {
    const [result] = await pool.query(
      `
      UPDATE users
      SET
        locked_until = ?
      WHERE id = ?
      `,
      [lockedUntil, id]
    );

    return result;
  },

  /* =========================================================
     UPDATE ACTIVE STATUS
     Dùng cho admin lock / unlock tài khoản
  ========================================================= */
  async updateActiveStatus(id, isActive) {
    const [result] = await pool.query(
      `
      UPDATE users
      SET
        is_active = ?
      WHERE id = ?
      `,
      [isActive, id]
    );

    return result;
  },
};

module.exports = userRepository;