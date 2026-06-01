/* =========================================================
   WAREHOUSE STOCKTAKES PAGE
   Không dùng inline onclick/onchange vì bị CSP chặn
   Chọn sản phẩm -> hiển thị danh sách kệ/lô/ngày nhập
   Upload tối đa 5 ảnh tình trạng cho mỗi dòng kiểm kê
   Validate số lượng thực tế là số hợp lệ
   Fix lỗi input bị mất focus khi nhập
========================================================= */

const stocktakeState = {
  stocktakes: [],
  inventoryItems: [],
  selectedItems: []
};

document.addEventListener('DOMContentLoaded', () => {
  bindEvents();
  setDefaultDate();
  loadStocktakes();
  loadInventoryItems();
});


/* =========================================================
   EVENTS
========================================================= */

function bindEvents() {
  document.getElementById('btnOpenCreateModal')?.addEventListener('click', openCreateModal);
  document.getElementById('btnCloseCreateModal')?.addEventListener('click', closeCreateModal);
  document.getElementById('btnCancelCreate')?.addEventListener('click', closeCreateModal);

  document.getElementById('btnFilter')?.addEventListener('click', loadStocktakes);

  document.getElementById('btnSearchInventory')?.addEventListener('click', () => {
    loadInventoryItems();
  });

  document.getElementById('btnSaveDraft')?.addEventListener('click', () => createStocktake(false));
  document.getElementById('btnSubmitStocktake')?.addEventListener('click', () => createStocktake(true));

  document.getElementById('btnCloseDetailModal')?.addEventListener('click', closeDetailModal);
  document.getElementById('btnCloseDetailFooter')?.addEventListener('click', closeDetailModal);

  document.getElementById('filterKeyword')?.addEventListener('keydown', (event) => {
    if (event.key === 'Enter') loadStocktakes();
  });

  ['inventoryKeyword', 'inventorySkuKeyword', 'inventoryCategoryKeyword'].forEach((id) => {
    document.getElementById(id)?.addEventListener('keydown', (event) => {
      if (event.key === 'Enter') {
        loadInventoryItems();
      }
    });
  });

  bindTableActions();
  bindInventoryActions();
  bindSelectedItemActions();
}


function bindTableActions() {
  const tbody = document.getElementById('stocktakeTableBody');

  tbody?.addEventListener('click', async (event) => {
    const button = event.target.closest('[data-action]');
    if (!button) return;

    const action = button.dataset.action;
    const id = Number(button.dataset.id);

    if (!id) return;

    if (action === 'view-detail') {
      await openDetailModal(id);
      return;
    }

    if (action === 'submit-draft') {
      await submitDraftStocktake(id);
    }
  });
}


function bindInventoryActions() {
  const container = document.getElementById('inventoryList');

  container?.addEventListener('click', (event) => {
    const button = event.target.closest('[data-action="add-inventory"]');
    if (!button) return;

    const inventoryId = Number(button.dataset.inventoryId);
    addInventoryItem(inventoryId);
  });
}


function bindSelectedItemActions() {
  const tbody = document.getElementById('selectedItemsBody');

  tbody?.addEventListener('input', (event) => {
    const target = event.target;

    const inventoryId = Number(target.dataset.inventoryId);
    const field = target.dataset.field;

    if (!inventoryId || !field) return;

    if (field === 'image_files') return;

    updateSelectedItem(inventoryId, field, target.value);
  });

  tbody?.addEventListener('change', (event) => {
    const target = event.target;

    const inventoryId = Number(target.dataset.inventoryId);
    const field = target.dataset.field;

    if (!inventoryId || !field) return;

    if (field === 'image_files') {
      updateSelectedItemImages(inventoryId, target.files || []);
      return;
    }

    updateSelectedItem(inventoryId, field, target.value);
  });

  tbody?.addEventListener('click', (event) => {
    const button = event.target.closest('[data-action="remove-selected"]');
    if (!button) return;

    const inventoryId = Number(button.dataset.inventoryId);
    removeSelectedItem(inventoryId);
  });
}


