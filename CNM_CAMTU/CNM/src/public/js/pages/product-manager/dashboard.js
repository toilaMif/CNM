/* =========================================================
   PRODUCT MANAGER - DASHBOARD

   Nguồn dữ liệu chính:
   GET /api/products/dashboard
========================================================= */

const API_DASHBOARD = '/api/products/dashboard';

// Đổi route này theo trang tạo phiếu nhập kho thật của bạn nếu khác.
const CREATE_IMPORT_PAGE_URL = '/product-manager/import-management';

let dashboardCache = null;
let outOfStockCache = [];

/* =========================================================
   COMMON HELPERS
========================================================= */

function escapeHTML(value) {
  return String(value ?? '')
    .replaceAll('&', '&amp;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;')
    .replaceAll("'", '&#039;');
}

function formatNumber(value) {
  return Number(value || 0).toLocaleString('vi-VN');
}

async function fetchJSON(url) {
  const response = await fetch(url, {
    method: 'GET',
    credentials: 'include',
    headers: {
      'Content-Type': 'application/json'
    }
  });

  const data = await response.json().catch(() => ({}));

  if (!response.ok || data.success === false) {
    throw new Error(data.message || 'Không thể tải dữ liệu dashboard');
  }

  return data;
}

function setText(id, value) {
  const el = document.getElementById(id);
  if (!el) return;
  el.textContent = value;
}

function getDashboardData(payload) {
  return (
    payload?.data?.data ||
    payload?.data ||
    payload ||
    {}
  );
}

function normalizeRows(rows) {
  return Array.isArray(rows) ? rows : [];
}

/* =========================================================
   PRODUCT FIELD HELPERS
========================================================= */

function getProductId(item) {
  return (
    item.ProductID ??
    item.product_id ??
    item.productId ??
    item.id
  );
}

function getProductName(item) {
  return (
    item.ProductName ||
    item.product_name ||
    item.productName ||
    item.name ||
    'Sản phẩm'
  );
}

function getProductSku(item) {
  return (
    item.SKU ||
    item.sku ||
    item.ProductSKU ||
    item.product_sku ||
    'N/A'
  );
}

function getCategoryName(item) {
  return (
    item.CategoryName ||
    item.category_name ||
    item.categoryName ||
    ''
  );
}

function getUnitName(item) {
  return (
    item.UnitName ||
    item.unit_name ||
    item.unitName ||
    ''
  );
}

function getAvailableQuantity(item) {
  return Number(
    item.AvailableQuantity ??
    item.available_quantity ??
    item.availableQuantity ??
    item.TotalAvailableQty ??
    item.totalAvailableQty ??
    item.totalAvailableQuantity ??
    0
  );
}

function getMinStockLevel(item) {
  return Number(
    item.MinStockLevel ??
    item.min_stock_level ??
    item.minStockLevel ??
    0
  );
}

function getSuggestedQuantity(item) {
  return Number(
    item.suggestedQuantity ??
    item.suggested_quantity ??
    item.SuggestedQuantity ??
    0
  );
}

function getTotalSold(item) {
  return Number(
    item.totalSold ??
    item.total_sold ??
    item.TotalSold ??
    0
  );
}

/* =========================================================
   NORMAL RENDER LIST
========================================================= */

function renderList(containerId, items, config) {
  const container = document.getElementById(containerId);

  if (!container) return;

  const rows = normalizeRows(items);

  if (!rows.length) {
    container.innerHTML = `<p class="empty-text">Chưa có dữ liệu</p>`;
    return;
  }

  container.innerHTML = rows.map(item => {
    const productName = getProductName(item);
    const sku = getProductSku(item);
    const categoryName = getCategoryName(item);

    return `
      <div class="list-item">
        <div class="item-info">
          <h4>${escapeHTML(productName)}</h4>
          <p>
            SKU: ${escapeHTML(sku)}
            ${categoryName ? ` • ${escapeHTML(categoryName)}` : ''}
          </p>
        </div>

        <div class="item-value ${escapeHTML(config.valueClass || '')}">
          ${config.getValue(item)}
        </div>
      </div>
    `;
  }).join('');
}

