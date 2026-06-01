const API = {
  PRODUCTS: '/api/products',
  CATEGORIES: '/api/products/categories',
  UNITS: '/api/products/units',
  STATUSES: '/api/products/statuses',
  CROPS: '/api/products/crops',
  PESTS: '/api/products/pests',
  TOXICITY_LEVELS: '/api/products/toxicity-levels'
};

/* =========================================================
   CATEGORY ID THEO DATABASE
   1: Phân bón
   2: Thuốc BVTV
========================================================= */
const CATEGORY_FERTILIZER_ID = 1;
const CATEGORY_PESTICIDE_ID = 2;

let state = {
  page: 1,
  limit: 10,
  keyword: '',
  categoryId: '',
  sort: 'newest',
  totalPages: 1,
  mode: 'create'
};

/* =========================================================
   DOM
========================================================= */
const productTableBody = document.querySelector('#productTableBody');
const tableSummary = document.querySelector('#tableSummary');

const searchInput = document.querySelector('#searchInput');
const categoryFilter = document.querySelector('#categoryFilter');
const sortFilter = document.querySelector('#sortFilter');
const filterBtn = document.querySelector('#filterBtn');
const resetFilterBtn = document.querySelector('#resetFilterBtn');

const prevPageBtn = document.querySelector('#prevPageBtn');
const nextPageBtn = document.querySelector('#nextPageBtn');
const pageInfo = document.querySelector('#pageInfo');

const productModal = document.querySelector('#productModal');
const modalTitle = document.querySelector('#modalTitle');
const openCreateModalBtn = document.querySelector('#openCreateModalBtn');
const closeModalBtn = document.querySelector('#closeModalBtn');
const cancelModalBtn = document.querySelector('#cancelModalBtn');
const productForm = document.querySelector('#productForm');

const productIdInput = document.querySelector('#ProductID');
const imageIdInput = document.querySelector('#ImageID');

const categorySelect = document.querySelector('#CategoryID');
const fertilizerSection = document.querySelector('#fertilizerSection');
const pesticideSection = document.querySelector('#pesticideSection');

/* =========================================================
   COMMON HELPERS
========================================================= */
function formatMoney(value) {
  return Number(value || 0).toLocaleString('vi-VN') + ' đ';
}

function getToken() {
  return (
    localStorage.getItem('accessToken') ||
    sessionStorage.getItem('accessToken') ||
    localStorage.getItem('token') ||
    sessionStorage.getItem('token')
  );
}

function getAuthHeaders(extraHeaders = {}) {
  const token = getToken();

  return {
    ...(token ? { Authorization: `Bearer ${token}` } : {}),
    ...extraHeaders
  };
}

function getJSONFetchOptions(options = {}) {
  return {
    ...options,
    credentials: 'include',
    headers: {
      'Content-Type': 'application/json',
      ...getAuthHeaders(options.headers || {})
    }
  };
}

function getFormDataFetchOptions(options = {}) {
  return {
    ...options,
    credentials: 'include',
    headers: {
      ...getAuthHeaders(options.headers || {})
    }
  };
}

async function fetchJSON(url, options = {}) {
  const response = await fetch(url, getJSONFetchOptions(options));
  const data = await response.json().catch(() => null);

  if (!response.ok) {
    throw new Error(data?.message || 'Có lỗi xảy ra');
  }

  return data;
}

async function fetchFormData(url, options = {}) {
  const response = await fetch(url, getFormDataFetchOptions(options));
  const data = await response.json().catch(() => null);

  if (!response.ok) {
    throw new Error(data?.message || 'Có lỗi xảy ra');
  }

  return data;
}

function clearErrors() {
  document.querySelectorAll('.error-message').forEach(el => {
    el.textContent = '';
  });
}

function showError(id, message) {
  const el = document.querySelector(id);

  if (el) {
    el.textContent = message;
  }
}

function setValue(selector, value) {
  const el = document.querySelector(selector);

  if (!el) {
    return;
  }

  el.value = value ?? '';
}