function setDefaultDate() {
  const input = document.getElementById('stocktakeDate');
  if (!input) return;

  input.value = new Date().toISOString().slice(0, 10);
}


/* =========================================================
   API HELPERS
========================================================= */

async function apiFetch(url, options = {}) {
  const response = await fetch(url, {
    credentials: 'include',
    headers: {
      'Content-Type': 'application/json',
      ...(options.headers || {})
    },
    ...options
  });

  let result = null;

  try {
    result = await response.json();
  } catch (err) {
    result = null;
  }

  if (!response.ok || result?.success === false) {
    throw new Error(result?.message || `API lỗi ${response.status}`);
  }

  return result;
}


async function apiFetchFormData(url, options = {}) {
  const response = await fetch(url, {
    credentials: 'include',
    ...options
  });

  let result = null;

  try {
    result = await response.json();
  } catch (err) {
    result = null;
  }

  if (!response.ok || result?.success === false) {
    throw new Error(result?.message || `API lỗi ${response.status}`);
  }

  return result;
}


/* =========================================================
   LOAD STOCKTAKES
========================================================= */

async function loadStocktakes() {
  const tbody = document.getElementById('stocktakeTableBody');
  const countEl = document.getElementById('stocktakeCount');

  tbody.innerHTML = `
    <tr>
      <td colspan="8" class="empty-cell">Đang tải dữ liệu...</td>
    </tr>
  `;

  try {
    const params = new URLSearchParams();

    const status = document.getElementById('filterStatus')?.value;
    const fromDate = document.getElementById('filterFromDate')?.value;
    const toDate = document.getElementById('filterToDate')?.value;
    const keyword = document.getElementById('filterKeyword')?.value.trim();

    if (status) params.append('status', status);
    if (fromDate) params.append('from_date', fromDate);
    if (toDate) params.append('to_date', toDate);
    if (keyword) params.append('keyword', keyword);

    const query = params.toString();
    const url = query
      ? `/api/inventory/stocktakes?${query}`
      : '/api/inventory/stocktakes';

    const result = await apiFetch(url);

    stocktakeState.stocktakes = result.data || [];
    countEl.textContent = `${stocktakeState.stocktakes.length} phiếu`;

    renderStocktakes();

  } catch (error) {
    tbody.innerHTML = `
      <tr>
        <td colspan="8" class="empty-cell">${escapeHtml(error.message)}</td>
      </tr>
    `;
  }
}


function renderStocktakes() {
  const tbody = document.getElementById('stocktakeTableBody');

  if (!stocktakeState.stocktakes.length) {
    tbody.innerHTML = `
      <tr>
        <td colspan="8" class="empty-cell">Chưa có phiếu kiểm kê nào.</td>
      </tr>
    `;
    return;
  }

  tbody.innerHTML = stocktakeState.stocktakes.map((item) => {
    return `
      <tr>
        <td><strong>${escapeHtml(item.stocktake_code)}</strong></td>
        <td>${formatDate(item.stocktake_date)}</td>
        <td>${escapeHtml(item.warehouse_area || '-')}</td>
        <td>${escapeHtml(item.created_by_name || '-')}</td>
        <td>${Number(item.total_items || 0)}</td>
        <td>${formatQuantity(item.total_difference_abs || 0)}</td>
        <td>${renderStatusBadge(item.status)}</td>
        <td class="text-right">
          <button
            type="button"
            class="action-btn"
            data-action="view-detail"
            data-id="${Number(item.stocktake_id)}"
          >
            Xem
          </button>

          ${item.status === 'draft' ? `
            <button
              type="button"
              class="action-btn"
              data-action="submit-draft"
              data-id="${Number(item.stocktake_id)}"
            >
              Gửi duyệt
            </button>
          ` : ''}
        </td>
      </tr>
    `;
  }).join('');
}


/* =========================================================
   LOAD INVENTORY ITEMS
========================================================= */