/* =========================================================
   OUT OF STOCK MODAL
========================================================= */

function openOutOfStockModal() {
  const modal = document.getElementById('outOfStockModal');
  if (!modal) return;

  renderOutOfStockProductList();
  modal.classList.remove('hidden');
}

function closeOutOfStockModal() {
  const modal = document.getElementById('outOfStockModal');
  if (!modal) return;

  modal.classList.add('hidden');
}

function renderOutOfStockProductList() {
  const container = document.getElementById('outOfStockProductList');

  if (!container) return;

  const rows = normalizeRows(outOfStockCache);

  if (!rows.length) {
    container.innerHTML = `
      <p class="empty-text">
        Hiện chưa có sản phẩm hết hàng.
      </p>
    `;
    return;
  }

  container.innerHTML = rows.map(item => {
    const productId = getProductId(item);
    const productName = getProductName(item);
    const sku = getProductSku(item);
    const categoryName = getCategoryName(item);
    const unitName = getUnitName(item);
    const available = getAvailableQuantity(item);
    const minStock = getMinStockLevel(item);

    return `
      <label class="out-stock-item">
        <input
          type="checkbox"
          class="out-stock-checkbox"
          value="${escapeHTML(productId)}"
        >

        <div class="out-stock-info">
          <h4>${escapeHTML(productName)}</h4>
          <p>
            SKU: ${escapeHTML(sku)}
            ${categoryName ? ` • ${escapeHTML(categoryName)}` : ''}
            ${unitName ? ` • Đơn vị: ${escapeHTML(unitName)}` : ''}
          </p>
        </div>

        <div class="out-stock-value">
          Tồn: ${formatNumber(available)}
          <br>
          Min: ${formatNumber(minStock)}
        </div>
      </label>
    `;
  }).join('');

  const selectAll = document.getElementById('selectAllOutOfStock');
  if (selectAll) selectAll.checked = false;
}

function getSelectedOutOfStockProducts() {
  const checkedBoxes = document.querySelectorAll('.out-stock-checkbox:checked');
  const selectedIds = [...checkedBoxes]
    .map(input => Number(input.value))
    .filter(id => Number.isInteger(id) && id > 0);

  return outOfStockCache.filter(item => {
    return selectedIds.includes(Number(getProductId(item)));
  });
}

function toggleSelectAllOutOfStock() {
  const selectAll = document.getElementById('selectAllOutOfStock');
  const checked = Boolean(selectAll?.checked);

  document.querySelectorAll('.out-stock-checkbox').forEach(input => {
    input.checked = checked;
  });
}

function goToCreateImportWithSelectedProducts() {
  const selectedProducts = getSelectedOutOfStockProducts();

  if (!selectedProducts.length) {
    alert('Vui lòng chọn ít nhất một sản phẩm hết hàng');
    return;
  }

  const payload = selectedProducts.map(item => {
    const productId = getProductId(item);
    const available = getAvailableQuantity(item);
    const minStock = getMinStockLevel(item);

    return {
      product_id: Number(productId),
      ProductID: Number(productId),

      product_name: getProductName(item),
      ProductName: getProductName(item),

      sku: getProductSku(item),
      SKU: getProductSku(item),

      category_name: getCategoryName(item),
      CategoryName: getCategoryName(item),

      unit_name: getUnitName(item),
      UnitName: getUnitName(item),

      available_quantity: available,
      AvailableQuantity: available,

      min_stock_level: minStock,
      MinStockLevel: minStock,

      suggested_quantity: minStock > 0 ? minStock * 2 : 10
    };
  });

  const json = JSON.stringify(payload);

  localStorage.setItem('PM_SELECTED_OUT_OF_STOCK_PRODUCTS', json);
  sessionStorage.setItem('PM_SELECTED_OUT_OF_STOCK_PRODUCTS', json);

  console.log('SAVED OUT OF STOCK PRODUCTS:', payload);

  window.location.href = CREATE_IMPORT_PAGE_URL;
}

