const express = require('express');
const router = express.Router();
const orderController = require('./order.controller');
const { verifyAccessToken } = require('../../core/middlewares/auth.middleware');
const { authorizeRoles } = require('../../core/middlewares/role.middleware');


// // 1. Lấy danh sách đơn hàng
// router.get('/', verifyAccessToken, orderController.getAll);

// // 2. Xem chi tiết đơn hàng (Sửa getDetail thành getById cho khớp Controller)
// router.get('/:id', verifyAccessToken, orderController.getById);

// // 3. Đặt hàng mới
// router.post('/', 
//     verifyAccessToken, 
//     authorizeRoles(['SALE']), 
//     orderController.create
// );
router.get('/view', verifyAccessToken, orderController.viewOrders);
router.get('/view/new', verifyAccessToken, orderController.viewCreate);
router.get('/view/:id', verifyAccessToken, orderController.viewDetail);


router.get('/me', verifyAccessToken, orderController.getCurrentUser);

// 1. Lấy danh sách đơn hàng 
router.get('/', verifyAccessToken, orderController.getAll); 

// 2. Xem chi tiết đơn hàng
router.get('/:id', verifyAccessToken, orderController.getById); 

// 3. Đặt hàng mới 
router.post('/', verifyAccessToken, authorizeRoles(['SALE']), orderController.create );

// ==========================================================
// ĐƯỜNG DẪN HỦY ĐƠN HÀNG (MỚI THÊM)
// ==========================================================
router.post('/:id/cancel', verifyAccessToken, orderController.cancel);


module.exports = router;