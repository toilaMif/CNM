const { pool } = require('../../config/database');

// Tú thêm: schema lưu embedding sản phẩm bằng MySQL JSON.
const EMBEDDING_TABLE_SQL = `
  CREATE TABLE IF NOT EXISTS product_embeddings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT NOT NULL,
    content TEXT NOT NULL,
    embedding JSON NOT NULL,
    model VARCHAR(100) DEFAULT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    UNIQUE KEY uq_product_embedding (ProductID),
    FOREIGN KEY (ProductID) REFERENCES products(ProductID) ON DELETE CASCADE
  )
`;

// Tú thêm: SELECT gom thông tin sản phẩm, tồn kho và dữ liệu thuốc BVTV cho AI advisor.
const PRODUCT_AI_SELECT = `
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
    p.TechnicalContent,
    p.UsageInstructions,
    p.ImageID,
    i.URL AS ImageURL,
    p.IsActive,
    p.CreatedAt,
    p.UpdatedAt,

    c.CategoryName,
    u.Name AS UnitName,
    TRIM(REPLACE(REPLACE(s.Name, CHAR(13), ''), CHAR(10), '')) AS StatusName,

    COALESCE(inv.Quantity, 0) AS Quantity,
    COALESCE(inv.AllocatedQuantity, 0) AS AllocatedQuantity,
    COALESCE(inv.AvailableQuantity, 0) AS AvailableQuantity,
    COALESCE(inv.MinStockLevel, 0) AS MinStockLevel,
    inv.LocationRacks,
    inv.BatchNumbers,
    inv.NearestExpiryDate,

    pest.PesticideName,
    pest.PesticideDescription,
    pest.Dosage,
    pest.Method,
    pest.UseTime,
    pest.HarvestInterval,
    pest.SafetyWarning,
    pest.Precaution,
    pest.CropNames,
    pest.PestNames,
    pest.ToxicLevels

  FROM products p

  LEFT JOIN category c
    ON p.CategoryID = c.CategoryID

  LEFT JOIN product_unit u
    ON p.UnitID = u.PUnitID

  LEFT JOIN product_status s
    ON p.StatusID = s.StatusID

  LEFT JOIN product_image i
    ON p.ImageID = i.ImageID

  LEFT JOIN (
    SELECT
      ProductID,
      SUM(Quantity) AS Quantity,
      SUM(AllocatedQuantity) AS AllocatedQuantity,
      SUM(Quantity - AllocatedQuantity) AS AvailableQuantity,
      MIN(MinStockLevel) AS MinStockLevel,
      GROUP_CONCAT(DISTINCT NULLIF(LocationRack, '') SEPARATOR ', ') AS LocationRacks,
      GROUP_CONCAT(DISTINCT NULLIF(BatchNumber, '') SEPARATOR ', ') AS BatchNumbers,
      MIN(ExpiryDate) AS NearestExpiryDate
    FROM inventory
    GROUP BY ProductID
  ) inv
    ON p.ProductID = inv.ProductID

  LEFT JOIN (
    SELECT
      pe.ProductID,
      MAX(pe.Name) AS PesticideName,
      MAX(pe.Description) AS PesticideDescription,
      MAX(pd.Dosage) AS Dosage,
      MAX(pd.Method) AS Method,
      MAX(pd.Time) AS UseTime,
      MAX(pd.Harvest_interval) AS HarvestInterval,
      MAX(pd.Safety_warning) AS SafetyWarning,
      MAX(pu.Precaution) AS Precaution,
      GROUP_CONCAT(DISTINCT crops.Name ORDER BY crops.Name SEPARATOR ', ') AS CropNames,
      GROUP_CONCAT(DISTINCT pests.PestName ORDER BY pests.PestName SEPARATOR ', ') AS PestNames,
      GROUP_CONCAT(DISTINCT toxicity.Level ORDER BY toxicity.Level SEPARATOR ', ') AS ToxicLevels
    FROM pesticide pe
    LEFT JOIN pesticide_detail pd
      ON pe.PID = pd.PID
    LEFT JOIN pesticide_usage pu
      ON pd.PDetailID = pu.PDetailID
    LEFT JOIN toxicity_level_detail toxicity
      ON pu.ToxicID = toxicity.ToxicID
    LEFT JOIN pesticide_crops pc
      ON pd.PDetailID = pc.PDetailID
    LEFT JOIN crops
      ON pc.CropID = crops.CropID
    LEFT JOIN pesticide_pests pp
      ON pd.PDetailID = pp.PDetailID
    LEFT JOIN pests
      ON pp.PestID = pests.PestID
    GROUP BY pe.ProductID
  ) pest
    ON p.ProductID = pest.ProductID
`;

