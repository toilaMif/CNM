const productService = require('./product.service');

/* =========================================================
   HELPER FUNCTIONS
========================================================= */

const toInt = (value) => {
  const num = parseInt(value, 10);
  return Number.isNaN(num) ? null : num;
};

const toNumberOrNull = (value) => {
  if (value === undefined || value === null || value === '') {
    return null;
  }

  const num = Number(value);
  return Number.isNaN(num) ? null : num;
};

const successResponse = (
  res,
  data = null,
  message = 'Thành công',
  statusCode = 200
) => {
  return res.status(statusCode).json({
    success: true,
    message,
    data
  });
};

const errorResponse = (
  res,
  message = 'Có lỗi xảy ra',
  statusCode = 400
) => {
  return res.status(statusCode).json({
    success: false,
    message
  });
};

/**
 * Parse JSON an toàn.
 * Dùng cho pesticideData khi gửi multipart/form-data.
 */
const parseJSONField = (value, fieldName = 'Dữ liệu JSON') => {
  if (!value) return null;

  if (typeof value === 'object') {
    return value;
  }

  try {
    return JSON.parse(value);
  } catch (error) {
    throw new Error(`${fieldName} không đúng định dạng JSON`);
  }
};

/**
 * Tạo imageData từ req.file do multer upload.
 * File public sẽ có dạng:
 * /images/uploads/products/ten-file.jpg
 */
const buildImageDataFromFile = (req) => {
  if (!req.file) {
    return null;
  }

  return {
    Name: req.file.filename,
    URL: `/images/uploads/products/${req.file.filename}`,
    ImageTypeID: Number(req.body.ImageTypeID) || 1
  };
};

/**
 * Chuẩn hóa body tạo/cập nhật sản phẩm.
 * Dùng chung cho createProduct và updateProduct.
 */
const buildProductData = (req) => {
  const pesticideData = parseJSONField(
    req.body.pesticideData,
    'pesticideData'
  );

  const imageData = buildImageDataFromFile(req);

  return {
    ProductName: req.body.ProductName,
    Slug: req.body.Slug,
    Description: req.body.Description,

    Price: toNumberOrNull(req.body.Price),
    CategoryID: toNumberOrNull(req.body.CategoryID),
    StatusID: toNumberOrNull(req.body.StatusID),
    UnitID: toNumberOrNull(req.body.UnitID),

    /*
      ImageID dùng khi không upload ảnh mới mà muốn giữ ảnh cũ.
      Khi upload ảnh mới, imageData sẽ được ưu tiên ở service/repository.
    */
    ImageID: toNumberOrNull(req.body.ImageID),

    Brand: req.body.Brand || null,
    OriginCountry: req.body.OriginCountry || null,
    Weight: toNumberOrNull(req.body.Weight),

    IsActive: req.body.IsActive !== undefined
      ? Number(req.body.IsActive)
      : 1,

    TechnicalContent: req.body.TechnicalContent || null,
    UsageInstructions: req.body.UsageInstructions || null,

    imageData,
    pesticideData
  };
};

/* =========================================================
   PRODUCT CONTROLLER
========================================================= */

