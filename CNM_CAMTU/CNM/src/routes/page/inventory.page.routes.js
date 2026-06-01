const express = require('express');
const router = express.Router();

const { verifyPageAuth } = require('../../core/middlewares/verifyPageAuth.middleware');
const { authorizeRoles } = require('../../core/middlewares/role.middleware');
const userController = require('../../modules/users/user.controller');
const { pool } = require('../../config/database');

/* =========================================================
   WAREHOUSE GUARD
========================================================= */
const warehouseGuard = [
  verifyPageAuth,
  authorizeRoles('WAREHOUSE_EMPLOYEE')
];

/* =========================================================
   APPLY GLOBAL GUARD
========================================================= */
router.use(warehouseGuard);

/* =========================================================
   HELPER: RENDER WITH WAREHOUSE LAYOUT

   Dùng pageView giống Product Manager layout.
   Vẫn nhận contentPage để tương thích code cũ.
========================================================= */
function renderWarehousePage(res, {
  title,
  currentPage,
  activeMenu = '',
  pageView,
  contentPage,
  pageCss = null,
  pageJs = null,
  pageClass = '',
  user = null,
  extraData = {}
}) {
  return res.render('warehouse/layout', {
    title,
    currentPage,
    activeMenu,

    pageView: pageView || contentPage,

    pageCss,
    pageJs,
    pageClass,
    user,

    ...extraData
  });
}

/* =========================================================
   WAREHOUSE DASHBOARD
   GET /warehouse/dashboard
========================================================= */
router.get('/dashboard', async (req, res) => {
  try {
    const [totalProductsResult] = await pool.query(`
      SELECT 
        COUNT(DISTINCT ProductID) AS count
      FROM inventory
    `);

    const [expiringSoonResult] = await pool.query(`
      SELECT 
        COUNT(*) AS count
      FROM inventory
      WHERE ExpiryDate IS NOT NULL
        AND ExpiryDate >= CURDATE()
        AND ExpiryDate <= DATE_ADD(CURDATE(), INTERVAL 30 DAY)
        AND COALESCE(Quantity, 0) > 0
    `);

    const [shippingOrdersResult] = await pool.query(`
      SELECT 
        COUNT(*) AS count
      FROM orders
      WHERE status = 'PENDING'
    `);

    let pendingReceiptsCount = 0;

    try {
      const [pendingReceiptsResult] = await pool.query(`
        SELECT 
          COUNT(*) AS count
        FROM goods_receipts
        WHERE status IN ('PENDING', 'PROCESSING', 'CREATED')
           OR issue_status = 'WAITING_REVIEW'
      `);

      pendingReceiptsCount = Number(pendingReceiptsResult[0]?.count || 0);
    } catch (err) {
      pendingReceiptsCount = 0;
    }

    const [orders] = await pool.query(`
      SELECT
        o.order_id,
        o.customer_id,
        o.shipping_address,
        o.status,
        o.created_at,
        c.company_name
      FROM orders o
      LEFT JOIN customers c
        ON o.customer_id = c.customer_id
      WHERE o.status = 'PENDING'
      ORDER BY o.created_at DESC
      LIMIT 10
    `);

    return renderWarehousePage(res, {
      title: 'Dashboard kho',
      currentPage: 'warehouse.dashboard',
      activeMenu: 'dashboard',
      pageView: 'dashboard',

      pageCss: '/css/pages/warehouse/dashboard.css',
      pageJs: '/js/pages/warehouse/dashboard.js',

      user: req.user,

      extraData: {
        stats: {
          totalProducts: Number(totalProductsResult[0]?.count || 0),
          expiringSoonCount: Number(expiringSoonResult[0]?.count || 0),
          shippingOrdersCount: Number(shippingOrdersResult[0]?.count || 0),
          pendingReceiptsCount
        },
        orders
      }
    });

  } catch (err) {
    console.error('WAREHOUSE DASHBOARD ERROR:', err);

    return renderWarehousePage(res, {
      title: 'Dashboard kho',
      currentPage: 'warehouse.dashboard',
      activeMenu: 'dashboard',
      pageView: 'dashboard',

      pageCss: '/css/pages/warehouse/dashboard.css',
      pageJs: '/js/pages/warehouse/dashboard.js',

      user: req.user,

      extraData: {
        stats: {
          totalProducts: 0,
          expiringSoonCount: 0,
          shippingOrdersCount: 0,
          pendingReceiptsCount: 0
        },
        orders: []
      }
    });
  }
});

