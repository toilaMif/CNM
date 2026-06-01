require('dotenv').config();

const express = require('express');
const fs = require('fs');
const path = require('path');
const cors = require('cors');
const helmet = require('helmet');
const cookieParser = require('cookie-parser');
const rateLimit = require('express-rate-limit');

const errorMiddleware = require('./core/middlewares/error.middleware');
const registerRoutes = require('./routes');

const app = express();
const publicDir = path.join(__dirname, 'public');
const productUploadDir = path.join(publicDir, 'images', 'uploads', 'products');
const productImageIndex = new Map();
let productImageIndexReady = false;

function parsePositiveInt(value, fallback) {
  const parsed = Number.parseInt(String(value || ''), 10);

  return Number.isInteger(parsed) && parsed > 0
    ? parsed
    : fallback;
}

function indexProductImages() {
  if (productImageIndexReady) return;

  productImageIndexReady = true;

  function walk(currentDir) {
    if (!fs.existsSync(currentDir)) return;

    for (const item of fs.readdirSync(currentDir, { withFileTypes: true })) {
      const itemPath = path.join(currentDir, item.name);

      if (item.isDirectory()) {
        walk(itemPath);
        continue;
      }

      if (!item.isFile()) continue;

      const key = item.name.toLowerCase();

      if (!productImageIndex.has(key)) {
        productImageIndex.set(key, itemPath);
      }
    }
  }

  walk(productUploadDir);
}

function findProductImageByFileName(fileName) {
  if (!fileName) return null;

  indexProductImages();

  return productImageIndex.get(fileName.toLowerCase()) || null;
}

/* ================= VIEW ================= */
app.set('view engine', 'ejs');

app.set(
  'views',
  path.join(__dirname, 'views')
);

app.use(
  express.static(
    publicDir
  )
);

app.get('/images/uploads/products/*', (req, res, next) => {
  const requestedFile = path.basename(req.path);
  const matchedFile = findProductImageByFileName(requestedFile);

  if (!matchedFile) {
    return next();
  }

  return res.sendFile(matchedFile);
});

/* ================= SECURITY ================= */

app.use(
  helmet({
    contentSecurityPolicy: {
      directives: {

        "default-src": ["'self'"],

        "connect-src": [
          "'self'",
          "https://provinces.open-api.vn"
        ],

        "img-src": [
          "'self'",
          "data:",
          "blob:",
          "https:"
        ],

        "script-src": [
          "'self'",
          "'unsafe-inline'"
        ],

        "style-src": [
          "'self'",
          "'unsafe-inline'",
          "https://fonts.googleapis.com",
          "https://cdnjs.cloudflare.com"
        ],

        "font-src": [
          "'self'",
          "data:",
          "https://fonts.gstatic.com",
          "https://cdnjs.cloudflare.com"
        ]
      }
    },

    crossOriginEmbedderPolicy: false,

    crossOriginResourcePolicy: {
      policy: 'cross-origin'
    }
  })
);

/* ================= CORS ================= */

app.use(
  cors({
    origin:
      process.env.CORS_ORIGIN ||
      'http://localhost:5173',

    credentials: true
  })
);

/* ================= TRUST PROXY ================= */

app.set('trust proxy', 1);

/* ================= RATE LIMIT ================= */

const globalLimiter = rateLimit({
  windowMs: parsePositiveInt(
    process.env.RATE_LIMIT_WINDOW_MS,
    15 * 60 * 1000
  ),
  max: parsePositiveInt(
    process.env.RATE_LIMIT_MAX_REQUESTS,
    process.env.NODE_ENV === 'development' ? 1000 : 100
  )
});

const authLimiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 10
});

app.use('/api/auth', authLimiter);

app.use('/api', globalLimiter);

/* ================= PARSER ================= */

app.use(express.json());

app.use(
  express.urlencoded({
    extended: true
  })
);

app.use(cookieParser());

/* ================= DEBUG ================= */

app.use((req, res, next) => {

  console.log(
    '➡️',
    req.method,
    req.originalUrl
  );

  next();
});

/* =========================================================
   ADDRESS API PROXY
   API:
   GET /api/address/provinces
   GET /api/address/districts/:provinceId
   GET /api/address/wards/:districtId
========================================================= */

const ADDRESS_API =
  'https://provinces.open-api.vn/api';

/* ================= PROVINCES ================= */

app.get(
  '/api/address/provinces',
  async (req, res) => {

    try {

      const response = await fetch(
        `${ADDRESS_API}/p/`
      );

      if (!response.ok) {

        return res.status(
          response.status
        ).json({
          success: false,
          message: 'Address API error'
        });
      }

      const data =
        await response.json();

      return res.json({
        success: true,
        results: data
      });

    } catch (error) {

      console.error(
        'Load provinces error:',
        error
      );

      return res.status(500).json({
        success: false,
        message:
          'Không thể tải danh sách tỉnh / thành phố'
      });
    }
  }
);

/* ================= DISTRICTS ================= */

app.get(
  '/api/address/districts/:provinceId',
  async (req, res) => {

    try {

      const { provinceId } =
        req.params;

      const response = await fetch(
        `${ADDRESS_API}/p/${provinceId}?depth=2`
      );

      if (!response.ok) {

        return res.status(
          response.status
        ).json({
          success: false,
          message: 'Address API error'
        });
      }

      const data =
        await response.json();

      return res.json({
        success: true,
        results:
          data.districts || []
      });

    } catch (error) {

      console.error(
        'Load districts error:',
        error
      );

      return res.status(500).json({
        success: false,
        message:
          'Không thể tải danh sách quận / huyện'
      });
    }
  }
);

/* ================= WARDS ================= */

app.get(
  '/api/address/wards/:districtId',
  async (req, res) => {

    try {

      const { districtId } =
        req.params;

      const response = await fetch(
        `${ADDRESS_API}/d/${districtId}?depth=2`
      );

      if (!response.ok) {

        return res.status(
          response.status
        ).json({
          success: false,
          message: 'Address API error'
        });
      }

      const data =
        await response.json();

      return res.json({
        success: true,
        results:
          data.wards || []
      });

    } catch (error) {

      console.error(
        'Load wards error:',
        error
      );

      return res.status(500).json({
        success: false,
        message:
          'Không thể tải danh sách phường / xã'
      });
    }
  }
);

/* ================= ROUTES ================= */

registerRoutes(app);

/* ================= HOME ================= */

app.get('/', (req, res) => {

  res.render(
    'customer/home',
    {
      title: 'home',
      error: null
    }
  );
});

/* ================= ERROR ================= */

app.use(errorMiddleware);

module.exports = app;
