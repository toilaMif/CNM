/* =========================================================
   ROLE AUTHORIZATION
========================================================= */
function authorizeRoles(...allowedRoles) {

  // FIX NESTED ARRAY
  allowedRoles = allowedRoles.flat();

  return (req, res, next) => {

    if (!req.user) {

      return res.status(401).json({
        message: 'Bạn chưa đăng nhập hoặc Token sai.'
      });
    }

    const rawRole =
      req.user.role_name ||
      req.user.role ||
      '';

    const userRole = String(rawRole)
      .trim()
      .toUpperCase();

    const normalizedAllowedRoles =
      allowedRoles.map(role =>
        String(role)
          .trim()
          .toUpperCase()
      );

    console.log('USER ROLE:', userRole);
    console.log('ALLOWED ROLES:', normalizedAllowedRoles);

    // FINAL CHECK
    const hasPermission =
      normalizedAllowedRoles.includes(userRole);

    if (!hasPermission) {

      return res.status(403).json({
        message: `Forbidden: Quyền '${userRole}' của bạn không được phép truy cập.`
      });
    }

    next();
  };
}

module.exports = {
  authorizeRoles,
};