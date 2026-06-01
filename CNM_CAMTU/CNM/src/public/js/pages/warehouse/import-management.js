/* =========================================================
   WAREHOUSE IMPORT MANAGEMENT PAGE
   Cookie Auth Version
   Tất cả request đều dùng credentials: include
========================================================= */


/* =========================================================
   1. API CONFIG
   Khai báo toàn bộ endpoint dùng trong trang
========================================================= */

const API = {
  // Dùng endpoint chi tiết theo từng lô hàng
  // Có: SKU, CategoryName, BatchNumber, LocationRack, ExpiryDate, AvailableQuantity
  inventory: '/api/inventory/details',

  suppliers: '/api/inventory/suppliers',
  products: '/api/products',
  categories: '/api/products/categories',
  units: '/api/products/units',
  goodsReceipts: '/api/inventory/goods-receipts'
};


/* =========================================================
   2. GLOBAL STATE
   Lưu dữ liệu tạm trên frontend sau khi load từ API
========================================================= */

const state = {
  suppliers: [],
  products: [],
  inventory: [],
  categories: [],
  units: []
};


/* =========================================================
   3. API CLIENT
   Hàm request dùng chung cho toàn bộ trang
   - Tự thêm credentials: include
   - Tự parse JSON
   - Tự throw error nếu API lỗi
========================================================= */

async function request(url, options = {}) {
  const res = await fetch(url, {
    ...options,

    credentials: 'include',

    headers: {
      'Content-Type': 'application/json',
      ...(options.headers || {})
    }
  });

  const data = await res.json().catch(() => ({}));

  if (!res.ok || data.success === false) {
    throw new Error(data.message || 'Có lỗi xảy ra');
  }

  return data;
}


/* =========================================================
   4. UI HELPERS
   Các hàm tiện ích dùng chung cho giao diện
========================================================= */

function showToast(message, type = 'success', sub = '') {
  const box = document.getElementById('toastContainer');

  if (!box) return;

  const el = document.createElement('div');

  el.className = `toast ${type}`;

  el.innerHTML = `
    ${message}
    ${sub ? `<small>${sub}</small>` : ''}
  `;

  box.appendChild(el);

  setTimeout(() => {
    el.remove();
  }, 3200);
}

function formatDate(value) {
  if (!value) return '-';

  const date = new Date(value);

  if (Number.isNaN(date.getTime())) {
    return '-';
  }

  return date.toLocaleDateString('vi-VN');
}

function formatNumber(value) {
  return Number(value || 0).toLocaleString('vi-VN');
}

function normalizeList(payload) {
  if (Array.isArray(payload?.data)) return payload.data;
  if (Array.isArray(payload?.data?.items)) return payload.data.items;
  if (Array.isArray(payload?.data?.products)) return payload.data.products;
  if (Array.isArray(payload?.items)) return payload.items;

  return [];
}

function formToObject(form) {
  return Object.fromEntries(new FormData(form).entries());
}


/* =========================================================
   5. MODAL HANDLER
   Xử lý mở / đóng modal
========================================================= */

function openModal(id) {
  document.getElementById(id)?.classList.add('show');
}

function closeModal(id) {
  document.getElementById(id)?.classList.remove('show');
}

function bindModals() {
  // Mở modal theo data-open-modal
  document.querySelectorAll('[data-open-modal]').forEach(btn => {
    btn.addEventListener('click', () => {
      openModal(btn.dataset.openModal);
    });
  });

  // Đóng modal theo data-close-modal
  document.querySelectorAll('[data-close-modal]').forEach(btn => {
    btn.addEventListener('click', () => {
      closeModal(btn.dataset.closeModal);
    });
  });

  // Click nền đen bên ngoài modal thì đóng modal
  document.querySelectorAll('.modal-overlay').forEach(overlay => {
    overlay.addEventListener('click', (e) => {
      if (e.target === overlay) {
        overlay.classList.remove('show');
      }
    });
  });
}


/* =========================================================
   6. TAB HANDLER
   Xử lý chuyển tab Tồn kho / Nhà cung cấp / Phiếu nhập
========================================================= */

