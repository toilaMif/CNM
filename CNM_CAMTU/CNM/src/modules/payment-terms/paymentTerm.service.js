const paymentTermRepository = require('./paymentTerm.repository');

function toNumber(value, defaultValue = 0) {
  const number = Number(value);

  if (!Number.isFinite(number)) {
    return defaultValue;
  }

  return number;
}

function normalizeText(value) {
  return String(value || '').trim();
}

function normalizeBooleanToTinyInt(value, defaultValue = 0) {
  if (
    value === true ||
    value === 1 ||
    value === '1' ||
    value === 'true' ||
    value === 'ACTIVE' ||
    value === 'YES'
  ) {
    return 1;
  }

  if (
    value === false ||
    value === 0 ||
    value === '0' ||
    value === 'false' ||
    value === 'INACTIVE' ||
    value === 'NO'
  ) {
    return 0;
  }

  return defaultValue;
}

function normalizeTargetAudience(value) {
  const allowed = ['ALL', 'DEALER', 'CUSTOMER'];
  const audience = String(value || 'DEALER').toUpperCase();

  return allowed.includes(audience) ? audience : 'DEALER';
}

function validatePayload(payload) {
  const termName = normalizeText(
    payload.term_name || payload.program_name
  );

  if (!termName) {
    throw new Error('Tên chương trình không được để trống');
  }

  const creditDays = toNumber(payload.credit_days, 0);
  const earlyRate = toNumber(payload.early_commission_rate_per_day, 0);
  const lateRate = toNumber(payload.late_interest_rate_per_day, 0);
  const displayOrder = toNumber(payload.display_order, 0);

  if (creditDays < 0) {
    throw new Error('Số ngày công nợ không hợp lệ');
  }

  if (earlyRate < 0) {
    throw new Error('Tỷ lệ hoa hồng trả sớm không hợp lệ');
  }

  if (lateRate < 0) {
    throw new Error('Tỷ lệ lãi phạt trả trễ không hợp lệ');
  }

  if (displayOrder < 0) {
    throw new Error('Thứ tự hiển thị không hợp lệ');
  }

  return {
    term_name: termName,
    description: payload.description || null,

    image_url: payload.image_url || null,
    banner_url: payload.banner_url || null,

    credit_days: creditDays,
    early_commission_rate_per_day: earlyRate,
    late_interest_rate_per_day: lateRate,

    is_active: normalizeBooleanToTinyInt(
      payload.is_active ?? payload.status,
      1
    ),

    display_on_home: normalizeBooleanToTinyInt(
      payload.display_on_home,
      0
    ),

    visible_to_sale: normalizeBooleanToTinyInt(
      payload.visible_to_sale,
      1
    ),

    display_order: displayOrder,

    target_audience: normalizeTargetAudience(payload.target_audience)
  };
}

function validateId(id) {
  const termId = Number(id);

  if (!Number.isInteger(termId) || termId <= 0) {
    throw new Error('ID chương trình không hợp lệ');
  }

  return termId;
}

/* =========================================================
   Sale lấy danh sách active + visible_to_sale
========================================================= */
exports.findAllActive = async () => {
  return paymentTermRepository.findAllActive();
};

/* =========================================================
   Product Manager lấy toàn bộ
========================================================= */
exports.findAll = async () => {
  return paymentTermRepository.findAll();
};

/* =========================================================
   Trang home lấy chương trình khuyến mãi
========================================================= */
exports.findHomePromotions = async () => {
  return paymentTermRepository.findHomePromotions();
};

/* =========================================================
   Lấy chi tiết
========================================================= */
exports.findById = async (id) => {
  const termId = validateId(id);

  const term = await paymentTermRepository.findById(termId);

  if (!term) {
    throw new Error('Không tìm thấy chương trình');
  }

  return term;
};

/* =========================================================
   Tạo chương trình
========================================================= */
exports.create = async (payload) => {
  const data = validatePayload(payload);

  return paymentTermRepository.create(data);
};

/* =========================================================
   Cập nhật chương trình
========================================================= */
exports.update = async (id, payload) => {
  const termId = validateId(id);

  const existing = await paymentTermRepository.findById(termId);

  if (!existing) {
    throw new Error('Không tìm thấy chương trình');
  }

  const data = validatePayload(payload);

  return paymentTermRepository.update(termId, data);
};

/* =========================================================
   Bật / tắt chương trình
========================================================= */
exports.updateStatus = async (id, statusValue) => {
  const termId = validateId(id);

  const existing = await paymentTermRepository.findById(termId);

  if (!existing) {
    throw new Error('Không tìm thấy chương trình');
  }

  const isActive = normalizeBooleanToTinyInt(statusValue, 1);

  return paymentTermRepository.updateStatus(termId, isActive);
};

/* =========================================================
   Cập nhật hiển thị Home
========================================================= */
exports.updateHomeDisplay = async (id, payload) => {
  const termId = validateId(id);

  const existing = await paymentTermRepository.findById(termId);

  if (!existing) {
    throw new Error('Không tìm thấy chương trình');
  }

  const displayData = {
    display_on_home: normalizeBooleanToTinyInt(
      payload.display_on_home,
      0
    ),
    display_order: toNumber(payload.display_order, 0),
    target_audience: normalizeTargetAudience(payload.target_audience)
  };

  return paymentTermRepository.updateHomeDisplay(termId, displayData);
};

/* =========================================================
   Cập nhật hiển thị cho Sale
========================================================= */
exports.updateSaleVisibility = async (id, visibleValue) => {
  const termId = validateId(id);

  const existing = await paymentTermRepository.findById(termId);

  if (!existing) {
    throw new Error('Không tìm thấy chương trình');
  }

  const visibleToSale = normalizeBooleanToTinyInt(visibleValue, 1);

  return paymentTermRepository.updateSaleVisibility(termId, visibleToSale);
};

/* =========================================================
   Ngưng áp dụng
========================================================= */
exports.deactivate = async (id) => {
  const termId = validateId(id);

  const existing = await paymentTermRepository.findById(termId);

  if (!existing) {
    throw new Error('Không tìm thấy chương trình');
  }

  return paymentTermRepository.deactivate(termId);
};