function getInputValue(selector) {
  return document.querySelector(selector)?.value?.trim() || '';
}

function getNumberValue(selector) {
  const value = document.querySelector(selector)?.value;

  if (value === undefined || value === null || value === '') {
    return null;
  }

  const numberValue = Number(value);

  return Number.isNaN(numberValue) ? null : numberValue;
}

function getSelectedValues(selectId) {
  const select = document.getElementById(selectId);

  if (!select) {
    return [];
  }

  return Array.from(select.selectedOptions)
    .map(option => Number(option.value))
    .filter(value => Number.isInteger(value) && value > 0);
}

function setMultiSelectValues(selector, values = []) {
  const select = document.querySelector(selector);

  if (!select) {
    return;
  }

  const normalizedValues = values.map(value => String(value));

  Array.from(select.options).forEach(option => {
    option.selected = normalizedValues.includes(String(option.value));
  });
}

/* =========================================================
   VALIDATE
========================================================= */
function validateBaseForm() {
  clearErrors();

  let isValid = true;

  const productName = getInputValue('#ProductName');
  const price = getNumberValue('#Price');
  const categoryId = getNumberValue('#CategoryID');
  const unitId = getNumberValue('#UnitID');
  const statusId = getNumberValue('#StatusID');

  if (!productName) {
    showError('#errorProductName', 'Vui lòng nhập tên sản phẩm');
    isValid = false;
  }

  if (price === null || Number.isNaN(price) || price < 0) {
    showError('#errorPrice', 'Giá bán không hợp lệ');
    isValid = false;
  }

  if (!categoryId) {
    showError('#errorCategoryID', 'Vui lòng chọn danh mục');
    isValid = false;
  }

  if (!unitId) {
    showError('#errorUnitID', 'Vui lòng chọn đơn vị tính');
    isValid = false;
  }

  if (!statusId) {
    showError('#errorStatusID', 'Vui lòng chọn trạng thái');
    isValid = false;
  }

  return isValid;
}

/* =========================================================
   QUERY
========================================================= */
function buildProductQuery() {
  const params = new URLSearchParams();

  params.set('page', state.page);
  params.set('limit', state.limit);

  if (state.keyword) {
    params.set('keyword', state.keyword);
  }

  if (state.categoryId) {
    params.set('categoryId', state.categoryId);
  }

  if (state.sort) {
    params.set('sort', state.sort);
  }

  return params.toString();
}

/* =========================================================
   LOAD SELECT DATA
========================================================= */
async function loadCategories() {
  const result = await fetchJSON(API.CATEGORIES);
  const categories = result.data || [];

  categoryFilter.innerHTML = '<option value="">Tất cả danh mục</option>';
  categorySelect.innerHTML = '<option value="">-- Chọn danh mục --</option>';

  categories.forEach(category => {
    const id = category.id || category.CategoryID;
    const name = category.name || category.CategoryName;

    categoryFilter.innerHTML += `
      <option value="${id}">${name}</option>
    `;

    categorySelect.innerHTML += `
      <option value="${id}">${name}</option>
    `;
  });
}

async function loadUnits() {
  const result = await fetchJSON(API.UNITS);
  const units = result.data || [];

  const unitSelect = document.querySelector('#UnitID');
  unitSelect.innerHTML = '<option value="">-- Chọn đơn vị --</option>';

  units.forEach(unit => {
    const id = unit.id || unit.PUnitID;
    const name = unit.name || unit.Name;

    unitSelect.innerHTML += `
      <option value="${id}">${name}</option>
    `;
  });
}

async function loadStatuses() {
  const result = await fetchJSON(API.STATUSES);
  const statuses = result.data || [];

  const statusSelect = document.querySelector('#StatusID');
  statusSelect.innerHTML = '<option value="">-- Chọn trạng thái --</option>';

  statuses.forEach(status => {
    const id = status.id || status.StatusID;
    const name = status.name || status.Name;

    statusSelect.innerHTML += `
      <option value="${id}">${name}</option>
    `;
  });
}