function bindTabs() {
  document.querySelectorAll('.tab-btn').forEach(btn => {
    btn.addEventListener('click', () => {
      document
        .querySelectorAll('.tab-btn')
        .forEach(x => x.classList.remove('active'));

      document
        .querySelectorAll('.tab-panel')
        .forEach(x => x.classList.remove('active'));

      btn.classList.add('active');

      document
        .getElementById(btn.dataset.tab)
        ?.classList.add('active');
    });
  });
}


/* =========================================================
   7. INVENTORY RENDER
   Xử lý hiển thị bảng tồn kho + trạng thái hàng
========================================================= */

function getStockStatus(item) {
  if (Number(item.HasInventory) === 0 || item.InventoryID === null) {
    return {
      text: 'Chưa nhập kho',
      color: 'orange'
    };
  }

  const qty = Number(
    // item.AvailableQuantity ??
    item.Quantity ??
    item.quantity ??
    0
  );

  const min = Number(
    item.MinStockLevel ??
    10
  );

  if (qty <= 0) {
    return {
      text: 'Hết hàng',
      color: 'red'
    };
  }

  if (qty <= min) {
    return {
      text: 'Sắp hết',
      color: 'orange'
    };
  }

  return {
    text: 'Ổn định',
    color: 'green'
  };
}

function getStockStatusCode(item) {
  if (Number(item.HasInventory) === 0 || item.InventoryID === null) {
    return 'NO_INVENTORY';
  }

  const qty = Number(
    item.AvailableQuantity ??
    item.Quantity ??
    item.quantity ??
    0
  );

  const min = Number(
    item.MinStockLevel ??
    10
  );

  if (qty <= 0) {
    return 'OUT_OF_STOCK';
  }

  if (qty <= min) {
    return 'LOW_STOCK';
  }

  return 'AVAILABLE';
}

function getFilteredInventory() {
  const sku =
    document
      .getElementById('filterSku')
      ?.value
      .trim()
      .toLowerCase() || '';

  const name =
    document
      .getElementById('filterProduct')
      ?.value
      .trim()
      .toLowerCase() || '';

  const batch =
    document
      .getElementById('filterBatch')
      ?.value
      .trim()
      .toLowerCase() || '';

  const categoryId =
    document
      .getElementById('filterCategory')
      ?.value || '';

  const stockStatus =
    document
      .getElementById('filterStockStatus')
      ?.value || '';

  return state.inventory.filter(item => {
    const itemSku = String(
      item.SKU ||
      item.sku ||
      ''
    ).toLowerCase();

    const itemName = String(
      item.ProductName ||
      item.product_name ||
      item.name ||
      ''
    ).toLowerCase();

    const itemBatch = String(
      item.BatchNumber ||
      item.batch_number ||
      ''
    ).toLowerCase();

    const itemCategoryId = String(
      item.CategoryID ??
      item.category_id ??
      item.categoryId ??
      ''
    );

    const itemStockStatus = getStockStatusCode(item);

    return (
      (!sku || itemSku.includes(sku)) &&
      (!name || itemName.includes(name)) &&
      (!batch || itemBatch.includes(batch)) &&
      (!categoryId || itemCategoryId === categoryId) &&
      (!stockStatus || itemStockStatus === stockStatus)
    );
  });
}

