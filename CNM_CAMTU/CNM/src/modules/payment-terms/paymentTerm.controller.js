const paymentTermService = require('./paymentTerm.service');

/* =========================================================
   HELPER: Build payload từ form-data + file upload

   File upload lưu ở:
   src/public/images/uploads/promotions

   URL lưu DB:
   /images/uploads/promotions/<filename>
========================================================= */
function buildPromotionPayload(req) {
  const imageFile = req.files?.image_file?.[0] || null;
  const bannerFile = req.files?.banner_file?.[0] || null;

  return {
    ...req.body,

    image_url: imageFile
      ? `/images/uploads/promotions/${imageFile.filename}`
      : req.body.image_url || null,

    banner_url: bannerFile
      ? `/images/uploads/promotions/${bannerFile.filename}`
      : req.body.banner_url || null
  };
}

/* =========================================================
   GET ACTIVE FOR SALE
========================================================= */
exports.findAllActive = async (req, res) => {
  try {
    const terms = await paymentTermService.findAllActive();

    return res.json({
      success: true,
      data: terms
    });
  } catch (err) {
    console.error('Find active payment terms error:', err);

    return res.status(500).json({
      success: false,
      message: err.message
    });
  }
};

/* =========================================================
   GET ALL
========================================================= */
exports.findAll = async (req, res) => {
  try {
    const terms = await paymentTermService.findAll();

    return res.json({
      success: true,
      data: terms
    });
  } catch (err) {
    console.error('Find all payment terms error:', err);

    return res.status(500).json({
      success: false,
      message: err.message
    });
  }
};

/* =========================================================
   HOME PROMOTIONS
========================================================= */
exports.findHomePromotions = async (req, res) => {
  try {
    const promotions = await paymentTermService.findHomePromotions();

    return res.json({
      success: true,
      data: promotions
    });
  } catch (err) {
    console.error('Find home promotions error:', err);

    return res.status(500).json({
      success: false,
      message: err.message
    });
  }
};

/* =========================================================
   GET BY ID
========================================================= */
exports.findById = async (req, res) => {
  try {
    const term = await paymentTermService.findById(req.params.id);

    return res.json({
      success: true,
      data: term
    });
  } catch (err) {
    return res.status(404).json({
      success: false,
      message: err.message
    });
  }
};

/* =========================================================
   CREATE
   Nhận multipart/form-data:
   - image_file
   - banner_file
========================================================= */
exports.create = async (req, res) => {
  try {
    const payload = buildPromotionPayload(req);

    const result = await paymentTermService.create(payload);

    return res.status(201).json({
      success: true,
      message: 'Tạo chương trình thành công',
      data: result
    });
  } catch (err) {
    console.error('Create payment term error:', err);

    return res.status(400).json({
      success: false,
      message: err.message
    });
  }
};

/* =========================================================
   UPDATE
   Nếu không upload ảnh mới thì giữ image_url/banner_url cũ từ hidden input
========================================================= */
exports.update = async (req, res) => {
  try {
    const payload = buildPromotionPayload(req);

    const result = await paymentTermService.update(
      req.params.id,
      payload
    );

    return res.json({
      success: true,
      message: 'Cập nhật chương trình thành công',
      data: result
    });
  } catch (err) {
    console.error('Update payment term error:', err);

    return res.status(400).json({
      success: false,
      message: err.message
    });
  }
};

/* =========================================================
   UPDATE STATUS ACTIVE
========================================================= */
exports.updateStatus = async (req, res) => {
  try {
    const result = await paymentTermService.updateStatus(
      req.params.id,
      req.body.is_active ?? req.body.status
    );

    return res.json({
      success: true,
      message: 'Cập nhật trạng thái chương trình thành công',
      data: result
    });
  } catch (err) {
    console.error('Update payment term status error:', err);

    return res.status(400).json({
      success: false,
      message: err.message
    });
  }
};

/* =========================================================
   UPDATE HOME DISPLAY
========================================================= */
exports.updateHomeDisplay = async (req, res) => {
  try {
    const result = await paymentTermService.updateHomeDisplay(
      req.params.id,
      req.body
    );

    return res.json({
      success: true,
      message: 'Cập nhật hiển thị trang chủ thành công',
      data: result
    });
  } catch (err) {
    console.error('Update home display error:', err);

    return res.status(400).json({
      success: false,
      message: err.message
    });
  }
};

/* =========================================================
   UPDATE SALE VISIBILITY
========================================================= */
exports.updateSaleVisibility = async (req, res) => {
  try {
    const result = await paymentTermService.updateSaleVisibility(
      req.params.id,
      req.body.visible_to_sale ?? req.body.status
    );

    return res.json({
      success: true,
      message: 'Cập nhật hiển thị cho Sale thành công',
      data: result
    });
  } catch (err) {
    console.error('Update sale visibility error:', err);

    return res.status(400).json({
      success: false,
      message: err.message
    });
  }
};

/* =========================================================
   DEACTIVATE
========================================================= */
exports.deactivate = async (req, res) => {
  try {
    const result = await paymentTermService.deactivate(req.params.id);

    return res.json({
      success: true,
      message: 'Đã ngưng áp dụng chương trình',
      data: result
    });
  } catch (err) {
    console.error('Deactivate payment term error:', err);

    return res.status(400).json({
      success: false,
      message: err.message
    });
  }
};