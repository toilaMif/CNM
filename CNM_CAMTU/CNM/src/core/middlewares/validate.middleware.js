/* =========================================================
   VALIDATE LOGIN
========================================================= */
function validateAuth(req, res, next) {
  const { email, password } = req.body;

  if (!email || !password) {
    return res.status(400).json({ message: 'Missing email or password' });
  }

  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

  if (!emailRegex.test(email)) {
    return res.status(400).json({ message: 'Invalid email format' });
  }

  next();
}

/* =========================================================
   VALIDATE CHANGE PASSWORD
========================================================= */
function validateChangePassword(req, res, next) {
  const { oldPassword, newPassword } = req.body;

  if (!oldPassword || !newPassword) {
    return res.status(400).json({ message: 'Missing password' });
  }

  const strongPassword =
    /^(?=.*[A-Za-z])(?=.*\d)(?=.*[A-Z]|.*[^A-Za-z0-9]).{8,}$/;

  if (!strongPassword.test(newPassword)) {
    return res.status(400).json({
      message:
        'Password must be at least 8 characters, include number and uppercase or special char',
    });
  }

  next();
}

module.exports = {
  validateAuth,
  validateChangePassword,
};