async function loadInventoryItems() {
  const container = document.getElementById('inventoryList');

  container.innerHTML = `<div class="empty-box">Đang tải danh sách vật tư...</div>`;

  try {
    const params = new URLSearchParams();

    const keyword = document.getElementById('inventoryKeyword')?.value.trim();
    const sku = document.getElementById('inventorySkuKeyword')?.value.trim();
    const categoryName = document.getElementById('inventoryCategoryKeyword')?.value.trim();

    if (keyword) params.append('keyword', keyword);
    if (sku) params.append('sku', sku);
    if (categoryName) params.append('category_name', categoryName);

    const query = params.toString();
    const url = query
      ? `/api/inventory/stocktakes/inventory-items?${query}`
      : '/api/inventory/stocktakes/inventory-items';

    const result = await apiFetch(url);

    stocktakeState.inventoryItems = result.data || [];

    renderInventoryItems();

  } catch (error) {
    container.innerHTML = `
      <div class="empty-box">${escapeHtml(error.message)}</div>
    `;
  }
}


function groupInventoryByProduct(items = []) {
  const map = new Map();

  items.forEach(item => {
    const productId = Number(item.product_id);

    if (!map.has(productId)) {
      map.set(productId, {
        product_id: productId,
        product_name: item.product_name,
        sku: item.sku,
        category_name: item.category_name,
        unit_name: item.unit_name,
        lots: []
      });
    }

    map.get(productId).lots.push(item);
  });

  return Array.from(map.values());
}


function renderInventoryItems() {
  const container = document.getElementById('inventoryList');

  if (!stocktakeState.inventoryItems.length) {
    container.innerHTML = `<div class="empty-box">Không tìm thấy vật tư nào.</div>`;
    return;
  }

  const productGroups = groupInventoryByProduct(stocktakeState.inventoryItems);

  container.innerHTML = productGroups.map((product) => {
    return `
      <div class="product-inventory-card">
        <div class="product-inventory-header">
          <div>
            <h4>${escapeHtml(product.product_name)}</h4>
            <p>
              SKU: <strong>${escapeHtml(product.sku || '-')}</strong>
              |
              Danh mục: <strong>${escapeHtml(product.category_name || '-')}</strong>
            </p>
          </div>

          <span>${product.lots.length} kệ/lô</span>
        </div>

        <div class="shelf-list">
          <table>
            <thead>
              <tr>
                <th>Kệ / vị trí</th>
                <th>Lô nội bộ</th>
                <th>Lô NSX</th>
                <th>Ngày nhập</th>
                <th>HSD</th>
                <th>Tồn HT</th>
                <th>ĐVT</th>
                <th></th>
              </tr>
            </thead>

            <tbody>
              ${product.lots.map((lot) => {
                const isSelected = stocktakeState.selectedItems.some(
                  selected => Number(selected.inventory_id) === Number(lot.inventory_id)
                );

                return `
                  <tr>
                    <td>${escapeHtml(lot.location_rack || '-')}</td>
                    <td>${escapeHtml(lot.batch_number || '-')}</td>
                    <td>${escapeHtml(lot.manufacturer_batch || '-')}</td>
                    <td>${formatDate(lot.import_date || lot.created_at)}</td>
                    <td>${formatDate(lot.expiry_date)}</td>
                    <td>${formatQuantity(lot.system_quantity)}</td>
                    <td>${escapeHtml(lot.unit_name || '-')}</td>
                    <td class="text-right">
                      <button
                        type="button"
                        class="${isSelected ? 'btn-light' : 'btn-secondary'}"
                        data-action="add-inventory"
                        data-inventory-id="${Number(lot.inventory_id)}"
                        ${isSelected ? 'disabled' : ''}
                      >
                        ${isSelected ? 'Đã chọn' : 'Kiểm kê'}
                      </button>
                    </td>
                  </tr>
                `;
              }).join('')}
            </tbody>
          </table>
        </div>
      </div>
    `;
  }).join('');
}


/* =========================================================
   QUANTITY VALIDATION
========================================================= */