function renderInventory() {
  const body = document.getElementById('inventoryTableBody');
  const count = document.getElementById('inventoryCount');

  if (!body) return;

  const rows = getFilteredInventory();

  if (count) {
    count.textContent =
      `Hiển thị: ${rows.length}/${state.inventory.length} dòng tồn kho`;
  }

  if (!rows.length) {
    body.innerHTML = `
      <tr>
        <td colspan="10" class="empty-cell">
          Không có dữ liệu tồn kho
        </td>
      </tr>
    `;
    return;
  }

  body.innerHTML = rows.map((item, index) => {
    const status = getStockStatus(item);

    const categoryName =
      item.CategoryName ||
      item.category_name ||
      'Chưa phân loại';

    return `
      <tr>
        <td>${String(index + 1).padStart(2, '0')}</td>

        <td class="sku">
          ${item.SKU || item.sku || '-'}
        </td>

        <td>
          <b>${item.ProductName || item.product_name || item.name || '-'}</b>
        </td>

        <td>
          <span class="badge">${categoryName}</span>
        </td>

        <td>
          ${item.BatchNumber || item.batch_number || '-'}
        </td>

        <td>
          ${item.LocationRack || item.location_rack || '-'}
        </td>

        <td>
          <b>${formatNumber(item.Quantity || item.quantity)}</b>
        </td>


        <td>
          ${formatDate(item.ExpiryDate || item.expiry_date)}
        </td>

        <td>
          <span class="status-dot ${status.color}"></span>
          ${status.text}
        </td>
      </tr>
    `;
  }).join('');
}


/* =========================================================
   8. SUPPLIER RENDER
   Xử lý hiển thị bảng nhà cung cấp
========================================================= */

function renderSuppliers() {
  const body = document.getElementById('supplierTableBody');
  const count = document.getElementById('supplierCount');

  if (!body) return;

  if (count) {
    count.textContent = `Tổng: ${state.suppliers.length} nhà cung cấp`;
  }

  if (!state.suppliers.length) {
    body.innerHTML = `
      <tr>
        <td colspan="7" class="empty-cell">
          Chưa có nhà cung cấp
        </td>
      </tr>
    `;
    return;
  }

  body.innerHTML = state.suppliers.map((s, index) => `
    <tr>
      <td>${String(index + 1).padStart(2, '0')}</td>

      <td>
        <b>${s.supplier_name || '-'}</b>
        <br>
        <small>${s.address || ''}</small>
      </td>

      <td>${s.contact_name || '-'}</td>
      <td>${s.phone_number || '-'}</td>
      <td>${s.email || '-'}</td>
      <td>${s.tax_code || '-'}</td>

      <td>
        <span class="badge ${s.status === 'INACTIVE' ? 'red' : ''}">
          ${s.status || 'ACTIVE'}
        </span>
      </td>
    </tr>
  `).join('');
}


/* =========================================================
   9. SELECT OPTIONS RENDER
   Đổ dữ liệu vào các select:
   - Nhà cung cấp
   - Danh mục sản phẩm
   - Đơn vị tính
   - Sản phẩm trong phiếu nhập
========================================================= */

function fillSupplierSelects() {
  const selects = [
    document.getElementById('filterSupplier'),
    document.getElementById('receiptSupplierSelect')
  ].filter(Boolean);

  selects.forEach(select => {
    const firstOption =
      select.id === 'filterSupplier'
        ? '<option value="">Tất cả nhà cung cấp</option>'
        : '<option value="">Chọn nhà cung cấp</option>';

    const supplierOptions = state.suppliers.map(s => `
      <option value="${s.supplier_id}">
        ${s.supplier_name}
      </option>
    `).join('');

    select.innerHTML = firstOption + supplierOptions;
  });
}

function fillProductMeta() {
  const categorySelect =
    document.getElementById('productCategorySelect');

  const unitSelect =
    document.getElementById('productUnitSelect');

  const filterCategorySelect =
    document.getElementById('filterCategory');

  const categoryOptions = state.categories.map(c => {
    const id =
      c.CategoryID ??
      c.category_id ??
      c.id;

    const name =
      c.CategoryName ??
      c.category_name ??
      c.name ??
      'Không tên';

    return `
      <option value="${id}">
        ${name}
      </option>
    `;
  }).join('');

  if (categorySelect) {
    categorySelect.innerHTML = `
      <option value="">Chọn danh mục</option>
      ${categoryOptions}
    `;
  }

  if (filterCategorySelect) {
    filterCategorySelect.innerHTML = `
      <option value="">Tất cả danh mục</option>
      ${categoryOptions}
    `;
  }

  if (unitSelect) {
    unitSelect.innerHTML = `
      <option value="">Chọn đơn vị</option>
      ${state.units.map(u => {
        const id =
          u.PUnitID ??
          u.UnitID ??
          u.unit_id ??
          u.id;

        const name =
          u.Name ??
          u.UnitName ??
          u.name ??
          'Không tên';

        return `
          <option value="${id}">
            ${name}
          </option>
        `;
      }).join('')}
    `;
  }
}