/* =========================================================
   RENDER DASHBOARD
========================================================= */

function renderDashboard(data) {
  dashboardCache = data;

  const summary = data.summary || {};

  const bestSellingRows = normalizeRows(data.bestSellingProducts);
  const highStockRows = normalizeRows(data.highStockProducts);
  const lowStockRows = normalizeRows(data.lowStockProducts);
  const reorderRows = normalizeRows(data.reorderSuggestions);

  outOfStockCache = normalizeRows(data.outOfStockProductsList);

  const totalProducts = Number(summary.totalProducts || 0);
  const activeProducts = Number(summary.activeProducts || 0);

  const outOfStockProducts = Number(
    summary.outOfStockProducts ??
    outOfStockCache.length ??
    0
  );

  const lowStockProducts = Number(
    summary.lowStockProducts ??
    lowStockRows.length ??
    0
  );

  const newProductsThisMonth = Number(summary.newProductsThisMonth || 0);

  setText('totalProducts', formatNumber(totalProducts));
  setText('activeProducts', formatNumber(activeProducts));
  setText('outOfStockProducts', formatNumber(outOfStockProducts));
  setText('lowStockProducts', formatNumber(lowStockProducts));
  setText('newProductsThisMonth', formatNumber(newProductsThisMonth));

  renderList('bestSellingProducts', bestSellingRows, {
    getValue: item => `${formatNumber(getTotalSold(item))} bán`
  });

  renderList('highStockProducts', highStockRows, {
    getValue: item => `${formatNumber(getAvailableQuantity(item))} tồn`
  });

  renderList('lowStockProductsList', lowStockRows, {
    valueClass: 'warning',
    getValue: item => {
      const available = getAvailableQuantity(item);
      const minStock = getMinStockLevel(item);

      return `${formatNumber(available)} / min ${formatNumber(minStock)}`;
    }
  });

  renderList('reorderSuggestions', reorderRows, {
    valueClass: 'orange',
    getValue: item => {
      const suggestedQuantity = getSuggestedQuantity(item);
      return `Nhập ${formatNumber(suggestedQuantity)}`;
    }
  });
}

/* =========================================================
   BIND EVENTS
========================================================= */

function bindDashboardEvents() {
  document
    .getElementById('openOutOfStockModalBtn')
    ?.addEventListener('click', openOutOfStockModal);

  document
    .getElementById('closeOutOfStockModalBtn')
    ?.addEventListener('click', closeOutOfStockModal);

  document
    .getElementById('selectAllOutOfStock')
    ?.addEventListener('change', toggleSelectAllOutOfStock);

  document
    .getElementById('goToCreateImportBtn')
    ?.addEventListener('click', goToCreateImportWithSelectedProducts);

  window.addEventListener('click', event => {
    const modal = document.getElementById('outOfStockModal');

    if (event.target === modal) {
      closeOutOfStockModal();
    }
  });
}

/* =========================================================
   LOAD DASHBOARD
========================================================= */

async function loadDashboard() {
  const result = await fetchJSON(API_DASHBOARD);
  const data = getDashboardData(result);

  console.log('PRODUCT MANAGER DASHBOARD DATA:', data);

  renderDashboard(data);
}

document.addEventListener('DOMContentLoaded', async () => {
  try {
    bindDashboardEvents();
    await loadDashboard();
  } catch (error) {
    console.error('LOAD PRODUCT MANAGER DASHBOARD ERROR:', error);

    document.querySelectorAll('.list-box').forEach(box => {
      box.innerHTML = `<p class="empty-text">Không tải được dữ liệu</p>`;
    });

    alert(error.message || 'Không tải được dashboard');
  }
});