function parseActualQuantity(value) {
  const rawValue = String(value ?? '').trim().replace(',', '.');

  if (rawValue === '') {
    return {
      valid: false,
      value: null,
      message: 'Vui lòng nhập số lượng thực tế'
    };
  }

  if (!/^(\d+(\.\d*)?|\.\d+)$/.test(rawValue)) {
    return {
      valid: false,
      value: null,
      message: 'Số lượng thực tế phải là số hợp lệ'
    };
  }

  const numberValue = Number(rawValue);

  if (Number.isNaN(numberValue)) {
    return {
      valid: false,
      value: null,
      message: 'Số lượng thực tế phải là số'
    };
  }

  if (numberValue < 0) {
    return {
      valid: false,
      value: null,
      message: 'Số lượng thực tế không được âm'
    };
  }

  return {
    valid: true,
    value: numberValue,
    message: ''
  };
}


function validateAllSelectedItems() {
  for (const item of stocktakeState.selectedItems) {
    const result = parseActualQuantity(item.actual_quantity_input);

    if (!result.valid) {
      item.actual_quantity_error = result.message;

      return {
        valid: false,
        message: `Vật tư "${item.product_name}" chưa nhập số lượng thực tế hợp lệ`
      };
    }

    item.actual_quantity = result.value;
    item.actual_quantity_input = String(result.value);
    item.actual_quantity_error = '';
  }

  return {
    valid: true,
    message: ''
  };
}


/* =========================================================
   SELECTED ITEMS
========================================================= */

function addInventoryItem(inventoryId) {
  const item = stocktakeState.inventoryItems.find(
    row => Number(row.inventory_id) === Number(inventoryId)
  );

  if (!item) {
    alert('Không tìm thấy vật tư');
    return;
  }

  const existed = stocktakeState.selectedItems.some(
    row => Number(row.inventory_id) === Number(inventoryId)
  );

  if (existed) {
    alert('Vật tư này đã được chọn');
    return;
  }

  const defaultQuantity = Number(item.system_quantity || 0);

  stocktakeState.selectedItems.push({
    inventory_id: Number(item.inventory_id),
    product_id: Number(item.product_id),

    product_name: item.product_name,
    sku: item.sku,
    category_name: item.category_name,

    batch_number: item.batch_number,
    manufacturer_batch: item.manufacturer_batch,
    location_rack: item.location_rack,
    import_date: item.import_date || item.created_at,
    expiry_date: item.expiry_date,

    unit_name: item.unit_name,
    system_quantity: defaultQuantity,
    actual_quantity: defaultQuantity,
    actual_quantity_input: String(defaultQuantity),
    actual_quantity_error: '',

    item_condition: 'bình thường',
    loss_reason: '',

    image_files: [],
    image_previews: [],

    note: ''
  });

  renderSelectedItems();
  renderInventoryItems();
}


function removeSelectedItem(inventoryId) {
  const item = stocktakeState.selectedItems.find(
    row => Number(row.inventory_id) === Number(inventoryId)
  );

  if (item?.image_previews?.length) {
    item.image_previews.forEach(url => URL.revokeObjectURL(url));
  }

  stocktakeState.selectedItems = stocktakeState.selectedItems.filter(
    row => Number(row.inventory_id) !== Number(inventoryId)
  );

  renderSelectedItems();
  renderInventoryItems();
}


function updateSelectedItem(inventoryId, field, value) {
  const item = stocktakeState.selectedItems.find(
    row => Number(row.inventory_id) === Number(inventoryId)
  );

  if (!item) return;

  if (field === 'actual_quantity') {
    item.actual_quantity_input = value;

    const result = parseActualQuantity(value);

    if (!result.valid) {
      item.actual_quantity_error = result.message;
      updateActualQuantityUI(inventoryId, item);
      return;
    }

    item.actual_quantity = result.value;
    item.actual_quantity_error = '';
    updateActualQuantityUI(inventoryId, item);
    return;
  }

  item[field] = value;
}


