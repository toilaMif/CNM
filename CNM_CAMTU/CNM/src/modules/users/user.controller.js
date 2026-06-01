const userService = require('./user.service');

const userController = {

  /* ================== CREATE USER ================== */
  async createUser(req, res, next) {
    try {
      const result = await userService.createUser(req.user, req.body);

      return res.status(201).json({
        success: true,
        message: 'User created successfully',
        data: result,
      });

    } catch (err) {
      next(err);
    }
  },

  /* ================== GET ALL USERS ================== */
  async getAllUsers(req, res, next) {
    try {
      const users = await userService.getAllUsers();

      return res.json({
        success: true,
        data: users
      });

    } catch (err) {
      next(err);
    }
  },

  /* ================== GET USER BY ID ================== */
  async getUserById(req, res, next) {
    try {
      const user = await userService.getUserById(req.params.id);

      if (!user) {
        return res.status(404).json({
          success: false,
          message: 'User not found'
        });
      }

      return res.json({
        success: true,
        data: user
      });

    } catch (err) {
      next(err);
    }
  },

  /* ================== UPDATE USER ================== */
  async updateUser(req, res, next) {
    try {
      const result = await userService.updateUser(
        req.params.id,
        req.body
      );

      return res.json({
        success: true,
        message: 'Cập nhật người dùng thành công',
        data: result
      });

    } catch (err) {
      next(err);
    }
  },

  /* ================== TOGGLE LOCK / UNLOCK USER ==================
     Frontend gửi:
     - is_active = 0 => khóa tài khoản
     - is_active = 1 => mở khóa tài khoản

     Service nhận:
     - lock = true  => khóa
     - lock = false => mở khóa
  ========================================================= */
  async toggleLockUser(req, res, next) {
    try {
      const userId = Number(req.params.id);

      if (!userId || Number.isNaN(userId)) {
        return res.status(400).json({
          success: false,
          message: 'ID người dùng không hợp lệ'
        });
      }

      let lock;

      /*
        Ưu tiên đọc is_active vì frontend hiện tại gửi is_active.
        is_active = 0 nghĩa là khóa.
        is_active = 1 nghĩa là mở khóa.
      */
      if (req.body.is_active !== undefined) {
        const isActive = Number(req.body.is_active);

        if (![0, 1].includes(isActive)) {
          return res.status(400).json({
            success: false,
            message: 'Trạng thái tài khoản không hợp lệ'
          });
        }

        lock = isActive === 0;
      }

      /*
        Giữ tương thích nếu chỗ khác vẫn gửi lock.
        lock = true nghĩa là khóa.
        lock = false nghĩa là mở khóa.
      */
      else if (req.body.lock !== undefined) {
        lock =
          req.body.lock === true ||
          req.body.lock === 'true' ||
          req.body.lock === 1 ||
          req.body.lock === '1';
      }

      else {
        return res.status(400).json({
          success: false,
          message: 'Thiếu trạng thái lock/unlock'
        });
      }

      const result = await userService.toggleLockUser(
        userId,
        lock
      );

      return res.json({
        success: true,
        message: result.message || 'Cập nhật trạng thái tài khoản thành công',
        data: result
      });

    } catch (err) {
      next(err);
    }
  },

  /* ================== UPDATE USER ROLE ================== */
  async updateUserRole(req, res, next) {
    try {
      const userId = Number(req.params.id);

      if (!userId || Number.isNaN(userId)) {
        return res.status(400).json({
          success: false,
          message: 'ID người dùng không hợp lệ'
        });
      }

      const role = req.body.role ?? req.body.role_id;

      const result = await userService.updateUserRole(
        userId,
        role
      );

      return res.json({
        success: true,
        message: 'Cập nhật vai trò thành công',
        data: result
      });

    } catch (err) {
      next(err);
    }
  },

  /* =========================================================
     CHANGE MY PASSWORD
     PATCH /api/users/me/change-password
  ========================================================= */
  async changeMyPassword(req, res, next) {
    try {
      const userId = req.user.id;

      const result = await userService.changeMyPassword(
        userId,
        req.body
      );

      return res.status(200).json({
        success: true,
        message: result.message || 'Đổi mật khẩu thành công'
      });

    } catch (err) {
      return res.status(400).json({
        success: false,
        message: err.message
      });
    }
  },

  /* ================== DELETE USER ================== */
  async deleteUser(req, res) {
    try {
      const result = await userService.deleteUser(
        req.params.id
      );

      return res.json(result);

    } catch (error) {
      return res.status(400).json({
        success: false,
        message: error.message
      });
    }
  },

   /* ================== PROFILE PAGE ================== */
  async profilePage(req, res, next) {
    try {
      const user = await userService.getUserById(req.user.id);

      if (!user) {
        return res.redirect('/login');
      }

      const roleName =
        user.role_name ||
        user.RoleName ||
        user.role ||
        req.user.role_name ||
        req.user.RoleName ||
        req.user.role;

      let layoutPath;
      let pageClass;
      const pageView = './profile';

      switch (roleName) {
        case 'SALE':
          layoutPath = 'sale/layout';
          pageClass = 'sale-profile-page';
          break;

        case 'PRODUCT_MANAGER':
          layoutPath = 'product-manager/layout';
          pageClass = 'profile-page';
          break;

        case 'ADMIN':
          layoutPath = 'admin/layout';
          pageClass = 'profile-page';
          break;

        case 'WAREHOUSE_EMPLOYEE':
          layoutPath = 'warehouse/layout';
          pageClass = 'profile-page';
          break;

        default:
          return res.status(403).send('Role này chưa có layout profile.');
      }

      return res.render(layoutPath, {
        title: 'Thông tin tài khoản',
        user,
        activeMenu: 'profile',

        pageClass,
        pageView,

        pageCss: '/css/pages/shared/profile.css',
        pageJs: '/js/pages/shared/profile.js'
      });

    } catch (err) {
      next(err);
    }
  }
};

module.exports = userController;