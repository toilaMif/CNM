const express = require('express');

const router = express.Router();

/* =========================================================
   CUSTOMER HOME
   GET /
========================================================= */
router.get('/', (req, res) => {
  res.render('customer/home', {
    title: 'AgroShop'
  });
});

/* =========================================================
   PRODUCT DETAIL
   GET /product-detail/:id
========================================================= */
router.get('/product-detail/:id', (req, res) => {
  res.render('customer/product-detail', {
    title: 'Chi tiết sản phẩm',
    productId: req.params.id
  });
});

/* =========================================================
   AI CHAT
   GET /ai-chat
========================================================= */
router.get('/ai-chat', (req, res) => {
  res.render('customer/ai-chat', {
    title: 'Agro AI Assistant'
  });
});

module.exports = router;