const productController = {
  /* =========================================================
     GET ALL PRODUCTS
     API: GET /api/products
  ========================================================= */
  async getAll(req, res, next) {
    try {
      const {
        page = 1,
        limit = 10,
        keyword = '',
        categoryId,
        sort = 'newest'
      } = req.query;

      const data = await productService.findAll({
        page: toInt(page) || 1,
        limit: toInt(limit) || 10,
        keyword: keyword.trim(),
        categoryId: toInt(categoryId),
        sort
      });

      return successResponse(
        res,
        data,
        'Lấy danh sách sản phẩm thành công'
      );

    } catch (err) {
      next(err);
    }
  },

  /* =========================================================
     SEARCH PRODUCTS
     API: GET /api/products/search?q=...
  ========================================================= */
  async search(req, res, next) {
    try {
      const keyword = (req.query.q || '').trim();

      if (!keyword) {
        return errorResponse(res, 'Thiếu từ khóa tìm kiếm', 400);
      }

      const data = await productService.search(keyword);

      return successResponse(
        res,
        data,
        'Tìm kiếm sản phẩm thành công'
      );

    } catch (err) {
      next(err);
    }
  },

  /* =========================================================
     GET PRODUCT BY ID
     API: GET /api/products/:id
  ========================================================= */
  async getById(req, res, next) {
    try {
      const productId = toInt(req.params.id);

      if (!productId) {
        return errorResponse(res, 'ID sản phẩm không hợp lệ', 400);
      }

      const product = await productService.findById(productId);

      if (!product) {
        return errorResponse(res, 'Không tìm thấy sản phẩm', 404);
      }

      return successResponse(
        res,
        product,
        'Lấy chi tiết sản phẩm thành công'
      );

    } catch (err) {
      next(err);
    }
  },

  /* =========================================================
     CREATE PRODUCT
     API: POST /api/products

     Lưu ý route phải có:
     uploadProductImage.single('image')
  ========================================================= */
  async createProduct(req, res, next) {
    try {
      const productData = buildProductData(req);

      const createdProduct = await productService.createProduct(productData);

      return successResponse(
        res,
        createdProduct,
        'Tạo sản phẩm thành công',
        201
      );

    } catch (err) {
      next(err);
    }
  },

  /* =========================================================
     UPDATE PRODUCT
     API: PUT /api/products/:id

     Lưu ý route phải có:
     uploadProductImage.single('image')
  ========================================================= */
  async updateProduct(req, res, next) {
    try {
      const productId = toInt(req.params.id);

      if (!productId) {
        return errorResponse(res, 'ID sản phẩm không hợp lệ', 400);
      }

      const productData = buildProductData(req);

      const updatedProduct = await productService.updateProduct(
        productId,
        productData
      );

      return successResponse(
        res,
        updatedProduct,
        'Cập nhật sản phẩm thành công'
      );

    } catch (err) {
      next(err);
    }
  },

  /* =========================================================
     GET PRODUCTS BY CATEGORY
     API: GET /api/products/category/:id
  ========================================================= */
  async getByCategory(req, res, next) {
    try {
      const categoryId = toInt(req.params.id);

      if (!categoryId) {
        return errorResponse(res, 'Category ID không hợp lệ', 400);
      }

      const products = await productService.getByCategory(categoryId);

      return successResponse(
        res,
        products,
        'Lấy sản phẩm theo danh mục thành công'
      );

    } catch (err) {
      next(err);
    }
  },

  /* =========================================================
     GET CATEGORIES WITH PRODUCTS
     API: GET /api/products/categories-with-products
  ========================================================= */
  async getCategoriesWithProducts(req, res, next) {
    try {
      const data = await productService.getCategoriesWithProducts();

      return successResponse(
        res,
        data,
        'Lấy danh mục kèm sản phẩm thành công'
      );

    } catch (err) {
      next(err);
    }
  },

  /* =========================================================
     GET CATEGORIES
     API: GET /api/products/categories
  ========================================================= */
  async getCategories(req, res, next) {
    try {
      const categories = await productService.getCategories();

      return successResponse(
        res,
        categories,
        'Lấy danh mục thành công'
      );

    } catch (err) {
      next(err);
    }
  },

  /* =========================================================
     GET PRODUCT UNITS
     API: GET /api/products/units
  ========================================================= */
  async getUnits(req, res, next) {
    try {
      const units = await productService.getUnits();

      return successResponse(
        res,
        units,
        'Lấy đơn vị tính thành công'
      );

    } catch (err) {
      next(err);
    }
  },

  /* =========================================================
     GET PRODUCT STATUSES
     API: GET /api/products/statuses
  ========================================================= */
  async getStatuses(req, res, next) {
    try {
      const statuses = await productService.getStatuses();

      return successResponse(
        res,
        statuses,
        'Lấy trạng thái sản phẩm thành công'
      );

    } catch (err) {
      next(err);
    }
  },

  /* =========================================================
     GET CROPS
     API: GET /api/products/crops
  ========================================================= */
  async getCrops(req, res, next) {
    try {
      const crops = await productService.getCrops();

      return successResponse(
        res,
        crops,
        'Lấy danh sách cây trồng thành công'
      );

    } catch (err) {
      next(err);
    }
  },

  /* =========================================================
     GET PESTS
     API: GET /api/products/pests
  ========================================================= */
  async getPests(req, res, next) {
    try {
      const pests = await productService.getPests();

      return successResponse(
        res,
        pests,
        'Lấy danh sách sâu bệnh thành công'
      );

    } catch (err) {
      next(err);
    }
  },

  /* =========================================================
     GET TOXICITY LEVELS
     API: GET /api/products/toxicity-levels
  ========================================================= */
  async getToxicityLevels(req, res, next) {
    try {
      const levels = await productService.getToxicityLevels();

      return successResponse(
        res,
        levels,
        'Lấy danh sách mức độc thành công'
      );

    } catch (err) {
      next(err);
    }
  },

  /* =========================================================
     DELETE PRODUCT - SOFT DELETE
     API: DELETE /api/products/:id
  ========================================================= */
  async deleteProduct(req, res, next) {
    try {
      const productId = toInt(req.params.id);

      if (!productId) {
        return errorResponse(res, 'ID sản phẩm không hợp lệ', 400);
      }

      await productService.deleteProduct(productId);

      return successResponse(
        res,
        null,
        'Xóa sản phẩm thành công'
      );

    } catch (err) {
      next(err);
    }
  },

  /* =========================================================
     GET PRODUCT DASHBOARD
     API: GET /api/products/dashboard
  ========================================================= */
  async getDashboard(req, res, next) {
    try {
      const data = await productService.getDashboard();

      return successResponse(
        res,
        data,
        'Lấy dữ liệu dashboard sản phẩm thành công'
      );

    } catch (err) {
      next(err);
    }
  },

  /* =========================================================
     GET ACTIVE PRODUCT BANNER
     API: GET /api/products/banner/active
  ========================================================= */
  async getActiveBanner(req, res, next) {
    try {
      const banner = await productService.getActiveBanner();

      return successResponse(
        res,
        banner,
        'Lấy banner sản phẩm thành công'
      );

    } catch (err) {
      next(err);
    }
  },

  /* =========================================================
     GET PRODUCT BANNERS
     API: GET /api/products/banners
  ========================================================= */
  async getBanners(req, res, next) {
    try {
      const banners = await productService.getBanners();

      return successResponse(
        res,
        banners,
        'Lấy danh sách banner thành công'
      );

    } catch (err) {
      next(err);
    }
  },

  /* =========================================================
     UPDATE PRODUCT BANNER
     API: PUT /api/products/banners/:id
  ========================================================= */
  async updateBanner(req, res, next) {
    try {
      const banner = await productService.updateBanner(
        req.params.id,
        req.body
      );

      return successResponse(
        res,
        banner,
        'Cập nhật banner thành công'
      );

    } catch (err) {
      next(err);
    }
  }
};

module.exports = productController;