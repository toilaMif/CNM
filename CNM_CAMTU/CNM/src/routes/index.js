const authRoutes = require('../modules/auth/auth.routes');
const userRoutes = require('../modules/users/user.routes');
const productRoutes = require('../modules/products/product.routes');
const inventoryRoutes = require('../modules/inventory/inventory.routes');
const saleRoutes = require('../modules/sale/sale.routes');
const orderRoutes = require('../modules/orders/order.routes');
const procurementRoutes = require('../modules/procurement/procurement.routes');
const aiAdvisorRoutes = require('../modules/ai-advisor/ai-advisor.routes');
const paymentTerms = require('../modules/payment-terms/paymentTerm.routes');
const payments = require('../modules/payments/payment.routes');

/* ================= PAGE ROUTES ================= */

const authPageRoutes = require('./page/auth.page.routes');
const userPageRoutes = require('./page/user.page.routes');
const adminPageRoutes = require('./page/admin.page.routes');
const salePageRoutes = require('./page/sale.page.routes');
const warehousePageRoutes = require('./page/inventory.page.routes');
const productManagerPageRoutes = require('./page/product-manager.page.routes');
const customerPageRoutes = require('./page/customer.page.routes');

module.exports = (app) => {

  /* =====================================================
     API ROUTES
  ===================================================== */

  app.use('/api/auth', authRoutes);

  app.use('/api/users', userRoutes);

  app.use('/api/products', productRoutes);

  app.use('/api/inventory', inventoryRoutes);

  app.use('/api/orders', orderRoutes);

  app.use('/api/sale', saleRoutes);

  app.use('/api/procurement', procurementRoutes);

  app.use('/api/ai-advisor', aiAdvisorRoutes);

  app.use('/api/payment-terms', paymentTerms);

  app.use('/api/payments',payments );

  /* =====================================================
     PAGE ROUTES
  ===================================================== */

  // Auth
  app.use('/', authPageRoutes);

  // User
  app.use('/', userPageRoutes);

  // Admin
  app.use('/admin', adminPageRoutes);

  // Sale
  app.use('/sale', salePageRoutes);

  // Warehouse
  app.use('/warehouse', warehousePageRoutes);

  // Product Manager
  app.use('/product-manager', productManagerPageRoutes);

  // Customer
  app.use('/', customerPageRoutes);
};
