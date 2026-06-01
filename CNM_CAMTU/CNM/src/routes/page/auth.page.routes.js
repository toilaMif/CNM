const express = require('express');
const router = express.Router();

// ===== LOGIN PAGE =====
router.get('/login', (req, res) => {
  res.render('auth/login', {
    title: 'Login',
    error: null
  });
});

// ===== FORGOT PASSWORD =====
router.get('/forgot-password', (req, res) => {
  res.render('auth/forgot-password');
});

module.exports = router;