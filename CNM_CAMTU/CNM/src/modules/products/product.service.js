const productRepository = require('./product.repository');

/* =========================================================
   HELPERS
========================================================= */

function removeVietnameseTones(str = '') {
  return str
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/đ/g, 'd')
    .replace(/Đ/g, 'D');
}

function toNumber(value) {
  if (value === undefined || value === null || value === '') {
    return null;
  }

  const numberValue = Number(value);

  return Number.isNaN(numberValue) ? null : numberValue;
}

function normalizeIdList(list) {
  if (!Array.isArray(list)) {
    return [];
  }

  return [
    ...new Set(
      list
        .map(id => Number(id))
        .filter(id => Number.isInteger(id) && id > 0)
    )
  ];
}

function generateSlug(productName) {
  return removeVietnameseTones(productName)
    .toLowerCase()
    .trim()
    .replace(/[^a-z0-9\s-]/g, '')
    .replace(/\s+/g, '-')
    .replace(/-+/g, '-')
    .replace(/^-|-$/g, '');
}

function normalizeIsActive(value) {
  if (value === 0 || value === '0' || value === false || value === 'false') {
    return 0;
  }

  return 1;
}

function normalizeString(value) {
  if (value === undefined || value === null) {
    return null;
  }

  const text = String(value).trim();

  return text || null;
}

/* =========================================================
   PRODUCT SERVICE
========================================================= */

