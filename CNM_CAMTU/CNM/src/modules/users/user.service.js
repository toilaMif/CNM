const bcrypt = require("bcryptjs");

const userRepo = require("./user.repository");
const authRepo = require("../auth/auth.repository");
const mailService = require("../mail/mail.service");

const generatePassword = () =>
  Math.floor(10000000 + Math.random() * 90000000).toString();

const userService = {
  /* ================= CREATE USER ================= */
  async createUser(currentUser, data) {
    const {
      email,
      role_id,
      full_name,
      phone_number,
      gender,
      avatar_url,
      address,
      date_of_birth
    } = data;

    const exist = await authRepo.findByEmail(email);

    if (exist) {
      throw new Error("Email already exists");
    }

    const rawPassword = generatePassword();
    const hashedPassword = await bcrypt.hash(rawPassword, 10);

    const userId = await userRepo.create({
      email,
      password: hashedPassword,
      role_id,
      created_by: currentUser.id,

      full_name,
      phone_number,
      gender,
      avatar_url,
      address,
      date_of_birth
    });

    try {
      await mailService.sendAccountEmail(
        email,
        rawPassword
      );
    } catch (err) {
      console.error("Mail error:", err.message);
    }

    return { userId };
  },

  /* ================= GET USERS ================= */
  async getAllUsers() {
    return await userRepo.findAll();
  },

  /* ================= GET USER BY ID ================= */
  async getUserById(id) {
    const userId = Number(id);

    if (!userId || Number.isNaN(userId)) {
      throw new Error("ID người dùng không hợp lệ");
    }

    return await userRepo.findById(userId);
  },

  /* ================= UPDATE USERS ================= */
  async updateUser(id, data) {
    const userId = Number(id);

    if (!userId || Number.isNaN(userId)) {
      throw new Error("ID người dùng không hợp lệ");
    }

    const user = await userRepo.findById(userId);

    if (!user) {
      throw new Error("User not found");
    }

    const payload = {
      role_id: data.role_id ?? user.role_id,
      is_active: data.is_active ?? user.is_active,

      full_name: data.full_name ?? user.full_name,

      phone_number:
        data.phone_number ?? user.phone_number,

      gender: data.gender ?? user.gender,

      avatar_url:
        data.avatar_url ?? user.avatar_url,

      address: data.address ?? user.address,

      date_of_birth:
        data.date_of_birth ?? user.date_of_birth
    };

    const result = await userRepo.update(
      userId,
      payload
    );

    return result;
  },

  /* ================= TOGGLE LOCK USER =================
     lock = true  -> khóa tài khoản: is_active = 0
     lock = false -> mở khóa tài khoản: is_active = 1
  ========================================================= */
  async toggleLockUser(id, lock) {
    const userId = Number(id);

    if (!userId || Number.isNaN(userId)) {
      throw new Error("ID người dùng không hợp lệ");
    }

    const user = await userRepo.findById(userId);

    if (!user) {
      throw new Error("User not found");
    }

    const isActive = lock ? 0 : 1;

    const result = await userRepo.updateActiveStatus(
      userId,
      isActive
    );

    if (!result || result.affectedRows === 0) {
      throw new Error("Cập nhật trạng thái tài khoản thất bại");
    }

    if (isActive === 1) {
      await userRepo.resetLoginAttempts(userId);
    }

    return {
      success: true,
      message: isActive === 1
        ? "Mở khóa tài khoản thành công"
        : "Khóa tài khoản thành công",
      userId,
      is_active: isActive
    };
  },

  /* ================= UPDATE USER ROLE ================= */
  async updateUserRole(id, role) {
    const userId = Number(id);
    const roleId = Number(role);

    if (!userId || Number.isNaN(userId)) {
      throw new Error("ID người dùng không hợp lệ");
    }

    if (!roleId || Number.isNaN(roleId)) {
      throw new Error("Vai trò không hợp lệ");
    }

    const user = await userRepo.findById(userId);

    if (!user) {
      throw new Error("User not found");
    }

    return await userRepo.update(userId, {
      role_id: roleId,
      is_active: user.is_active,

      full_name: user.full_name,
      phone_number: user.phone_number,
      gender: user.gender,
      avatar_url: user.avatar_url,
      address: user.address,
      date_of_birth: user.date_of_birth
    });
  },

  /* =========================================================
     CHANGE MY PASSWORD
     Người dùng đang đăng nhập tự đổi mật khẩu trong profile

     Dùng cho:
     PATCH /api/users/me/change-password
  ========================================================= */
  async changeMyPassword(userId, data) {
    const id = Number(userId);

    if (!id || Number.isNaN(id)) {
      throw new Error("Không xác định được người dùng");
    }

    const currentPassword =
      data.current_password?.trim?.() || "";

    const newPassword =
      data.new_password?.trim?.() || "";

    const confirmPassword =
      data.confirm_password?.trim?.() || "";

    if (!currentPassword) {
      throw new Error("Vui lòng nhập mật khẩu hiện tại");
    }

    if (!newPassword) {
      throw new Error("Vui lòng nhập mật khẩu mới");
    }

    if (!confirmPassword) {
      throw new Error("Vui lòng xác nhận mật khẩu mới");
    }

    if (newPassword.length < 8) {
      throw new Error("Mật khẩu mới phải có ít nhất 8 ký tự");
    }

    if (newPassword !== confirmPassword) {
      throw new Error("Mật khẩu xác nhận không khớp");
    }

    if (newPassword === currentPassword) {
      throw new Error("Mật khẩu mới không được trùng mật khẩu hiện tại");
    }

    const user = await userRepo.findPasswordById(id);

    if (!user) {
      throw new Error("Không tìm thấy tài khoản");
    }

    if (Number(user.is_active) !== 1) {
      throw new Error("Tài khoản đang bị khóa");
    }

    const isMatch = await bcrypt.compare(
      currentPassword,
      user.password
    );

    if (!isMatch) {
      throw new Error("Mật khẩu hiện tại không đúng");
    }

    const hashedPassword = await bcrypt.hash(
      newPassword,
      10
    );

    await userRepo.updatePassword(
      id,
      hashedPassword
    );

    return {
      success: true,
      message: "Đổi mật khẩu thành công"
    };
  },

  /* ================== DELETE USER - SOFT DELETE ================== */
  async deleteUser(userId) {
    const id = Number(userId);

    if (!id || Number.isNaN(id)) {
      throw new Error("ID người dùng không hợp lệ");
    }

    const result = await userRepo.updateActiveStatus(id, 0);

    if (!result || result.affectedRows === 0) {
      throw new Error("Không tìm thấy người dùng để xóa");
    }

    return {
      success: true,
      message: "Xóa người dùng thành công (soft delete)",
      userId: id
    };
  }
};

module.exports = userService;