/* =========================================================
   ORDER DETAIL
   GET /warehouse/orders/:id
========================================================= */
router.get('/orders/:id', async (req, res) => {
  try {
    const orderId = Number(req.params.id);

    if (!orderId) {
      return res.redirect('/warehouse/dashboard');
    }

    const [orders] = await pool.query(`
      SELECT
        o.*,
        c.company_name
      FROM orders o
      LEFT JOIN customers c
        ON o.customer_id = c.customer_id
      WHERE o.order_id = ?
      LIMIT 1
    `, [orderId]);

    const order = orders[0];

    if (!order) {
      return res.redirect('/warehouse/dashboard');
    }

    const [items] = await pool.query(`
      SELECT
        od.*,
        p.ProductName,
        p.SKU
      FROM order_details od
      LEFT JOIN products p
        ON od.product_id = p.ProductID
      WHERE od.order_id = ?
    `, [orderId]);

    return renderWarehousePage(res, {
      title: 'Chi tiết đơn hàng',
      currentPage: 'warehouse.dashboard',
      activeMenu: 'dashboard',
      pageView: 'order-detail',

      pageCss: '/css/pages/warehouse/dashboard.css',
      pageJs: '/js/pages/warehouse/dashboard.js',

      user: req.user,

      extraData: {
        order,
        items
      }
    });

  } catch (err) {
    console.error('LOAD WAREHOUSE ORDER DETAIL ERROR:', err);
    return res.redirect('/warehouse/dashboard');
  }
});

/* =========================================================
   INVENTORY
   GET /warehouse/inventory
========================================================= */
router.get('/inventory', (req, res) => {
  return renderWarehousePage(res, {
    title: 'Quản lý tồn kho',
    currentPage: 'warehouse.inventory',
    activeMenu: 'inventory',
    pageView: 'inventory',

    pageCss: '/css/pages/warehouse/inventory.css',
    pageJs: '/js/pages/warehouse/inventory.js',

    user: req.user
  });
});

/* =========================================================
   PRODUCT CATEGORY
   GET /warehouse/product-category
========================================================= */
router.get('/product-category', (req, res) => {
  return renderWarehousePage(res, {
    title: 'Quản lý danh mục sản phẩm',
    currentPage: 'warehouse.product-category',
    activeMenu: 'product-category',
    pageView: 'product-category',

    pageCss: '/css/pages/warehouse/product-category.css',
    pageJs: '/js/pages/warehouse/product-category.js',

    user: req.user
  });
});

/* =========================================================
   GOODS RECEIPTS
   GET /warehouse/goods-receipts
========================================================= */
router.get('/goods-receipts', (req, res) => {
  return renderWarehousePage(res, {
    title: 'Nhận hàng theo phiếu đặt',
    currentPage: 'warehouse.goods-receipts',
    activeMenu: 'goods-receipts',
    pageView: 'goods-receipts',

    pageCss: '/css/pages/warehouse/goods-receipts.css',
    pageJs: '/js/pages/warehouse/goods-receipts.js',

    user: req.user
  });
});

/* =========================================================
   IMPORT MANAGEMENT
   GET /warehouse/import-management
========================================================= */
router.get('/import-management', (req, res) => {
  return renderWarehousePage(res, {
    title: 'Quản lý nhập hàng',
    currentPage: 'warehouse.import-management',
    activeMenu: 'import-management',
    pageView: 'import-management',

    pageCss: '/css/pages/warehouse/import-management.css',
    pageJs: '/js/pages/warehouse/import-management.js',

    user: req.user
  });
});

/* =========================================================
   STOCKTAKES
   GET /warehouse/stocktakes
========================================================= */
router.get('/stocktakes', (req, res) => {
  return renderWarehousePage(res, {
    title: 'Kiểm kê kho vật tư',
    currentPage: 'warehouse.stocktakes',
    activeMenu: 'stocktakes',
    pageView: 'stocktakes',

    pageCss: '/css/pages/warehouse/stocktakes.css',
    pageJs: '/js/pages/warehouse/stocktakes.js?v=stocktake_upload_1',

    user: req.user
  });
});

/* =========================================================
   PROFILE PAGE
   GET /warehouse/profile

   Nếu chưa có views/warehouse/profile.ejs thì redirect dashboard.
========================================================= */
router.get('/profile', userController.profilePage);


module.exports = router;