async function loadCrops() {
  const cropSelect = document.querySelector('#CropIDs');

  if (!cropSelect) {
    return;
  }

  const result = await fetchJSON(API.CROPS);
  const crops = result.data || [];

  cropSelect.innerHTML = '';

  crops.forEach(crop => {
    const id = crop.id || crop.CropID;
    const name = crop.name || crop.Name;

    cropSelect.innerHTML += `
      <option value="${id}">${name}</option>
    `;
  });
}

async function loadPests() {
  const pestSelect = document.querySelector('#PestIDs');

  if (!pestSelect) {
    return;
  }

  const result = await fetchJSON(API.PESTS);
  const pests = result.data || [];

  pestSelect.innerHTML = '';

  pests.forEach(pest => {
    const id = pest.id || pest.PestID;
    const name = pest.name || pest.PestName;

    pestSelect.innerHTML += `
      <option value="${id}">${name}</option>
    `;
  });
}

async function loadToxicityLevels() {
  const toxicSelect = document.querySelector('#ToxicID');

  if (!toxicSelect) {
    return;
  }

  const result = await fetchJSON(API.TOXICITY_LEVELS);
  const levels = result.data || [];

  toxicSelect.innerHTML = '<option value="">-- Chọn mức độc --</option>';

  levels.forEach(level => {
    const id = level.id || level.ToxicID;
    const name = level.level || level.Level || level.name || level.Name;

    toxicSelect.innerHTML += `
      <option value="${id}">${name}</option>
    `;
  });
}

/* =========================================================
   LOAD PRODUCTS
========================================================= */
async function loadProducts() {
  const query = buildProductQuery();
  const result = await fetchJSON(`${API.PRODUCTS}?${query}`);

  const payload = result.data || {};
  const products = payload.items || payload || [];
  const pagination = payload.pagination || {
    page: state.page,
    totalPages: 1,
    total: Array.isArray(products) ? products.length : 0
  };

  state.totalPages = pagination.totalPages || 1;

  renderProducts(Array.isArray(products) ? products : []);
  renderPagination(pagination);
}

function getCategoryName(product) {
  return product.CategoryName || product.category?.name || 'Chưa phân loại';
}

function getUnitName(product) {
  return product.UnitName || product.unit?.name || 'Chưa có';
}

function getStatusName(product) {
  return product.StatusName || product.status?.name || 'Chưa có';
}

function getProductId(product) {
  return product.ProductID || product.id;
}

function renderProducts(products) {
  if (!products.length) {
    productTableBody.innerHTML = `
      <tr>
        <td colspan="7" class="empty-cell">Không có sản phẩm nào</td>
      </tr>
    `;

    tableSummary.textContent = 'Không có dữ liệu';
    return;
  }

  tableSummary.textContent = `Hiển thị ${products.length} sản phẩm`;

  productTableBody.innerHTML = products.map(product => {
    const productId = getProductId(product);

    return `
      <tr>
        <td>${product.SKU || product.sku || 'Chưa có SKU'}</td>

        <td>
          <div class="product-name">
            <strong>${product.ProductName || product.name || ''}</strong>
            <small>${product.Brand || product.brand || ''}</small>
          </div>
        </td>

        <td>${getCategoryName(product)}</td>

        <td>${getUnitName(product)}</td>

        <td>
          <span class="price-text">${formatMoney(product.Price || product.price)}</span>
        </td>

        <td>
          <span class="status-badge">${getStatusName(product)}</span>
        </td>

        <td>
          <div class="action-group">
            <button class="icon-btn edit-btn" data-id="${productId}" type="button">
              <i class="fa-solid fa-pen"></i>
            </button>

            <button class="icon-btn delete-btn" data-id="${productId}" type="button">
              <i class="fa-solid fa-trash"></i>
            </button>
          </div>
        </td>
      </tr>
    `;
  }).join('');
}

function renderPagination(pagination) {
  const page = pagination.page || state.page;
  const totalPages = pagination.totalPages || 1;

  pageInfo.textContent = `Trang ${page} / ${totalPages}`;

  prevPageBtn.disabled = page <= 1;
  nextPageBtn.disabled = page >= totalPages;
}

