const express = require('express');
const router = express.Router();

const userController = require('./user.controller');

const { verifyAccessToken } = require('../../core/middlewares/auth.middleware');
const { authorizeRoles } = require('../../core/middlewares/role.middleware');

/* =========================================================
   USER ROUTES

   Lưu ý:
   - Route cụ thể phải đặt trước route động /:id
   - Ví dụ:
     /me/change-password
     /:id/lock
     /:id/role
     phải đặt trước /:id
========================================================= */


/* =========================================================
   PROFILE / ME
========================================================= */

// PATCH /api/users/me/change-password
router.patch(
  '/me/change-password',
  verifyAccessToken,
  authorizeRoles(
    'ADMIN',
    'MANAGER',
    'SALE',
    'WAREHOUSE_EMPLOYEE',
    'PRODUCT_MANAGER',
    'CUSTOMER'
  ),
  userController.changeMyPassword
);


/* =========================================================
   ADMIN - CREATE USER
========================================================= */

// POST /api/users
router.post(
  '/',
  verifyAccessToken,
  authorizeRoles('ADMIN'),
  userController.createUser
);


/* =========================================================
   ADMIN - GET USERS
========================================================= */

// GET /api/users
router.get(
  '/',
  verifyAccessToken,
  authorizeRoles('ADMIN'),
  userController.getAllUsers
);


/* =========================================================
   ADMIN - LOCK / UNLOCK USER
   PATCH /api/users/:id/lock

   Body frontend gửi:
   {
     "is_active": 0
   }

   hoặc:
   {
     "is_active": 1
   }
========================================================= */
router.patch(
  '/:id/lock',
  verifyAccessToken,
  authorizeRoles('ADMIN'),
  userController.toggleLockUser
);


/* =========================================================
   ADMIN - UPDATE ROLE
   PATCH /api/users/:id/role

   Body có thể gửi:
   {
     "role": 2
   }

   hoặc:
   {
     "role_id": 2
   }
========================================================= */
router.patch(
  '/:id/role',
  verifyAccessToken,
  authorizeRoles('ADMIN'),
  userController.updateUserRole
);


/* =========================================================
   ADMIN - UPDATE USER PROFILE
   PATCH /api/users/:id
========================================================= */
router.patch(
  '/:id',
  verifyAccessToken,
  authorizeRoles('ADMIN'),
  userController.updateUser
);


/* =========================================================
   ADMIN - DELETE USER / SOFT DELETE
   DELETE /api/users/:id
========================================================= */
router.delete(
  '/:id',
  verifyAccessToken,
  authorizeRoles('ADMIN'),
  userController.deleteUser
);


/* =========================================================
   ADMIN - GET USER BY ID
   GET /api/users/:id

   Đặt cuối cùng để tránh ăn nhầm các route cụ thể.
========================================================= */
router.get(
  '/:id',
  verifyAccessToken,
  authorizeRoles('ADMIN'),
  userController.getUserById
);

module.exports = router;