function updateActualQuantityUI(inventoryId, item) {
  const input = document.querySelector(
    `[data-inventory-id="${Number(inventoryId)}"][data-field="actual_quantity"]`
  );

  if (!input) return;

  const row = input.closest('tr');
  const errorEl = row?.querySelector('.field-error');
  const diffCell = row?.querySelector('[data-diff-cell="true"]');

  if (item.actual_quantity_error) {
    input.classList.add('input-error');

    if (errorEl) {
      errorEl.textContent = item.actual_quantity_error;
      errorEl.style.display = 'block';
    }
  } else {
    input.classList.remove('input-error');

    if (errorEl) {
      errorEl.textContent = '';
      errorEl.style.display = 'none';
    }
  }

  if (diffCell) {
    const parsedActual = parseActualQuantity(item.actual_quantity_input);
    const actualForDiff = parsedActual.valid
      ? parsedActual.value
      : Number(item.actual_quantity || 0);

    const diff = actualForDiff - Number(item.system_quantity || 0);
    diffCell.innerHTML = renderDifference(diff);
  }
}


function updateSelectedItemImages(inventoryId, files) {
  const item = stocktakeState.selectedItems.find(
    row => Number(row.inventory_id) === Number(inventoryId)
  );

  if (!item) return;

  const selectedFiles = Array.from(files || []);

  if (!selectedFiles.length) {
    item.image_previews.forEach(url => URL.revokeObjectURL(url));
    item.image_files = [];
    item.image_previews = [];
    renderSelectedItems();
    return;
  }

  if (selectedFiles.length > 5) {
    alert('Mỗi dòng kiểm kê chỉ được chọn tối đa 5 ảnh');
    return;
  }

  const allowedTypes = [
    'image/jpeg',
    'image/jpg',
    'image/png',
    'image/webp'
  ];

  for (const file of selectedFiles) {
    if (!allowedTypes.includes(file.type)) {
      alert('Chỉ cho phép chọn ảnh JPG, PNG hoặc WEBP');
      return;
    }

    if (file.size > 5 * 1024 * 1024) {
      alert('Mỗi ảnh không được vượt quá 5MB');
      return;
    }
  }

  item.image_previews.forEach(url => URL.revokeObjectURL(url));

  item.image_files = selectedFiles;
  item.image_previews = selectedFiles.map(file => URL.createObjectURL(file));

  renderSelectedItems();
}


function renderSelectedItems() {
  const tbody = document.getElementById('selectedItemsBody');
  const countEl = document.getElementById('selectedCount');

  countEl.textContent = `${stocktakeState.selectedItems.length} dòng`;

  if (!stocktakeState.selectedItems.length) {
    tbody.innerHTML = `
      <tr>
        <td colspan="11" class="empty-cell">Chưa chọn vật tư nào.</td>
      </tr>
    `;
    return;
  }

  tbody.innerHTML = stocktakeState.selectedItems.map((item) => {
    const parsedActual = parseActualQuantity(item.actual_quantity_input ?? item.actual_quantity);
    const actualForDiff = parsedActual.valid ? parsedActual.value : Number(item.actual_quantity || 0);
    const diff = actualForDiff - Number(item.system_quantity || 0);

    return `
      <tr>
        <td>
          <strong>${escapeHtml(item.product_name)}</strong>
          <br>
          <small>SKU: ${escapeHtml(item.sku || '-')}</small>
          <br>
          <small>Danh mục: ${escapeHtml(item.category_name || '-')}</small>
          <br>
          <small>Kệ: ${escapeHtml(item.location_rack || '-')}</small>
          <br>
          <small>Ngày nhập: ${formatDate(item.import_date)}</small>
        </td>

        <td>
          ${escapeHtml(item.batch_number || '-')}
          <br>
          <small>Lô NSX: ${escapeHtml(item.manufacturer_batch || '-')}</small>
          <br>
          <small>HSD: ${formatDate(item.expiry_date)}</small>
        </td>

        <td>${escapeHtml(item.unit_name || '-')}</td>
        <td>${formatQuantity(item.system_quantity)}</td>

        <td>
          <input
            type="text"
            inputmode="decimal"
            value="${escapeAttribute(item.actual_quantity_input ?? item.actual_quantity ?? '')}"
            class="${item.actual_quantity_error ? 'input-error' : ''}"
            placeholder="Nhập số lượng"
            data-inventory-id="${Number(item.inventory_id)}"
            data-field="actual_quantity"
          >

          <small
            class="field-error"
            style="${item.actual_quantity_error ? '' : 'display:none;'}"
          >
            ${escapeHtml(item.actual_quantity_error || '')}
          </small>
        </td>

        <td data-diff-cell="true">${renderDifference(diff)}</td>

        <td>
          <select
            data-inventory-id="${Number(item.inventory_id)}"
            data-field="item_condition"
          >
            ${renderConditionOptions(item.item_condition)}
          </select>
        </td>

        <td>
          <input
            type="text"
            value="${escapeAttribute(item.loss_reason || '')}"
            placeholder="Hao hụt, hư hỏng..."
            data-inventory-id="${Number(item.inventory_id)}"
            data-field="loss_reason"
          >
        </td>

        <td>
          <div class="image-upload-cell">
            <label class="image-upload-btn">
              <i class="fa-solid fa-image"></i>
              Chọn ảnh
              <input
                type="file"
                multiple
                accept="image/jpeg,image/jpg,image/png,image/webp"
                data-inventory-id="${Number(item.inventory_id)}"
                data-field="image_files"
                hidden
              >
            </label>

            <span class="no-image-text">${item.image_files.length}/5 ảnh</span>

            ${item.image_previews.length ? `
              <div class="stocktake-preview-list">
                ${item.image_previews.map(url => `
                  <img
                    src="${escapeAttribute(url)}"
                    class="stocktake-preview-img"
                    alt="Ảnh kiểm kê"
                  >
                `).join('')}
              </div>
            ` : `
              <span class="no-image-text">Chưa có ảnh</span>
            `}
          </div>
        </td>

        <td>
          <textarea
            rows="1"
            placeholder="Ghi chú"
            data-inventory-id="${Number(item.inventory_id)}"
            data-field="note"
          >${escapeHtml(item.note || '')}</textarea>
        </td>

        <td>
          <button
            type="button"
            class="remove-row-btn"
            data-action="remove-selected"
            data-inventory-id="${Number(item.inventory_id)}"
          >
            <i class="fa-solid fa-xmark"></i>
          </button>
        </td>
      </tr>
    `;
  }).join('');
}