/* =========================================================
   MODAL TYPE SECTIONS
========================================================= */
function updateProductTypeSections() {
  const categoryId = Number(categorySelect.value);

  if (fertilizerSection) {
    fertilizerSection.classList.add('hidden');
  }

  if (pesticideSection) {
    pesticideSection.classList.add('hidden');
  }

  if (categoryId === CATEGORY_FERTILIZER_ID && fertilizerSection) {
    fertilizerSection.classList.remove('hidden');
  }

  if (categoryId === CATEGORY_PESTICIDE_ID && pesticideSection) {
    pesticideSection.classList.remove('hidden');
    resetPesticidePanels();
  }
}

function resetTypeSections() {
  if (fertilizerSection) {
    fertilizerSection.classList.add('hidden');
  }

  if (pesticideSection) {
    pesticideSection.classList.add('hidden');
  }
}

/* =========================================================
   PESTICIDE STEP PANELS
========================================================= */
function openPesticidePanel(panelId) {
  const stepButtons = document.querySelectorAll('.pesticide-step-btn');
  const panels = document.querySelectorAll('.pesticide-panel');

  stepButtons.forEach(button => {
    button.classList.remove('active');
  });

  panels.forEach(panel => {
    panel.classList.add('hidden');
    panel.classList.remove('active');
  });

  const button = document.querySelector(`.pesticide-step-btn[data-target="${panelId}"]`);
  const panel = document.getElementById(panelId);

  if (button) {
    button.classList.add('active');
  }

  if (panel) {
    panel.classList.remove('hidden');
    panel.classList.add('active');
  }
}

function resetPesticidePanels() {
  openPesticidePanel('pesticideBasicPanel');
}

function initPesticideStepPanels() {
  const stepButtons = document.querySelectorAll('.pesticide-step-btn');

  stepButtons.forEach(button => {
    button.addEventListener('click', () => {
      const targetId = button.dataset.target;
      openPesticidePanel(targetId);
    });
  });
}

/* =========================================================
   RESET EXTRA FIELDS
========================================================= */
function resetExtraFields() {
  [
    '#FertilizerType',
    '#FertilizerMainContent',
    '#FertilizerBenefit',
    '#FertilizerCrops',
    '#FertilizerUseTime',
    '#FertilizerDosage',
    '#FertilizerSafety',
    '#PesticideName',
    '#PesticideDescriptionShort',
    '#Dosage',
    '#Method',
    '#Time',
    '#HarvestInterval',
    '#ToxicID',
    '#SafetyWarning',
    '#Precaution',
    '#PesticideDescription'
  ].forEach(selector => {
    const el = document.querySelector(selector);

    if (el) {
      el.value = '';
    }
  });

  ['#CropIDs', '#PestIDs'].forEach(selector => {
    const select = document.querySelector(selector);

    if (select) {
      Array.from(select.options).forEach(option => {
        option.selected = false;
      });
    }
  });

  resetPesticidePanels();
}

/* =========================================================
   MODAL OPEN/CLOSE
========================================================= */
function openModal(mode = 'create') {
  state.mode = mode;
  productModal.classList.remove('hidden');

  if (mode === 'create') {
    modalTitle.textContent = 'Thêm sản phẩm';
  } else {
    modalTitle.textContent = 'Cập nhật sản phẩm';
  }

  updateProductTypeSections();
}

function closeModal() {
  productModal.classList.add('hidden');
  productForm.reset();

  if (productIdInput) {
    productIdInput.value = '';
  }

  if (imageIdInput) {
    imageIdInput.value = '';
  }

  state.mode = 'create';

  resetTypeSections();
  resetExtraFields();
  clearErrors();
}