function fillReceiptProductSelect(select) {
  if (!select) return;

  select.innerHTML = `
    <option value="">Chọn sản phẩm</option>
    ${state.products.map(p => `
      <option value="${p.ProductID}">
        ${p.ProductName}
      </option>
    `).join('')}
  `;
}


/* =========================================================
   10. GOODS RECEIPT LINE UI
   Xử lý thêm / xóa dòng sản phẩm trong phiếu nhập kho
========================================================= */

function addReceiptLine() {
  const wrap = document.getElementById('receiptLines');
  const template = document.getElementById('receiptLineTemplate');

  if (!wrap || !template) return;

  const node = template.content.cloneNode(true);

  const select = node.querySelector('.line-product');

  fillReceiptProductSelect(select);

  node
    .querySelector('.line-remove')
    ?.addEventListener('click', (e) => {
      e.currentTarget.closest('.receipt-line')?.remove();
    });

  wrap.appendChild(node);
}

function clearReceiptLines() {
  const wrap = document.getElementById('receiptLines');

  if (!wrap) return;

  wrap.innerHTML = '';
}

function collectReceiptItems() {
  return [...document.querySelectorAll('.receipt-line')]
    .map(line => ({
      product_id: Number(
        line.querySelector('.line-product')?.value
      ),

      received_quantity: Number(
        line.querySelector('.line-received')?.value || 0
      ),

      faulty_quantity: Number(
        line.querySelector('.line-faulty')?.value || 0
      ),

      unit_price: Number(
        line.querySelector('.line-price')?.value || 0
      ),

      batch_number:
        line.querySelector('.line-batch')?.value.trim() || null,

      expiry_date:
        line.querySelector('.line-expiry')?.value || null,

      location_rack:
        line.querySelector('.line-rack')?.value.trim() || null
    }))
    .filter(item => {
      return item.product_id && item.received_quantity > 0;
    });
}


/* =========================================================
   11. LOAD DATA FROM API
   Các hàm gọi API để lấy dữ liệu ban đầu
========================================================= */

async function loadSuppliers() {
  const data = await request(API.suppliers);

  state.suppliers = normalizeList(data);

  renderSuppliers();
  fillSupplierSelects();
}

async function loadInventory() {
  try {
    const data = await request(API.inventory);

    state.inventory = normalizeList(data);
  } catch (err) {
    state.inventory = [];

    showToast(
      'Không tải được tồn kho',
      'error',
      err.message
    );
  }

  renderInventory();
}

async function loadProducts() {
  try {
    const data = await request(`${API.products}?limit=200`);

    state.products = normalizeList(data);
  } catch (err) {
    state.products = [];

    showToast(
      'Không tải được sản phẩm',
      'error',
      err.message
    );
  }
}

async function loadProductMeta() {
  try {
    const [categories, units] = await Promise.all([
      request(API.categories),
      request(API.units)
    ]);

    state.categories = normalizeList(categories);
    state.units = normalizeList(units);

    fillProductMeta();
  } catch (err) {
    showToast(
      'Không tải được danh mục/đơn vị',
      'error',
      err.message
    );
  }
}


/* =========================================================
   12. SUPPLIER FORM
   Xử lý form tạo nhà cung cấp
========================================================= */

function bindSupplierForm() {
  const form = document.getElementById('supplierForm');

  if (!form) return;

  form.addEventListener('submit', async (e) => {
    e.preventDefault();

    try {
      const payload = formToObject(form);

      const data = await request(API.suppliers, {
        method: 'POST',
        body: JSON.stringify(payload)
      });

      showToast(
        'Tạo nhà cung cấp thành công',
        'success',
        data.data?.supplier_name || ''
      );

      form.reset();
      closeModal('supplierModal');

      await loadSuppliers();
    } catch (err) {
      showToast(
        'Tạo nhà cung cấp thất bại',
        'error',
        err.message
      );
    }
  });
}


