const productModel = {

  /* =========================================================
     DATABASE -> API RESPONSE
  ========================================================= */
  toResponse(row) {

    return {
      id: row.ProductID,

      name: row.ProductName,

      sku: row.SKU,

      slug: row.Slug,

      description: row.Description,

      price: row.Price,

      quantity: row.Quantity,

      availableQuantity: row.AvailableQuantity,

      allocatedQuantity: row.AllocatedQuantity,

      minStockLevel: row.MinStockLevel,

      locationRack: row.LocationRack,

      expiryDate: row.ExpiryDate,

      batchNumber: row.BatchNumber,

      brand: row.Brand,

      originCountry: row.OriginCountry,

      weight: row.Weight,

      isActive: row.IsActive,

      technicalContent: row.TechnicalContent,

      usageInstructions: row.UsageInstructions,

      createdAt: row.CreatedAt,

      updatedAt: row.UpdatedAt,

      category: {
        id: row.CategoryID,
        name: row.CategoryName,
      },

      status: {
        id: row.StatusID,
        name: row.StatusName,
      },

      unit: {
        id: row.UnitID,
        name: row.UnitName,
      },

      image: {
        id: row.ImageID,
        url: row.ImageURL,
      },
    };
  },

  /* =========================================================
     API PAYLOAD -> DATABASE
  ========================================================= */
  toDatabase(payload) {

    return {

      /* ================= PRODUCTS ================= */

      ProductName: payload.name,

      SKU: payload.sku,

      Slug: payload.slug,

      Description: payload.description,

      Price: payload.price,

      CategoryID: payload.categoryId,

      StatusID: payload.statusId,

      UnitID: payload.unitId,

      ImageID: payload.imageId,

      Brand: payload.brand,

      OriginCountry: payload.originCountry,

      Weight: payload.weight,

      IsActive: payload.isActive,

      TechnicalContent: payload.technicalContent,

      UsageInstructions: payload.usageInstructions,

      /* ================= INVENTORY ================= */

      Quantity: payload.quantity,

      AllocatedQuantity: payload.allocatedQuantity,

      MinStockLevel: payload.minStockLevel,

      LocationRack: payload.locationRack,

      ExpiryDate: payload.expiryDate,

      BatchNumber: payload.batchNumber,

      AvailableQuantity: row.AvailableQuantity,

    };
  },
};

module.exports = productModel;