function renderConditionOptions(currentValue) {
  const options = [
    'bình thường',
    'ẩm mốc',
    'rách bao',
    'hư hỏng',
    'hết hạn'
  ];

  return options.map(option => `
    <option value="${escapeAttribute(option)}" ${option === currentValue ? 'selected' : ''}>
      ${escapeHtml(option)}
    </option>
  `).join('');
}


/* =========================================================
   CREATE STOCKTAKE
========================================================= */

async function createStocktake(submit) {
  try {
    if (!stocktakeState.selectedItems.length) {
      alert('Vui lòng chọn ít nhất 1 vật tư để kiểm kê');
      return;
    }

    const validation = validateAllSelectedItems();

    if (!validation.valid) {
      alert(validation.message);
      renderSelectedItems();
      return;
    }

    const stocktakeDate = document.getElementById('stocktakeDate').value;
    const warehouseArea = document.getElementById('warehouseArea').value.trim();
    const note = document.getElementById('stocktakeNote').value.trim();

    if (!stocktakeDate) {
      alert('Vui lòng chọn ngày kiểm kê');
      return;
    }

    const payload = {
      stocktake_date: stocktakeDate,
      warehouse_area: warehouseArea,
      note,
      submit,
      items: stocktakeState.selectedItems.map(item => ({
        inventory_id: item.inventory_id,
        actual_quantity: Number(item.actual_quantity),
        item_condition: item.item_condition,
        loss_reason: item.loss_reason,
        note: item.note
      }))
    };

    const confirmMessage = submit
      ? 'Bạn có chắc muốn tạo và gửi duyệt phiếu kiểm kê này?'
      : 'Bạn có chắc muốn lưu nháp phiếu kiểm kê này?';

    if (!confirm(confirmMessage)) return;

    const formData = new FormData();

    formData.append('payload', JSON.stringify(payload));

    stocktakeState.selectedItems.forEach((item, index) => {
      const files = Array.isArray(item.image_files)
        ? item.image_files.slice(0, 5)
        : [];

      files.forEach(file => {
        formData.append(`stocktake_images_${index}`, file);
      });
    });

    const result = await apiFetchFormData('/api/inventory/stocktakes', {
      method: 'POST',
      body: formData
    });

    alert(result.message || 'Tạo phiếu kiểm kê thành công');

    closeCreateModal();
    resetCreateForm();
    await loadStocktakes();

  } catch (error) {
    alert(error.message);
  }
}