function normalizeIdList(list) {
  if (!Array.isArray(list)) {
    return [];
  }

  return [
    ...new Set(
      list
        .map((id) => Number(id))
        .filter((id) => Number.isInteger(id) && id > 0)
    )
  ];
}

function toPositiveInteger(value, fallback = null) {
  const numberValue = Number(value);

  if (!Number.isInteger(numberValue) || numberValue <= 0) {
    return fallback;
  }

  return numberValue;
}

function parseEmbedding(value) {
  if (Array.isArray(value)) {
    return value.map(Number).filter(Number.isFinite);
  }

  if (typeof value === 'string') {
    try {
      const parsed = JSON.parse(value);
      return parseEmbedding(parsed);
    } catch (error) {
      return [];
    }
  }

  if (value && typeof value === 'object') {
    if (Array.isArray(value.embedding)) {
      return parseEmbedding(value.embedding);
    }
  }

  return [];
}

const aiAdvisorRepository = {
  // Tú thêm: tạo bảng product_embeddings nếu database chưa có.
  async ensureEmbeddingTable() {
    await pool.query(EMBEDDING_TABLE_SQL);
  },

  // Tú thêm: lưu hoặc cập nhật embedding theo từng ProductID.
  async upsertProductEmbedding(productId, content, embedding, model) {
    await pool.execute(
      `
      INSERT INTO product_embeddings (
        ProductID,
        content,
        embedding,
        model
      )
      VALUES (?, ?, ?, ?)
      ON DUPLICATE KEY UPDATE
        content = VALUES(content),
        embedding = VALUES(embedding),
        model = VALUES(model)
      `,
      [
        productId,
        content,
        JSON.stringify(embedding),
        model || null
      ]
    );
  },

  // Tú thêm: đếm số embedding đã đồng bộ.
  async countEmbeddings() {
    const [rows] = await pool.query(`
      SELECT COUNT(*) AS total
      FROM product_embeddings
    `);

    return rows[0]?.total || 0;
  },

  // Tú thêm: lấy embedding đã lưu để tính similarity trong app.
  async findStoredEmbeddings() {
    const [rows] = await pool.query(`
      SELECT
        id,
        ProductID,
        content,
        embedding,
        model,
        updated_at
      FROM product_embeddings
    `);

    return rows.map((row) => ({
      ...row,
      embedding: parseEmbedding(row.embedding)
    }));
  },

  // Tú thêm: lấy dữ liệu sản phẩm thật từ database để đưa cho LLM.
  async findProductsForAi({ productIds = [], productId = null, limit = null } = {}) {
    const ids = normalizeIdList([
      ...productIds,
      productId
    ]);

    const conditions = ['p.IsActive = 1'];
    const params = [];

    if (ids.length) {
      conditions.push(`p.ProductID IN (${ids.map(() => '?').join(', ')})`);
      params.push(...ids);
    }

    const currentLimit = toPositiveInteger(limit);
    const limitSql = currentLimit ? `LIMIT ${currentLimit}` : '';

    const [rows] = await pool.execute(
      `
      ${PRODUCT_AI_SELECT}
      WHERE ${conditions.join(' AND ')}
      ORDER BY p.ProductID DESC
      ${limitSql}
      `,
      params
    );

    if (!ids.length) {
      return rows;
    }

    const orderMap = new Map(ids.map((id, index) => [id, index]));

    return rows.sort((a, b) => {
      return orderMap.get(a.ProductID) - orderMap.get(b.ProductID);
    });
  },

  // Tú thêm: lấy danh sách sản phẩm theo ID đã được search/rank.
  async findProductsByIds(productIds) {
    const ids = normalizeIdList(productIds);

    if (!ids.length) {
      return [];
    }

    return this.findProductsForAi({ productIds: ids });
  }
};

module.exports = aiAdvisorRepository;