/* =========================================================
   13. PRODUCT FORM
   Xử lý form tạo sản phẩm
========================================================= */

function bindProductForm() {
  const form = document.getElementById('productForm');

  if (!form) return;

  form.addEventListener('submit', async (e) => {
    e.preventDefault();

    try {
      const payload = formToObject(form);

      payload.Price = Number(payload.Price || 0);
      payload.CategoryID = Number(payload.CategoryID);
      payload.UnitID = Number(payload.UnitID);
      payload.StatusID = Number(payload.StatusID || 1);

      const data = await request(API.products, {
        method: 'POST',
        body: JSON.stringify(payload)
      });

      showToast(
        'Tạo sản phẩm thành công',
        'success',
        data.data?.ProductName || ''
      );

      form.reset();
      closeModal('productModal');

      await loadProducts();
    } catch (err) {
      showToast(
        'Tạo sản phẩm thất bại',
        'error',
        err.message
      );
    }
  });
}


/* =========================================================
   14. GOODS RECEIPT FORM
   Xử lý form tạo phiếu nhập kho
========================================================= */

function bindReceiptForm() {
  const form = document.getElementById('receiptForm');
  const btnAdd = document.getElementById('btnAddReceiptLine');

  btnAdd?.addEventListener('click', addReceiptLine);

  if (!form) return;

  form.addEventListener('submit', async (e) => {
    e.preventDefault();

    try {
      const base = formToObject(form);

      const items = collectReceiptItems();

      if (!items.length) {
        throw new Error('Phiếu nhập cần ít nhất 1 dòng sản phẩm');
      }

      const payload = {
        purchase_order_id: null,
        supplier_id: Number(base.supplier_id),
        received_date: base.received_date || null,
        note: base.note || null,
        items
      };

      await request(API.goodsReceipts, {
        method: 'POST',
        body: JSON.stringify(payload)
      });

      showToast('Tạo phiếu nhập kho thành công');

      form.reset();
      clearReceiptLines();
      addReceiptLine();

      closeModal('receiptModal');

      await loadInventory();
    } catch (err) {
      showToast(
        'Tạo phiếu nhập kho thất bại',
        'error',
        err.message
      );
    }
  });
}


/* =========================================================
   15. FILTER HANDLER
   Xử lý lọc tồn kho theo SKU, tên sản phẩm, mã lô
========================================================= */

function bindFilters() {
  document
    .getElementById('btnApplyFilter')
    ?.addEventListener('click', renderInventory);

  document
    .getElementById('btnReload')
    ?.addEventListener('click', initData);

  [
    'filterSku',
    'filterProduct',
    'filterBatch'
  ].forEach(id => {
    document
      .getElementById(id)
      ?.addEventListener('input', renderInventory);
  });

  [
    'filterCategory',
    'filterStockStatus',
    'filterSupplier'
  ].forEach(id => {
    document
      .getElementById(id)
      ?.addEventListener('change', renderInventory);
  });
}


/* =========================================================
   16. INIT DATA
   Load toàn bộ dữ liệu ban đầu cho trang
========================================================= */

async function initData() {
  await Promise.all([
    loadSuppliers().catch(err => {
      showToast(
        'Không tải được nhà cung cấp',
        'error',
        err.message
      );
    }),

    loadInventory(),

    loadProducts(),

    loadProductMeta()
  ]);

  const receiptLines =
    document.getElementById('receiptLines');

  if (receiptLines && !receiptLines.children.length) {
    addReceiptLine();
  }
}


/* =========================================================
   17. PAGE INIT
   Gắn sự kiện sau khi DOM load xong
========================================================= */

document.addEventListener('DOMContentLoaded', () => {
  bindModals();
  bindTabs();

  bindSupplierForm();
  bindProductForm();
  bindReceiptForm();

  bindFilters();

  initData();
});