async function submitDraftStocktake(stocktakeId) {
  try {
    if (!confirm('Bạn có chắc muốn gửi duyệt phiếu kiểm kê này?')) return;

    const result = await apiFetch(`/api/inventory/stocktakes/${stocktakeId}/submit`, {
      method: 'POST',
      body: JSON.stringify({})
    });

    alert(result.message || 'Gửi duyệt thành công');

    await loadStocktakes();

  } catch (error) {
    alert(error.message);
  }
}


/* =========================================================
   DETAIL MODAL
========================================================= */

async function openDetailModal(stocktakeId) {
  const modal = document.getElementById('detailModal');
  const content = document.getElementById('detailContent');

  modal.classList.add('show');
  content.innerHTML = `<div class="empty-box">Đang tải chi tiết...</div>`;

  try {
    const result = await apiFetch(`/api/inventory/stocktakes/${stocktakeId}`);
    renderStocktakeDetail(result.data);
  } catch (error) {
    content.innerHTML = `<div class="empty-box">${escapeHtml(error.message)}</div>`;
  }
}


function closeDetailModal() {
  document.getElementById('detailModal').classList.remove('show');
}


function normalizeImageUrls(imageUrl) {
  if (!imageUrl) return [];

  if (Array.isArray(imageUrl)) {
    return imageUrl;
  }

  if (typeof imageUrl === 'string') {
    try {
      const parsed = JSON.parse(imageUrl);
      return Array.isArray(parsed) ? parsed : [imageUrl];
    } catch (error) {
      return [imageUrl];
    }
  }

  return [];
}


function renderStocktakeDetail(data) {
  const content = document.getElementById('detailContent');
  const subtitle = document.getElementById('detailSubtitle');

  subtitle.textContent = `${data.stocktake_code} - ${getStatusText(data.status)}`;

  const items = Array.isArray(data.items) ? data.items : [];

  content.innerHTML = `
    <div class="detail-grid">
      <div class="detail-item">
        <span>Mã phiếu</span>
        <strong>${escapeHtml(data.stocktake_code)}</strong>
      </div>

      <div class="detail-item">
        <span>Trạng thái</span>
        <strong>${renderStatusBadge(data.status)}</strong>
      </div>

      <div class="detail-item">
        <span>Ngày kiểm kê</span>
        <strong>${formatDate(data.stocktake_date)}</strong>
      </div>

      <div class="detail-item">
        <span>Khu vực kho</span>
        <strong>${escapeHtml(data.warehouse_area || '-')}</strong>
      </div>

      <div class="detail-item">
        <span>Người tạo</span>
        <strong>${escapeHtml(data.created_by_name || '-')}</strong>
      </div>

      <div class="detail-item">
        <span>Ghi chú</span>
        <strong>${escapeHtml(data.note || '-')}</strong>
      </div>

      ${data.reject_reason ? `
        <div class="detail-item">
          <span>Lý do từ chối</span>
          <strong>${escapeHtml(data.reject_reason)}</strong>
        </div>
      ` : ''}
    </div>

    <div class="table-wrapper">
      <table>
        <thead>
          <tr>
            <th>Vật tư</th>
            <th>SKU</th>
            <th>Kệ</th>
            <th>Lô</th>
            <th>Ngày nhập</th>
            <th>HSD</th>
            <th>ĐVT</th>
            <th>Tồn HT</th>
            <th>Thực tế</th>
            <th>Chênh lệch</th>
            <th>Tình trạng</th>
            <th>Lý do</th>
            <th>Ảnh</th>
            <th>Ghi chú</th>
          </tr>
        </thead>

        <tbody>
          ${items.length ? items.map(item => {
            const diff = Number(item.difference_quantity || 0);
            const imageUrls = normalizeImageUrls(item.image_url);

            return `
              <tr>
                <td><strong>${escapeHtml(item.product_name)}</strong></td>
                <td>${escapeHtml(item.sku || '-')}</td>
                <td>${escapeHtml(item.location_rack || '-')}</td>
                <td>
                  ${escapeHtml(item.batch_number || '-')}
                  <br>
                  <small>Lô NSX: ${escapeHtml(item.manufacturer_batch || '-')}</small>
                </td>
                <td>${formatDate(item.import_date || item.created_at)}</td>
                <td>${formatDate(item.expiry_date)}</td>
                <td>${escapeHtml(item.unit_name || '-')}</td>
                <td>${formatQuantity(item.system_quantity)}</td>
                <td>${formatQuantity(item.actual_quantity)}</td>
                <td>${renderDifference(diff)}</td>
                <td>${escapeHtml(item.item_condition || '-')}</td>
                <td>${escapeHtml(item.loss_reason || '-')}</td>
                <td>
                  ${imageUrls.length ? `
                    <div class="detail-stocktake-img-list">
                      ${imageUrls.map(url => `
                        <a href="${escapeAttribute(url)}" target="_blank" rel="noopener">
                          <img
                            src="${escapeAttribute(url)}"
                            class="detail-stocktake-img"
                            alt="Ảnh kiểm kê"
                          >
                        </a>
                      `).join('')}
                    </div>
                  ` : '-'}
                </td>
                <td>${escapeHtml(item.note || '-')}</td>
              </tr>
            `;
          }).join('') : `
            <tr>
              <td colspan="14" class="empty-cell">Phiếu chưa có vật tư.</td>
            </tr>
          `}
        </tbody>
      </table>
    </div>
  `;
}