/* =========================================================
   FORM DATA BUILDERS
========================================================= */
function appendFertilizerExtraToProductFields(formData) {
  const fertilizerType = getInputValue('#FertilizerType');
  const mainContent = getInputValue('#FertilizerMainContent');
  const benefit = getInputValue('#FertilizerBenefit');
  const crops = getInputValue('#FertilizerCrops');
  const useTime = getInputValue('#FertilizerUseTime');
  const dosage = getInputValue('#FertilizerDosage');
  const safety = getInputValue('#FertilizerSafety');

  const currentDescription = getInputValue('#Description');
  const currentTechnical = getInputValue('#TechnicalContent');
  const currentUsage = getInputValue('#UsageInstructions');

  const descriptionParts = [
    currentDescription,
    benefit ? `Công dụng: ${benefit}` : '',
    crops ? `Cây trồng phù hợp: ${crops}` : '',
    useTime ? `Thời điểm sử dụng: ${useTime}` : ''
  ].filter(Boolean);

  const technicalParts = [
    currentTechnical,
    fertilizerType ? `Loại phân bón: ${fertilizerType}` : '',
    mainContent ? `Thành phần chính: ${mainContent}` : ''
  ].filter(Boolean);

  const usageParts = [
    currentUsage,
    dosage ? `Liều lượng: ${dosage}` : '',
    safety ? `Lưu ý an toàn: ${safety}` : ''
  ].filter(Boolean);

  formData.set('Description', descriptionParts.join('. '));
  formData.set('TechnicalContent', technicalParts.join('. '));
  formData.set('UsageInstructions', usageParts.join('. '));
}

function buildPesticideData() {
  const shortDescription = getInputValue('#PesticideDescriptionShort');
  const longDescription = getInputValue('#PesticideDescription');

  return {
    Name: getInputValue('#PesticideName') || getInputValue('#ProductName'),

    Description:
      longDescription ||
      shortDescription ||
      getInputValue('#Description'),

    Dosage: getInputValue('#Dosage'),
    Method: getInputValue('#Method'),
    Time: getInputValue('#Time'),
    Harvest_interval: getInputValue('#HarvestInterval'),
    Safety_warning: getInputValue('#SafetyWarning'),

    ToxicID: getNumberValue('#ToxicID'),

    Precaution: getInputValue('#Precaution'),

    CropIDs: getSelectedValues('CropIDs'),
    PestIDs: getSelectedValues('PestIDs')
  };
}

function buildSubmitFormData() {
  const formData = new FormData(productForm);
  const categoryId = Number(categorySelect.value);

  if (categoryId === CATEGORY_FERTILIZER_ID) {
    appendFertilizerExtraToProductFields(formData);
  }

  if (categoryId === CATEGORY_PESTICIDE_ID) {
    const pesticideData = buildPesticideData();
    formData.append('pesticideData', JSON.stringify(pesticideData));
  }

  return formData;
}

/* =========================================================
   SUBMIT
========================================================= */
async function handleSubmit(e) {
  e.preventDefault();

  if (!validateBaseForm()) {
    return;
  }

  const productId = productIdInput?.value;
  const formData = buildSubmitFormData();

  const url = productId
    ? `${API.PRODUCTS}/${productId}`
    : API.PRODUCTS;

  const method = productId ? 'PUT' : 'POST';

  try {
    await fetchFormData(url, {
      method,
      body: formData
    });

    alert(productId ? 'Cập nhật sản phẩm thành công' : 'Tạo sản phẩm thành công');

    closeModal();
    await loadProducts();

  } catch (error) {
    alert(error.message || 'Lưu sản phẩm thất bại');
  }
}

/* =========================================================
   EDIT HELPERS
========================================================= */
function getProductImageId(product) {
  return (
    product.ImageID ||
    product.imageId ||
    product.image?.id ||
    product.image?.ImageID ||
    product.Image?.ImageID ||
    ''
  );
}

function getPesticideInfo(product) {
  return (
    product.pesticide ||
    product.pesticideData ||
    product.Pesticide ||
    product.pesticideInfo ||
    null
  );
}

function getPesticideCropIds(pesticide) {
  if (!pesticide) {
    return [];
  }

  return (
    pesticide.CropIDs ||
    pesticide.cropIds ||
    pesticide.crops?.map(crop => crop.id || crop.CropID) ||
    []
  );
}

