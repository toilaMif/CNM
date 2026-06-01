const { pool } = require('../../config/database');
const productModel = require('./product.model');

/* =========================================================
   COMMON SELECT
========================================================= */
const PRODUCT_SELECT = `
  SELECT 
    p.ProductID,
    p.ProductName,
    p.SKU,
    p.Slug,
    p.Description,
    p.Price,
    p.Brand,
    p.OriginCountry,
    p.Weight,
    p.IsActive,
    p.TechnicalContent,
    p.UsageInstructions,
    p.CreatedAt,
    p.UpdatedAt,

    p.CategoryID,
    c.CategoryName,

    p.StatusID,
    TRIM(REPLACE(REPLACE(s.Name, CHAR(13), ''), CHAR(10), '')) AS StatusName,

    p.UnitID,
    u.Name AS UnitName,

    p.ImageID,
    i.Name AS ImageName,
    i.URL AS ImageURL,
    i.ImageTypeID,

    inv.InventoryID,
    inv.Quantity,
    inv.AvailableQuantity,
    inv.AllocatedQuantity,
    inv.MinStockLevel,
    inv.LocationRack,
    inv.ExpiryDate,
    inv.BatchNumber

  FROM products p

  LEFT JOIN category c
    ON p.CategoryID = c.CategoryID

  LEFT JOIN product_status s
    ON p.StatusID = s.StatusID

  LEFT JOIN product_unit u
    ON p.UnitID = u.PUnitID

  LEFT JOIN product_image i
    ON p.ImageID = i.ImageID

  LEFT JOIN inventory inv
    ON p.ProductID = inv.ProductID
`;

/* =========================================================
   HELPERS
========================================================= */
function normalizeIdList(list) {
  if (!Array.isArray(list)) return [];

  return [
    ...new Set(
      list
        .map(id => Number(id))
        .filter(id => Number.isInteger(id) && id > 0)
    )
  ];
}

function toNullableNumber(value) {
  if (value === undefined || value === null || value === '') {
    return null;
  }

  const numberValue = Number(value);

  return Number.isNaN(numberValue) ? null : numberValue;
}

function toActiveValue(value) {
  if (value === undefined || value === null || value === '') {
    return 1;
  }

  return Number(value);
}