/* =========================================================
   MODAL CREATE
========================================================= */

function openCreateModal() {
  document.getElementById('createModal').classList.add('show');
  loadInventoryItems();
}


function closeCreateModal() {
  document.getElementById('createModal').classList.remove('show');
}


function resetCreateForm() {
  document.getElementById('stocktakeDate').value = new Date().toISOString().slice(0, 10);
  document.getElementById('warehouseArea').value = '';
  document.getElementById('stocktakeNote').value = '';
  document.getElementById('inventoryKeyword').value = '';

  const skuInput = document.getElementById('inventorySkuKeyword');
  const categoryInput = document.getElementById('inventoryCategoryKeyword');

  if (skuInput) skuInput.value = '';
  if (categoryInput) categoryInput.value = '';

  stocktakeState.selectedItems.forEach(item => {
    if (item.image_previews?.length) {
      item.image_previews.forEach(url => URL.revokeObjectURL(url));
    }
  });

  stocktakeState.selectedItems = [];

  renderSelectedItems();
  loadInventoryItems();
}


/* =========================================================
   HELPERS
========================================================= */

function renderStatusBadge(status) {
  return `<span class="badge badge-${status || 'draft'}">${getStatusText(status)}</span>`;
}


function getStatusText(status) {
  const map = {
    draft: 'Nháp',
    pending: 'Chờ duyệt',
    approved: 'Đã duyệt',
    rejected: 'Từ chối'
  };

  return map[status] || status || '-';
}


function renderDifference(value) {
  const number = Number(value || 0);

  if (number > 0) {
    return `<span class="diff-plus">+${formatQuantity(number)}</span>`;
  }

  if (number < 0) {
    return `<span class="diff-minus">${formatQuantity(number)}</span>`;
  }

  return `<span class="diff-zero">0</span>`;
}


function formatQuantity(value) {
  const number = Number(value || 0);

  return number.toLocaleString('vi-VN', {
    minimumFractionDigits: 0,
    maximumFractionDigits: 2
  });
}


function formatDate(value) {
  if (!value) return '-';

  const date = new Date(value);

  if (Number.isNaN(date.getTime())) return '-';

  return date.toLocaleDateString('vi-VN');
}


function escapeHtml(value) {
  return String(value ?? '')
    .replaceAll('&', '&amp;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;')
    .replaceAll("'", '&#039;');
}


function escapeAttribute(value) {
  return escapeHtml(value).replaceAll('`', '&#096;');
}