function getPesticidePestIds(pesticide) {
  if (!pesticide) {
    return [];
  }

  return (
    pesticide.PestIDs ||
    pesticide.pestIds ||
    pesticide.pests?.map(pest => pest.id || pest.PestID) ||
    []
  );
}

function fillPesticideFields(product) {
  const pesticide = getPesticideInfo(product);

  if (!pesticide) {
    resetPesticidePanels();
    return;
  }

  setValue(
    '#PesticideName',
    pesticide.Name || pesticide.name || product.ProductName || product.name || ''
  );

  setValue(
    '#PesticideDescriptionShort',
    pesticide.ShortDescription || pesticide.shortDescription || ''
  );

  setValue(
    '#PesticideDescription',
    pesticide.Description || pesticide.description || ''
  );

  setValue(
    '#Dosage',
    pesticide.Dosage ||
    pesticide.dosage ||
    pesticide.detail?.Dosage ||
    pesticide.detail?.dosage ||
    ''
  );

  setValue(
    '#Method',
    pesticide.Method ||
    pesticide.method ||
    pesticide.detail?.Method ||
    pesticide.detail?.method ||
    ''
  );

  setValue(
    '#Time',
    pesticide.Time ||
    pesticide.time ||
    pesticide.detail?.Time ||
    pesticide.detail?.time ||
    ''
  );

  setValue(
    '#HarvestInterval',
    pesticide.Harvest_interval ||
    pesticide.harvestInterval ||
    pesticide.harvest_interval ||
    pesticide.detail?.Harvest_interval ||
    pesticide.detail?.harvestInterval ||
    ''
  );

  setValue(
    '#SafetyWarning',
    pesticide.Safety_warning ||
    pesticide.safetyWarning ||
    pesticide.safety_warning ||
    pesticide.detail?.Safety_warning ||
    pesticide.detail?.safetyWarning ||
    ''
  );

  setValue(
    '#ToxicID',
    pesticide.ToxicID ||
    pesticide.toxicId ||
    pesticide.usage?.ToxicID ||
    pesticide.usage?.toxicId ||
    ''
  );

  setValue(
    '#Precaution',
    pesticide.Precaution ||
    pesticide.precaution ||
    pesticide.usage?.Precaution ||
    pesticide.usage?.precaution ||
    ''
  );

  setMultiSelectValues('#CropIDs', getPesticideCropIds(pesticide));
  setMultiSelectValues('#PestIDs', getPesticidePestIds(pesticide));

  resetPesticidePanels();
}

function fillFertilizerFields(product) {
  /*
    Hiện tại phân bón chưa có bảng riêng.
    Dữ liệu phân bón đang ghép vào:
    - Description
    - TechnicalContent
    - UsageInstructions

    Vì vậy khi edit chỉ lấy lại chắc chắn được 3 ô chính.
    Các ô phụ như FertilizerType, FertilizerBenefit... không thể tách ngược chính xác.
  */
  setValue('#FertilizerType', '');
  setValue('#FertilizerMainContent', '');
  setValue('#FertilizerBenefit', '');
  setValue('#FertilizerCrops', '');
  setValue('#FertilizerUseTime', '');
  setValue('#FertilizerDosage', '');
  setValue('#FertilizerSafety', '');
}