/* =========================================================
   PRODUCT REPOSITORY
========================================================= */
const productRepository = {
  /* =========================================================
     FIND ALL
  ========================================================= */
  async findAll({
    page = 1,
    limit = 10,
    keyword = '',
    categoryId = null,
    sort = 'newest'
  } = {}) {
    const currentPage = Number.parseInt(page, 10) > 0
      ? Number.parseInt(page, 10)
      : 1;

    const currentLimit = Number.parseInt(limit, 10) > 0
      ? Number.parseInt(limit, 10)
      : 10;

    const offset = (currentPage - 1) * currentLimit;

    const conditions = ['p.IsActive = 1'];
    const params = [];

    if (keyword && keyword.trim()) {
      conditions.push(`
        (
          p.ProductName LIKE ?
          OR p.SKU LIKE ?
          OR p.Brand LIKE ?
          OR p.Description LIKE ?
        )
      `);

      const searchKeyword = `%${keyword.trim()}%`;

      params.push(
        searchKeyword,
        searchKeyword,
        searchKeyword,
        searchKeyword
      );
    }

    if (categoryId) {
      const cateId = Number.parseInt(categoryId, 10);

      if (!Number.isNaN(cateId) && cateId > 0) {
        conditions.push('p.CategoryID = ?');
        params.push(cateId);
      }
    }

    let orderBy = 'p.ProductID DESC';

    if (sort === 'oldest') orderBy = 'p.ProductID ASC';
    if (sort === 'price_asc') orderBy = 'p.Price ASC';
    if (sort === 'price_desc') orderBy = 'p.Price DESC';
    if (sort === 'name_asc') orderBy = 'p.ProductName ASC';
    if (sort === 'name_desc') orderBy = 'p.ProductName DESC';

    const whereSql = `WHERE ${conditions.join(' AND ')}`;

    const [rows] = await pool.execute(
      `
      ${PRODUCT_SELECT}
      ${whereSql}
      ORDER BY ${orderBy}
      LIMIT ${currentLimit} OFFSET ${offset}
      `,
      params
    );

    const [countRows] = await pool.execute(
      `
      SELECT COUNT(*) AS total
      FROM products p
      ${whereSql}
      `,
      params
    );

    return {
      items: rows.map(productModel.toResponse),
      pagination: {
        page: currentPage,
        limit: currentLimit,
        total: countRows[0].total,
        totalPages: Math.ceil(countRows[0].total / currentLimit)
      }
    };
  },

  /* =========================================================
     FIND BY ID
  ========================================================= */
  async findById(productId) {
    const [rows] = await pool.execute(
      `
      ${PRODUCT_SELECT}
      WHERE p.ProductID = ?
      LIMIT 1
      `,
      [productId]
    );

    return rows.length
      ? productModel.toResponse(rows[0])
      : null;
  },

  /* =========================================================
     FIND BY SLUG
  ========================================================= */
  async findBySlug(slug) {
    const [rows] = await pool.execute(
      `
      ${PRODUCT_SELECT}
      WHERE p.Slug = ?
      LIMIT 1
      `,
      [slug]
    );

    return rows.length
      ? productModel.toResponse(rows[0])
      : null;
  },

  /* =========================================================
     FIND BY SKU
  ========================================================= */
  async findBySKU(sku) {
    const [rows] = await pool.execute(
      `
      ${PRODUCT_SELECT}
      WHERE p.SKU = ?
      LIMIT 1
      `,
      [sku]
    );

    return rows.length
      ? productModel.toResponse(rows[0])
      : null;
  },

  /* =========================================================
     EXISTS BY NAME
  ========================================================= */
  async existsByName(productName) {
    const [rows] = await pool.execute(
      `
      SELECT ProductID
      FROM products
      WHERE ProductName = ?
      LIMIT 1
      `,
      [productName]
    );

    return rows.length > 0;
  },

  /* =========================================================
     EXISTS BY SLUG
  ========================================================= */
  async existsBySlug(slug) {
    const [rows] = await pool.execute(
      `
      SELECT ProductID
      FROM products
      WHERE Slug = ?
      LIMIT 1
      `,
      [slug]
    );

    return rows.length > 0;
  },

  /* =========================================================
     CHECK PRODUCT_IMAGE HAS PRODUCTID
     Dùng để tránh lỗi nếu bảng product_image chưa có cột ProductID.
  ========================================================= */
  async hasProductImageProductIdColumn(connection) {
    const [rows] = await connection.execute(
      `
      SELECT COUNT(*) AS total
      FROM INFORMATION_SCHEMA.COLUMNS
      WHERE TABLE_SCHEMA = DATABASE()
        AND TABLE_NAME = 'product_image'
        AND COLUMN_NAME = 'ProductID'
      `
    );

    return rows[0].total > 0;
  },

  /* =========================================================
     CREATE PRODUCT IMAGE
     Dùng cho upload ảnh thật.

     imageData mẫu:
     {
       Name: '1779604819953-sp1.jpg',
       URL: '/images/uploads/products/1779604819953-sp1.jpg',
       ImageTypeID: 1
     }
  ========================================================= */
  async createProductImage(connection, imageData, productId = null) {
    if (!imageData || !imageData.URL) {
      return null;
    }

    const hasProductIdColumn =
      await productRepository.hasProductImageProductIdColumn(connection);

    if (hasProductIdColumn) {
      const [result] = await connection.execute(
        `
        INSERT INTO product_image (
          ProductID,
          Name,
          URL,
          ImageTypeID
        )
        VALUES (?, ?, ?, ?)
        `,
        [
          productId,
          imageData.Name || null,
          imageData.URL,
          imageData.ImageTypeID || 1
        ]
      );

      return result.insertId;
    }

    const [result] = await connection.execute(
      `
      INSERT INTO product_image (
        Name,
        URL,
        ImageTypeID
      )
      VALUES (?, ?, ?)
      `,
      [
        imageData.Name || null,
        imageData.URL,
        imageData.ImageTypeID || 1
      ]
    );

    return result.insertId;
  },

  /* =========================================================
     ATTACH IMAGE TO PRODUCT
     - Gắn products.ImageID
     - Nếu product_image có ProductID thì gắn ngược lại
  ========================================================= */
  async attachProductImageToProduct(connection, productId, imageId) {
    if (!productId || !imageId) return;

    await connection.execute(
      `
      UPDATE products
      SET ImageID = ?
      WHERE ProductID = ?
      `,
      [imageId, productId]
    );

    const hasProductIdColumn =
      await productRepository.hasProductImageProductIdColumn(connection);

    if (hasProductIdColumn) {
      await connection.execute(
        `
        UPDATE product_image
        SET ProductID = ?
        WHERE ImageID = ?
        `,
        [productId, imageId]
      );
    }
  },

  /* =========================================================
     CREATE PESTICIDE INFO
  ========================================================= */
  async createPesticideInfo(connection, productId, pesticideData) {
    if (!pesticideData) {
      return null;
    }

    const [pesticideResult] = await connection.execute(
      `
      INSERT INTO pesticide (
        ProductID,
        Name,
        Description
      )
      VALUES (?, ?, ?)
      `,
      [
        productId,
        pesticideData.Name || null,
        pesticideData.Description || null
      ]
    );

    const pesticideId = pesticideResult.insertId;

    const [detailResult] = await connection.execute(
      `
      INSERT INTO pesticide_detail (
        PID,
        Dosage,
        Method,
        Time,
        Harvest_interval,
        Safety_warning
      )
      VALUES (?, ?, ?, ?, ?, ?)
      `,
      [
        pesticideId,
        pesticideData.Dosage || null,
        pesticideData.Method || null,
        pesticideData.Time || null,
        pesticideData.Harvest_interval || null,
        pesticideData.Safety_warning || null
      ]
    );

    const pesticideDetailId = detailResult.insertId;

    const cropIds = normalizeIdList(pesticideData.CropIDs);

    for (const cropId of cropIds) {
      await connection.execute(
        `
        INSERT INTO pesticide_crops (
          PDetailID,
          CropID
        )
        VALUES (?, ?)
        `,
        [pesticideDetailId, cropId]
      );
    }

    const pestIds = normalizeIdList(pesticideData.PestIDs);

    for (const pestId of pestIds) {
      await connection.execute(
        `
        INSERT INTO pesticide_pests (
          PDetailID,
          PestID
        )
        VALUES (?, ?)
        `,
        [pesticideDetailId, pestId]
      );
    }

    if (pesticideData.ToxicID || pesticideData.Precaution) {
      await connection.execute(
        `
        INSERT INTO pesticide_usage (
          PDetailID,
          ToxicID,
          Precaution
        )
        VALUES (?, ?, ?)
        `,
        [
          pesticideDetailId,
          pesticideData.ToxicID || null,
          pesticideData.Precaution || null
        ]
      );
    }

    return {
      PID: pesticideId,
      PDetailID: pesticideDetailId,
      CropIDs: cropIds,
      PestIDs: pestIds
    };
  },

  /* =========================================================
     CREATE PRODUCT
     Luồng mới:
     1. Insert products trước, ImageID = NULL
     2. Có ProductID rồi mới insert product_image
     3. Update products.ImageID
     4. Sinh SKU
     5. Tạo pesticide info nếu có
  ========================================================= */
  async createProduct(productData) {
    const connection = await pool.getConnection();

    try {
      await connection.beginTransaction();

      const [insertResult] = await connection.execute(
        `
        INSERT INTO products (
          ProductName,
          SKU,
          Slug,
          Description,
          Price,
          CategoryID,
          StatusID,
          UnitID,
          ImageID,
          Brand,
          OriginCountry,
          Weight,
          IsActive,
          TechnicalContent,
          UsageInstructions
        )
        VALUES (?, NULL, ?, ?, ?, ?, ?, ?, NULL, ?, ?, ?, ?, ?, ?)
        `,
        [
          productData.ProductName,
          productData.Slug,
          productData.Description || null,
          toNullableNumber(productData.Price),
          toNullableNumber(productData.CategoryID),
          toNullableNumber(productData.StatusID),
          toNullableNumber(productData.UnitID),
          productData.Brand || null,
          productData.OriginCountry || null,
          toNullableNumber(productData.Weight),
          toActiveValue(productData.IsActive),
          productData.TechnicalContent || null,
          productData.UsageInstructions || null
        ]
      );

      const productId = insertResult.insertId;

      let imageId = productData.ImageID || null;

      if (!imageId && productData.imageData) {
        imageId = await productRepository.createProductImage(
          connection,
          productData.imageData,
          productId
        );
      }

      if (imageId) {
        await productRepository.attachProductImageToProduct(
          connection,
          productId,
          imageId
        );
      }

      const sku = `SP-${String(productData.CategoryID).padStart(3, '0')}-${String(productId).padStart(6, '0')}`;

      await connection.execute(
        `
        UPDATE products
        SET SKU = ?
        WHERE ProductID = ?
        `,
        [sku, productId]
      );

      let pesticideResult = null;

      if (productData.pesticideData) {
        pesticideResult = await productRepository.createPesticideInfo(
          connection,
          productId,
          productData.pesticideData
        );
      }

      await connection.commit();

      return {
        ProductID: productId,
        SKU: sku,
        Slug: productData.Slug,
        ImageID: imageId,
        pesticide: pesticideResult
      };

    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  },

  /* =========================================================
     UPDATE SKU
  ========================================================= */
  async updateSKU(productId, sku) {
    await pool.execute(
      `
      UPDATE products
      SET SKU = ?
      WHERE ProductID = ?
      `,
      [sku, productId]
    );
  },

  /* =========================================================
     UPDATE PRODUCT
     Đã bỏ bản updateProduct bị trùng.
     Bản này hỗ trợ upload ảnh mới.
  ========================================================= */
  async updateProduct(productId, productData) {
    const connection = await pool.getConnection();

    try {
      await connection.beginTransaction();

      let imageId = productData.ImageID || null;

      if (!imageId && productData.imageData) {
        imageId = await productRepository.createProductImage(
          connection,
          productData.imageData,
          productId
        );
      }

      if (imageId) {
        await productRepository.attachProductImageToProduct(
          connection,
          productId,
          imageId
        );
      }

      const [result] = await connection.execute(
        `
        UPDATE products
        SET
          ProductName = ?,
          Slug = ?,
          Description = ?,
          Price = ?,
          CategoryID = ?,
          StatusID = ?,
          UnitID = ?,
          ImageID = ?,
          Brand = ?,
          OriginCountry = ?,
          Weight = ?,
          IsActive = ?,
          TechnicalContent = ?,
          UsageInstructions = ?
        WHERE ProductID = ?
        `,
        [
          productData.ProductName,
          productData.Slug,
          productData.Description || null,
          toNullableNumber(productData.Price),
          toNullableNumber(productData.CategoryID),
          toNullableNumber(productData.StatusID),
          toNullableNumber(productData.UnitID),
          imageId || null,
          productData.Brand || null,
          productData.OriginCountry || null,
          toNullableNumber(productData.Weight),
          toActiveValue(productData.IsActive),
          productData.TechnicalContent || null,
          productData.UsageInstructions || null,
          productId
        ]
      );

      await connection.commit();

      return {
        ProductID: productId,
        ImageID: imageId,
        affectedRows: result.affectedRows
      };

    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  },

  /* =========================================================
     GET BY CATEGORY
  ========================================================= */
  async getByCategory(categoryId) {
    const [rows] = await pool.execute(
      `
      ${PRODUCT_SELECT}
      WHERE p.IsActive = 1
      AND p.CategoryID = ?
      ORDER BY p.ProductID DESC
      `,
      [categoryId]
    );

    return rows.map(productModel.toResponse);
  },

  /* =========================================================
     SEARCH
  ========================================================= */
  async search(keyword) {
    const searchKeyword = `%${keyword}%`;

    const [rows] = await pool.execute(
      `
      ${PRODUCT_SELECT}
      WHERE p.IsActive = 1
      AND (
        p.ProductName LIKE ?
        OR p.SKU LIKE ?
        OR p.Brand LIKE ?
        OR p.Description LIKE ?
      )
      ORDER BY p.ProductID DESC
      `,
      [
        searchKeyword,
        searchKeyword,
        searchKeyword,
        searchKeyword
      ]
    );

    return rows.map(productModel.toResponse);
  },

  /* =========================================================
     GET CATEGORIES WITH PRODUCTS
  ========================================================= */
  async getCategoriesWithProducts() {
    const [categories] = await pool.execute(
      `
      SELECT 
        CategoryID AS id,
        CategoryName AS name,
        Description AS description
      FROM category
      ORDER BY CategoryID ASC
      `
    );

    const [products] = await pool.execute(
      `
      ${PRODUCT_SELECT}
      WHERE p.IsActive = 1
      ORDER BY p.ProductID DESC
      `
    );

    const formattedProducts = products.map(productModel.toResponse);

    const map = {};

    for (const product of formattedProducts) {
      const categoryId = product.category?.id;

      if (!categoryId) continue;

      if (!map[categoryId]) {
        map[categoryId] = [];
      }

      map[categoryId].push(product);
    }

    return categories.map(category => ({
      id: category.id,
      name: category.name,
      description: category.description,
      products: map[category.id] || []
    }));
  },

  /* =========================================================
     SYNC STATUS BY INVENTORY
  ========================================================= */
  async syncStatusByInventory(productId) {
    const sql = `
      UPDATE products p
      JOIN inventory i
        ON p.ProductID = i.ProductID

      SET p.StatusID = CASE
        WHEN i.AvailableQuantity > 0 THEN 1
        ELSE 2
      END

      WHERE p.ProductID = ?
    `;

    await pool.execute(sql, [productId]);
  },

  /* =========================================================
     GET CATEGORIES
  ========================================================= */
  async getCategories() {
    const [rows] = await pool.query(`
      SELECT
        CategoryID,
        CategoryName,
        Description
      FROM category
      ORDER BY CategoryName ASC
    `);

    return rows;
  },

  /* =========================================================
     GET UNITS
  ========================================================= */
  async getUnits() {
    const [rows] = await pool.query(`
      SELECT
        PUnitID,
        Name
      FROM product_unit
      ORDER BY Name ASC
    `);

    return rows;
  },

  /* =========================================================
     GET STATUSES
  ========================================================= */
  async getStatuses() {
    const [rows] = await pool.query(`
      SELECT
        StatusID,
        TRIM(REPLACE(REPLACE(Name, CHAR(13), ''), CHAR(10), '')) AS Name
      FROM product_status
      ORDER BY StatusID ASC
    `);

    return rows;
  },

  /* =========================================================
     GET CROPS
  ========================================================= */
  async getCrops() {
    const [rows] = await pool.query(`
      SELECT
        CropID,
        Name,
        Description
      FROM crops
      ORDER BY Name ASC
    `);

    return rows;
  },

  /* =========================================================
     GET PESTS
  ========================================================= */
  async getPests() {
    const [rows] = await pool.query(`
      SELECT
        PestID,
        PestName,
        Description
      FROM pests
      ORDER BY PestName ASC
    `);

    return rows;
  },

  /* =========================================================
     GET TOXICITY LEVELS
  ========================================================= */
  async getToxicityLevels() {
    const [rows] = await pool.query(`
      SELECT
        ToxicID,
        Level,
        Description
      FROM toxicity_level_detail
      ORDER BY ToxicID ASC
    `);

    return rows;
  },

  /* =========================================================
     UPDATE ACTIVE STATUS
  ========================================================= */
  async updateIsActive(productId, isActive) {
    return pool.query(
      `
      UPDATE products
      SET IsActive = ?
      WHERE ProductID = ?
      `,
      [isActive, productId]
    );
  },

 /* =========================================================
   GET PRODUCT MANAGER DASHBOARD

   Đồng bộ theo logic inventory.repository.js:
   - TotalPhysicalQty = SUM(Quantity)
   - TotalAvailableQty = SUM(Quantity - AllocatedQuantity)
   - TotalAllocatedQty = SUM(AllocatedQuantity)
   - MinStockLevel = MIN(MinStockLevel)

   Quy tắc:
   - Hết hàng = TotalAvailableQty <= 0
   - Sắp hết hàng = TotalAvailableQty > 0 AND TotalAvailableQty < MinStockLevel
   - Gợi ý nhập = MinStockLevel * 2 - TotalAvailableQty
   - Bán chạy = chỉ tính đơn không bị CANCELLED
========================================================= */
async getDashboard() {
  const inventorySummarySubquery = `
    SELECT
      ProductID,

      COALESCE(SUM(Quantity), 0) AS TotalPhysicalQty,

      COALESCE(SUM(Quantity - AllocatedQuantity), 0) AS TotalAvailableQty,

      COALESCE(SUM(AllocatedQuantity), 0) AS TotalAllocatedQty,

      COALESCE(MIN(MinStockLevel), 0) AS MinStockLevel,

      COALESCE(
        GROUP_CONCAT(DISTINCT LocationRack SEPARATOR ', '),
        ''
      ) AS LocationRacks,

      MIN(ExpiryDate) AS NearestExpiryDate

    FROM inventory

    GROUP BY ProductID
  `;

  const [summaryRows] = await pool.query(`
    SELECT
      COUNT(DISTINCT p.ProductID) AS totalProducts,

      COUNT(DISTINCT CASE
        WHEN p.IsActive = 1 THEN p.ProductID
      END) AS activeProducts,

      COUNT(DISTINCT CASE
        WHEN p.IsActive = 1
         AND COALESCE(inv.TotalAvailableQty, 0) <= 0
        THEN p.ProductID
      END) AS outOfStockProducts,

      COUNT(DISTINCT CASE
        WHEN p.IsActive = 1
         AND COALESCE(inv.TotalAvailableQty, 0) > 0
         AND COALESCE(inv.MinStockLevel, 0) > 0
         AND COALESCE(inv.TotalAvailableQty, 0) < COALESCE(inv.MinStockLevel, 0)
        THEN p.ProductID
      END) AS lowStockProducts,

      COUNT(DISTINCT CASE
        WHEN p.CreatedAt >= DATE_FORMAT(CURRENT_DATE(), '%Y-%m-01')
         AND p.CreatedAt < DATE_ADD(DATE_FORMAT(CURRENT_DATE(), '%Y-%m-01'), INTERVAL 1 MONTH)
        THEN p.ProductID
      END) AS newProductsThisMonth

    FROM products p

    LEFT JOIN (
      ${inventorySummarySubquery}
    ) inv
      ON p.ProductID = inv.ProductID
  `);

  const [bestSellingRows] = await pool.query(`
    SELECT
      p.ProductID,
      p.ProductName,
      p.SKU,
      p.Price,
      c.CategoryName,
      u.Name AS UnitName,

      COALESCE(SUM(CASE
        WHEN o.order_id IS NOT NULL THEN od.quantity
        ELSE 0
      END), 0) AS totalSold,

      COALESCE(SUM(CASE
        WHEN o.order_id IS NOT NULL THEN od.quantity * od.price
        ELSE 0
      END), 0) AS revenue

    FROM products p

    LEFT JOIN order_details od
      ON p.ProductID = od.product_id

    LEFT JOIN orders o
      ON od.order_id = o.order_id
     AND COALESCE(o.status, '') <> 'CANCELLED'

    LEFT JOIN category c
      ON p.CategoryID = c.CategoryID

    LEFT JOIN product_unit u
      ON p.UnitID = u.PUnitID

    WHERE p.IsActive = 1

    GROUP BY
      p.ProductID,
      p.ProductName,
      p.SKU,
      p.Price,
      c.CategoryName,
      u.Name

    HAVING totalSold > 0

    ORDER BY totalSold DESC, revenue DESC

    LIMIT 5
  `);

  const [highStockRows] = await pool.query(`
    SELECT
      p.ProductID,
      p.ProductName,
      p.SKU,
      c.CategoryName,
      u.Name AS UnitName,

      COALESCE(inv.TotalPhysicalQty, 0) AS Quantity,
      COALESCE(inv.TotalAllocatedQty, 0) AS AllocatedQuantity,
      COALESCE(inv.TotalAvailableQty, 0) AS AvailableQuantity,
      COALESCE(inv.MinStockLevel, 0) AS MinStockLevel,
      COALESCE(inv.LocationRacks, '') AS LocationRack,
      inv.NearestExpiryDate AS ExpiryDate

    FROM products p

    LEFT JOIN (
      ${inventorySummarySubquery}
    ) inv
      ON p.ProductID = inv.ProductID

    LEFT JOIN category c
      ON p.CategoryID = c.CategoryID

    LEFT JOIN product_unit u
      ON p.UnitID = u.PUnitID

    WHERE p.IsActive = 1
      AND COALESCE(inv.TotalAvailableQty, 0) > 0

    ORDER BY AvailableQuantity DESC, p.ProductName ASC

    LIMIT 5
  `);

  const [outOfStockRows] = await pool.query(`
    SELECT
      p.ProductID,
      p.ProductName,
      p.SKU,
      c.CategoryName,
      u.Name AS UnitName,

      COALESCE(inv.TotalPhysicalQty, 0) AS Quantity,
      COALESCE(inv.TotalAllocatedQty, 0) AS AllocatedQuantity,
      COALESCE(inv.TotalAvailableQty, 0) AS AvailableQuantity,
      COALESCE(inv.MinStockLevel, 0) AS MinStockLevel,
      COALESCE(inv.LocationRacks, '') AS LocationRack,
      inv.NearestExpiryDate AS ExpiryDate

    FROM products p

    LEFT JOIN (
      ${inventorySummarySubquery}
    ) inv
      ON p.ProductID = inv.ProductID

    LEFT JOIN category c
      ON p.CategoryID = c.CategoryID

    LEFT JOIN product_unit u
      ON p.UnitID = u.PUnitID

    WHERE p.IsActive = 1
      AND COALESCE(inv.TotalAvailableQty, 0) <= 0

    ORDER BY p.ProductName ASC

    LIMIT 200
  `);

  const [lowStockRows] = await pool.query(`
    SELECT
      p.ProductID,
      p.ProductName,
      p.SKU,
      c.CategoryName,
      u.Name AS UnitName,

      COALESCE(inv.TotalPhysicalQty, 0) AS Quantity,
      COALESCE(inv.TotalAllocatedQty, 0) AS AllocatedQuantity,
      COALESCE(inv.TotalAvailableQty, 0) AS AvailableQuantity,
      COALESCE(inv.MinStockLevel, 0) AS MinStockLevel,
      COALESCE(inv.LocationRacks, '') AS LocationRack,
      inv.NearestExpiryDate AS ExpiryDate

    FROM products p

    LEFT JOIN (
      ${inventorySummarySubquery}
    ) inv
      ON p.ProductID = inv.ProductID

    LEFT JOIN category c
      ON p.CategoryID = c.CategoryID

    LEFT JOIN product_unit u
      ON p.UnitID = u.PUnitID

    WHERE p.IsActive = 1
      AND COALESCE(inv.TotalAvailableQty, 0) > 0
      AND COALESCE(inv.MinStockLevel, 0) > 0
      AND COALESCE(inv.TotalAvailableQty, 0) < COALESCE(inv.MinStockLevel, 0)

    ORDER BY AvailableQuantity ASC, MinStockLevel DESC, p.ProductName ASC

    LIMIT 10
  `);

  const reorderSuggestionRows = lowStockRows.map(row => {
    const available = Number(row.AvailableQuantity || 0);
    const minStock = Number(row.MinStockLevel || 0);

    const suggestedQuantity = Math.max((minStock * 2) - available, 0);

    return {
      ...row,
      suggestedQuantity
    };
  });

  const summary = summaryRows[0] || {};

  return {
    summary: {
      totalProducts: Number(summary.totalProducts || 0),
      activeProducts: Number(summary.activeProducts || 0),
      outOfStockProducts: Number(summary.outOfStockProducts || 0),
      lowStockProducts: Number(summary.lowStockProducts || 0),
      newProductsThisMonth: Number(summary.newProductsThisMonth || 0)
    },

    bestSellingProducts: bestSellingRows,
    highStockProducts: highStockRows,

    // Cái này dùng cho modal chọn sản phẩm hết hàng.
    outOfStockProductsList: outOfStockRows,

    lowStockProducts: lowStockRows,
    reorderSuggestions: reorderSuggestionRows
  };
},
};

module.exports = productRepository;