const productService = {
  /* =========================================================
     GET ALL
  ========================================================= */
  async findAll(params) {
    return productRepository.findAll(params);
  },

  /* =========================================================
     SEARCH
  ========================================================= */
  async search(keyword) {
    if (!keyword?.trim()) {
      throw new Error('Từ khóa tìm kiếm không hợp lệ');
    }

    return productRepository.search(keyword.trim());
  },

  /* =========================================================
     GET BY ID
  ========================================================= */
  async findById(id) {
    const productId = Number(id);

    if (!productId || Number.isNaN(productId)) {
      throw new Error('ID sản phẩm không hợp lệ');
    }

    return productRepository.findById(productId);
  },

  /* =========================================================
     GENERATE SLUG
  ========================================================= */
  generateSlug(productName) {
    return generateSlug(productName);
  },

  /* =========================================================
     VALIDATE PRODUCT CREATE / UPDATE
  ========================================================= */
  validateProductData(productData) {
    if (!productData) {
      throw new Error('Thiếu dữ liệu sản phẩm');
    }

    if (!productData.ProductName || !String(productData.ProductName).trim()) {
      throw new Error('Vui lòng nhập tên sản phẩm');
    }

    const price = toNumber(productData.Price);

    if (price === null || price < 0) {
      throw new Error('Giá sản phẩm không hợp lệ');
    }

    const categoryId = toNumber(productData.CategoryID);

    if (!categoryId) {
      throw new Error('Vui lòng chọn danh mục sản phẩm');
    }

    const statusId = toNumber(productData.StatusID);

    if (!statusId) {
      throw new Error('Vui lòng chọn trạng thái sản phẩm');
    }

    const unitId = toNumber(productData.UnitID);

    if (!unitId) {
      throw new Error('Vui lòng chọn đơn vị tính');
    }

    const weight = toNumber(productData.Weight);

    if (weight !== null && weight < 0) {
      throw new Error('Khối lượng sản phẩm không hợp lệ');
    }
  },

  // Giữ tên cũ để controller/service cũ gọi không bị lỗi.
  validateCreateProduct(productData) {
    return this.validateProductData(productData);
  },

  /* =========================================================
     NORMALIZE PESTICIDE DATA
  ========================================================= */
  normalizePesticideData(pesticideData) {
    if (!pesticideData) {
      return null;
    }

    return {
      Name: normalizeString(pesticideData.Name),
      Description: normalizeString(pesticideData.Description),

      Dosage: normalizeString(pesticideData.Dosage),
      Method: normalizeString(pesticideData.Method),
      Time: normalizeString(pesticideData.Time),
      Harvest_interval: normalizeString(pesticideData.Harvest_interval),
      Safety_warning: normalizeString(pesticideData.Safety_warning),

      ToxicID: pesticideData.ToxicID
        ? toNumber(pesticideData.ToxicID)
        : null,

      Precaution: normalizeString(pesticideData.Precaution),

      CropIDs: normalizeIdList(pesticideData.CropIDs),
      PestIDs: normalizeIdList(pesticideData.PestIDs)
    };
  },

  /* =========================================================
     NORMALIZE PRODUCT DATA
     Dùng chung cho create và update.
  ========================================================= */
  normalizeProductData(productData, slug) {
    return {
      ProductName: String(productData.ProductName).trim(),
      Slug: slug,

      Description: normalizeString(productData.Description),
      Price: toNumber(productData.Price),

      CategoryID: toNumber(productData.CategoryID),
      StatusID: toNumber(productData.StatusID),
      UnitID: toNumber(productData.UnitID),

      ImageID: productData.ImageID ? toNumber(productData.ImageID) : null,

      Brand: normalizeString(productData.Brand),
      OriginCountry: normalizeString(productData.OriginCountry),
      Weight: toNumber(productData.Weight),

      IsActive: normalizeIsActive(productData.IsActive),

      TechnicalContent: normalizeString(productData.TechnicalContent),
      UsageInstructions: normalizeString(productData.UsageInstructions),

      /*
        imageData lấy từ controller khi upload ảnh thật:
        {
          Name: req.file.filename,
          URL: `/images/uploads/products/${req.file.filename}`,
          ImageTypeID: 1
        }
      */
      imageData: productData.imageData || null,

      pesticideData: this.normalizePesticideData(productData.pesticideData)
    };
  },

  /* =========================================================
     CREATE PRODUCT
  ========================================================= */
  async createProduct(productData) {
    this.validateProductData(productData);

    const productName = String(productData.ProductName).trim();
    const slug = this.generateSlug(productName);

    const existingSlug = await productRepository.findBySlug(slug);

    if (existingSlug) {
      throw new Error('Slug sản phẩm đã tồn tại');
    }

    const newProduct = this.normalizeProductData(productData, slug);

    const createdProduct = await productRepository.createProduct(newProduct);

    return {
      ...createdProduct,

      ProductName: newProduct.ProductName,
      Slug: newProduct.Slug,
      Description: newProduct.Description,
      Price: newProduct.Price,

      CategoryID: newProduct.CategoryID,
      StatusID: newProduct.StatusID,
      UnitID: newProduct.UnitID,

      ImageID: createdProduct.ImageID || newProduct.ImageID,

      Brand: newProduct.Brand,
      OriginCountry: newProduct.OriginCountry,
      Weight: newProduct.Weight,
      IsActive: newProduct.IsActive,

      TechnicalContent: newProduct.TechnicalContent,
      UsageInstructions: newProduct.UsageInstructions,

      pesticide: createdProduct.pesticide || null
    };
  },

  /* =========================================================
     UPDATE PRODUCT
     Lưu ý:
     - Nếu không upload ảnh mới và không gửi ImageID, repository sẽ set ImageID = null
       theo bản repository đã đưa.
     - Cách tốt nhất: controller khi update nên gửi ImageID hiện tại,
       hoặc repository cần update động.
  ========================================================= */
  async updateProduct(productId, productData) {
    const id = Number(productId);

    if (!id || Number.isNaN(id)) {
      throw new Error('ID sản phẩm không hợp lệ');
    }

    this.validateProductData(productData);

    const productName = String(productData.ProductName).trim();
    const slug = this.generateSlug(productName);

    const existingProduct = await productRepository.findBySlug(slug);

    if (existingProduct && Number(existingProduct.id || existingProduct.ProductID) !== id) {
      throw new Error('Slug sản phẩm đã tồn tại');
    }

    const updateData = this.normalizeProductData(productData, slug);

    return productRepository.updateProduct(id, updateData);
  },

  /* =========================================================
     GET BY CATEGORY
  ========================================================= */
  async getByCategory(categoryId) {
    const id = Number(categoryId);

    if (!id || Number.isNaN(id)) {
      throw new Error('Category ID không hợp lệ');
    }

    return productRepository.getByCategory(id);
  },

  /* =========================================================
     CATEGORY + PRODUCTS
  ========================================================= */
  async getCategoriesWithProducts() {
    return productRepository.getCategoriesWithProducts();
  },

  /* =========================================================
     EXTRACT CATEGORIES FROM PRODUCTS
  ========================================================= */
  async getCategoriesFromProducts() {
    const result = await productRepository.findAll({
      page: 1,
      limit: 1000
    });

    const products = Array.isArray(result)
      ? result
      : result.items || [];

    const map = new Map();

    products.forEach(product => {
      if (product.category) {
        map.set(product.category.id, product.category);
      }
    });

    return Array.from(map.values());
  },

  /* =========================================================
     UPDATE QUANTITY
  ========================================================= */
  async updateQuantity() {
    throw new Error(
      'updateQuantity nên chuyển sang inventory.service.js để tránh lẫn nghiệp vụ sản phẩm và kho'
    );
  },

  /* =========================================================
     GET CATEGORIES
  ========================================================= */
  async getCategories() {
    const rows = await productRepository.getCategories();

    return rows.map(row => ({
      id: row.CategoryID,
      name: row.CategoryName,
      description: row.Description || null
    }));
  },

  /* =========================================================
     GET UNITS
  ========================================================= */
  async getUnits() {
    const rows = await productRepository.getUnits();

    return rows.map(row => ({
      id: row.PUnitID,
      name: row.Name
    }));
  },

  /* =========================================================
     GET STATUSES
  ========================================================= */
  async getStatuses() {
    const rows = await productRepository.getStatuses();

    return rows.map(row => ({
      id: row.StatusID,
      name: row.Name
    }));
  },

  /* =========================================================
     GET CROPS
  ========================================================= */
  async getCrops() {
    const rows = await productRepository.getCrops();

    return rows.map(row => ({
      id: row.CropID,
      name: row.Name,
      description: row.Description || null
    }));
  },

  /* =========================================================
     GET PESTS
  ========================================================= */
  async getPests() {
    const rows = await productRepository.getPests();

    return rows.map(row => ({
      id: row.PestID,
      name: row.PestName,
      description: row.Description || null
    }));
  },

  /* =========================================================
     GET TOXICITY LEVELS
  ========================================================= */
  async getToxicityLevels() {
    const rows = await productRepository.getToxicityLevels();

    return rows.map(row => ({
      id: row.ToxicID,
      level: row.Level,
      description: row.Description || null
    }));
  },

  /* =========================================================
     DELETE PRODUCT - SOFT DELETE
  ========================================================= */
  async deleteProduct(productId) {
    const id = Number(productId);

    if (!id || Number.isNaN(id)) {
      throw new Error('ID sản phẩm không hợp lệ');
    }

    const result = await productRepository.updateIsActive(id, 0);

    const queryResult = Array.isArray(result) ? result[0] : result;

    if (!queryResult || queryResult.affectedRows === 0) {
      throw new Error('Không tìm thấy sản phẩm để xóa');
    }

    return {
      success: true,
      message: 'Xóa sản phẩm thành công (soft delete)',
      productId: id
    };
  },

  /* =========================================================
     GET PRODUCT DASHBOARD
  ========================================================= */
  async getDashboard() {
    return productRepository.getDashboard();
  },

  /* =========================================================
     GET ACTIVE BANNER
  ========================================================= */
  async getActiveBanner() {
    return productRepository.getActiveBanner();
  },

  /* =========================================================
     GET BANNERS
  ========================================================= */
  async getBanners() {
    return productRepository.getBanners();
  },

  /* =========================================================
     UPDATE BANNER
  ========================================================= */
  async updateBanner(bannerId, bannerData) {
    const id = Number(bannerId);

    if (!id || Number.isNaN(id)) {
      throw new Error('ID banner không hợp lệ');
    }

    if (!bannerData.Title || !String(bannerData.Title).trim()) {
      throw new Error('Vui lòng nhập tiêu đề banner');
    }

    const updateData = {
      Title: String(bannerData.Title).trim(),
      Subtitle: normalizeString(bannerData.Subtitle),
      Description: normalizeString(bannerData.Description),
      ImageURL: normalizeString(bannerData.ImageURL),
      ButtonText: normalizeString(bannerData.ButtonText),
      ButtonLink: normalizeString(bannerData.ButtonLink),
      IsActive: normalizeIsActive(bannerData.IsActive)
    };

    const result = await productRepository.updateBanner(id, updateData);

    if (!result || result.affectedRows === 0) {
      throw new Error('Không tìm thấy banner để cập nhật');
    }

    return {
      BannerID: id,
      ...updateData
    };
  }
};

module.exports = productService;