/* =========================================================
   EDIT
========================================================= */
async function handleEdit(productId) {
  try {
    const result = await fetchJSON(`${API.PRODUCTS}/${productId}`);
    const product = result.data;

    if (!product) {
      alert('Không tìm thấy sản phẩm');
      return;
    }

    productForm.reset();
    clearErrors();
    resetExtraFields();

    const currentProductId = product.ProductID || product.id || productId;
    const currentCategoryId = product.CategoryID || product.category?.id || '';
    const currentUnitId = product.UnitID || product.unit?.id || '';
    const currentStatusId = product.StatusID || product.status?.id || '';

    if (productIdInput) {
      productIdInput.value = currentProductId;
    }

    if (imageIdInput) {
      imageIdInput.value = getProductImageId(product);
    }

    setValue('#ProductName', product.ProductName || product.name || '');
    setValue('#Price', product.Price ?? product.price ?? 0);
    setValue('#CategoryID', currentCategoryId);
    setValue('#UnitID', currentUnitId);
    setValue('#StatusID', currentStatusId);
    setValue('#IsActive', Number(product.IsActive ?? product.isActive ?? 1));

    setValue('#Brand', product.Brand || product.brand || '');
    setValue('#OriginCountry', product.OriginCountry || product.originCountry || '');
    setValue('#Weight', product.Weight ?? product.weight ?? '');

    setValue('#Description', product.Description || product.description || '');
    setValue('#TechnicalContent', product.TechnicalContent || product.technicalContent || '');
    setValue('#UsageInstructions', product.UsageInstructions || product.usageInstructions || '');

    updateProductTypeSections();

    if (Number(currentCategoryId) === CATEGORY_FERTILIZER_ID) {
      fillFertilizerFields(product);
    }

    if (Number(currentCategoryId) === CATEGORY_PESTICIDE_ID) {
      fillPesticideFields(product);
    }

    openModal('edit');

  } catch (error) {
    alert(error.message || 'Không tải được sản phẩm');
  }
}

/* =========================================================
   DELETE
========================================================= */
async function handleDelete(productId) {
  const confirmed = confirm('Bạn có chắc muốn xóa sản phẩm này không?');

  if (!confirmed) {
    return;
  }

  try {
    await fetchJSON(`${API.PRODUCTS}/${productId}`, {
      method: 'DELETE'
    });

    alert('Xóa sản phẩm thành công');
    await loadProducts();

  } catch (error) {
    alert(error.message || 'Xóa sản phẩm thất bại');
  }
}

/* =========================================================
   EVENTS
========================================================= */
function bindEvents() {
  openCreateModalBtn.addEventListener('click', () => {
    productForm.reset();

    if (productIdInput) {
      productIdInput.value = '';
    }

    if (imageIdInput) {
      imageIdInput.value = '';
    }

    resetExtraFields();
    resetTypeSections();
    openModal('create');
  });

  closeModalBtn.addEventListener('click', closeModal);
  cancelModalBtn.addEventListener('click', closeModal);

  productForm.addEventListener('submit', handleSubmit);

  categorySelect.addEventListener('change', updateProductTypeSections);

  filterBtn.addEventListener('click', () => {
    state.page = 1;
    state.keyword = searchInput.value.trim();
    state.categoryId = categoryFilter.value;
    state.sort = sortFilter.value;
    loadProducts();
  });

  resetFilterBtn.addEventListener('click', () => {
    searchInput.value = '';
    categoryFilter.value = '';
    sortFilter.value = 'newest';

    state.page = 1;
    state.keyword = '';
    state.categoryId = '';
    state.sort = 'newest';

    loadProducts();
  });

  prevPageBtn.addEventListener('click', () => {
    if (state.page > 1) {
      state.page -= 1;
      loadProducts();
    }
  });

  nextPageBtn.addEventListener('click', () => {
    if (state.page < state.totalPages) {
      state.page += 1;
      loadProducts();
    }
  });

  productTableBody.addEventListener('click', (e) => {
    const editBtn = e.target.closest('.edit-btn');
    const deleteBtn = e.target.closest('.delete-btn');

    if (editBtn) {
      handleEdit(editBtn.dataset.id);
    }

    if (deleteBtn) {
      handleDelete(deleteBtn.dataset.id);
    }
  });
}

/* =========================================================
   INIT
========================================================= */
async function init() {
  bindEvents();
  initPesticideStepPanels();

  try {
    await Promise.all([
      loadCategories(),
      loadUnits(),
      loadStatuses(),
      loadCrops(),
      loadPests(),
      loadToxicityLevels()
    ]);

    resetTypeSections();
    resetPesticidePanels();

    await loadProducts();

  } catch (error) {
    alert(error.message || 'Không tải được dữ liệu sản phẩm');
  }
}

document.addEventListener('DOMContentLoaded', init);