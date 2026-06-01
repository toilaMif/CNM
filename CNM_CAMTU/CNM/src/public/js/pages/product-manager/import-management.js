/* =========================================================
   PRODUCT MANAGER - IMPORT MANAGEMENT
   Procurement version

   Chức năng chính:
   - Load tồn kho chi tiết theo lô từ /api/inventory/details
   - Bảng chính gom dữ liệu theo SKU
   - Click vào 1 SKU để xem toàn bộ batch/lô thuộc SKU đó
   - Lọc tồn kho theo SKU, tên sản phẩm, danh mục, trạng thái
   - Phân trang tồn kho: 20 SKU / trang
   - Tạo nhà cung cấp
   - Tạo sản phẩm
   - Tạo phiếu đặt hàng PO
   - Nhận danh sách sản phẩm hết hàng từ Product Manager Dashboard
========================================================= */


/* =========================================================
   1. API CONFIG
========================================================= */

const API = {
    inventory: '/api/inventory/details',

    suppliers: '/api/procurement/suppliers',

    products: '/api/products',
    categories: '/api/products/categories',
    units: '/api/products/units',

    purchaseOrders: '/api/procurement/purchase-orders'
};

// Key dùng chung với dashboard.js
const PM_OUT_OF_STOCK_STORAGE_KEY = 'PM_SELECTED_OUT_OF_STOCK_PRODUCTS';


/* =========================================================
   2. GLOBAL STATE
========================================================= */

const state = {
    inventory: [],
    suppliers: [],
    products: [],
    categories: [],
    units: [],
    purchaseOrders: [],

    inventoryPage: 1,
    inventoryPageSize: 20
};


/* =========================================================
   3. API CLIENT
========================================================= */

async function request(url, options = {}) {
    const token = localStorage.getItem('accessToken');

    const headers = {
        'Content-Type': 'application/json',
        ...(options.headers || {})
    };

    if (token) {
        headers.Authorization = `Bearer ${token}`;
    }

    const res = await fetch(url, {
        ...options,
        credentials: 'include',
        headers
    });

    const data = await res.json().catch(() => ({}));

    if (!res.ok || data.success === false) {
        throw new Error(data.message || 'Có lỗi xảy ra');
    }

    return data;
}


/* =========================================================
   4. NORMALIZE DATA
========================================================= */

function normalizeList(payload) {
    if (Array.isArray(payload)) return payload;

    if (Array.isArray(payload?.data)) return payload.data;
    if (Array.isArray(payload?.items)) return payload.items;
    if (Array.isArray(payload?.products)) return payload.products;
    if (Array.isArray(payload?.purchaseOrders)) return payload.purchaseOrders;

    if (Array.isArray(payload?.data?.items)) return payload.data.items;
    if (Array.isArray(payload?.data?.products)) return payload.data.products;
    if (Array.isArray(payload?.data?.purchaseOrders)) return payload.data.purchaseOrders;
    if (Array.isArray(payload?.data?.rows)) return payload.data.rows;
    if (Array.isArray(payload?.data?.data)) return payload.data.data;

    if (Array.isArray(payload?.result)) return payload.result;
    if (Array.isArray(payload?.results)) return payload.results;

    return [];
}


/* =========================================================
   5. FORM HELPER
========================================================= */

function formToObject(form) {
    return Object.fromEntries(new FormData(form).entries());
}


/* =========================================================
   6. UI HELPERS
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

function formatCurrency(value) {
    return Number(value || 0).toLocaleString('vi-VN', {
        style: 'currency',
        currency: 'VND'
    });
}

function formatDate(value) {
    if (!value) return '-';

    const date = new Date(value);

    if (Number.isNaN(date.getTime())) {
        return '-';
    }

    return date.toLocaleDateString('vi-VN');
}

function formatDateTime(value) {
    if (!value) return '-';

    const date = new Date(value);

    if (Number.isNaN(date.getTime())) {
        return '-';
    }

    return date.toLocaleString('vi-VN');
}

function showToast(message, type = 'success', sub = '') {
    const box = document.getElementById('toastContainer');

    if (!box) {
        alert(sub ? `${message}\n${sub}` : message);
        return;
    }

    const el = document.createElement('div');
    el.className = `toast ${type}`;

    el.innerHTML = `
        ${escapeHTML(message)}
        ${sub ? `<small>${escapeHTML(sub)}</small>` : ''}
    `;

    box.appendChild(el);

    setTimeout(() => {
        el.remove();
    }, 3200);
}


/* =========================================================
   7. MODAL HANDLER
========================================================= */

function openModal(id) {
    document.getElementById(id)?.classList.add('show');
}

function closeModal(id) {
    document.getElementById(id)?.classList.remove('show');
}

function bindModals() {
    document.querySelectorAll('[data-open-modal]').forEach(btn => {
        btn.addEventListener('click', () => {
            openModal(btn.dataset.openModal);
        });
    });

    document.querySelectorAll('[data-close-modal]').forEach(btn => {
        btn.addEventListener('click', () => {
            closeModal(btn.dataset.closeModal);
        });
    });

    document.querySelectorAll('.modal-overlay').forEach(overlay => {
        overlay.addEventListener('click', e => {
            if (e.target === overlay) {
                overlay.classList.remove('show');
            }
        });
    });

    document.addEventListener('keydown', e => {
        if (e.key === 'Escape') {
            document.querySelectorAll('.modal-overlay.show').forEach(modal => {
                modal.classList.remove('show');
            });
        }
    });
}


/* =========================================================
   8. TAB HANDLER
========================================================= */

function bindTabs() {
    document.querySelectorAll('.tab-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            activateTab(btn.dataset.tab);
        });
    });
}

function activateTab(tabId) {
    if (!tabId) return;

    document.querySelectorAll('.tab-btn').forEach(item => {
        item.classList.remove('active');
    });

    document.querySelectorAll('.tab-panel').forEach(panel => {
        panel.classList.remove('active');
    });

    document
        .querySelector(`.tab-btn[data-tab="${tabId}"]`)
        ?.classList.add('active');

    document.getElementById(tabId)?.classList.add('active');
}


/* =========================================================
   9. INVENTORY VALUE HELPERS
========================================================= */

function getItemSKU(item) {
    return String(item.SKU || item.sku || '').trim();
}

function getItemProductName(item) {
    return String(
        item.ProductName ||
        item.product_name ||
        item.name ||
        ''
    ).trim();
}

function getItemCategoryId(item) {
    return String(
        item.CategoryID ??
        item.category_id ??
        item.categoryId ??
        ''
    );
}

function getItemCategoryName(item) {
    return String(
        item.CategoryName ||
        item.category_name ||
        'Chưa phân loại'
    );
}

function getInventoryQuantity(item) {
    return Number(
        item.Quantity ??
        item.quantity ??
        0
    );
}

function getInventoryAllocatedQuantity(item) {
    return Number(
        item.AllocatedQuantity ??
        item.allocated_quantity ??
        0
    );
}

function getInventoryAvailableQuantity(item) {
    const quantity = getInventoryQuantity(item);
    const allocated = getInventoryAllocatedQuantity(item);

    return Number(
        item.AvailableQuantity ??
        item.available_quantity ??
        Math.max(quantity - allocated, 0)
    );
}

function getInventoryMinStockLevel(item) {
    return Number(
        item.MinStockLevel ??
        item.min_stock_level ??
        10
    );
}

function getInventoryBatchNumber(item) {
    return String(
        item.BatchNumber ||
        item.batch_number ||
        '-'
    );
}

function getInventoryManufacturerBatch(item) {
    return String(
        item.ManufacturerBatch ||
        item.manufacturer_batch ||
        '-'
    );
}

function getInventoryLocationRack(item) {
    return String(
        item.LocationRack ||
        item.location_rack ||
        '-'
    );
}

function getInventoryExpiryDate(item) {
    return item.ExpiryDate || item.expiry_date || null;
}


/* =========================================================
   10. INVENTORY STATUS
========================================================= */

function getStockStatus(item) {
    if (Number(item.HasInventory) === 0 || item.InventoryID === null) {
        return {
            code: 'NO_INVENTORY',
            text: 'Chưa nhập kho',
            color: 'orange'
        };
    }

    const qty = getInventoryAvailableQuantity(item);
    const min = getInventoryMinStockLevel(item);

    if (qty <= 0) {
        return {
            code: 'OUT_OF_STOCK',
            text: 'Hết hàng',
            color: 'red'
        };
    }

    if (qty > 0 && qty < min) {
        return {
            code: 'LOW_STOCK',
            text: 'Sắp hết',
            color: 'orange'
        };
    }

    return {
        code: 'AVAILABLE',
        text: 'Ổn định',
        color: 'green'
    };
}

function getGroupStockStatus(group) {
    const totalAvailable = Number(group.totalAvailable || 0);
    const totalMinStock = Number(group.totalMinStock || 0);

    if (totalAvailable <= 0) {
        return {
            code: 'OUT_OF_STOCK',
            text: 'Hết hàng',
            color: 'red'
        };
    }

    if (totalAvailable > 0 && totalAvailable < totalMinStock) {
        return {
            code: 'LOW_STOCK',
            text: 'Sắp hết',
            color: 'orange'
        };
    }

    return {
        code: 'AVAILABLE',
        text: 'Ổn định',
        color: 'green'
    };
}


/* =========================================================
   11. INVENTORY SORT
========================================================= */

function sortInventoryBySKU(rows = []) {
    return [...rows].sort((a, b) => {
        const skuA = getItemSKU(a).toLowerCase();
        const skuB = getItemSKU(b).toLowerCase();

        const skuCompare = skuA.localeCompare(skuB, 'vi');

        if (skuCompare !== 0) return skuCompare;

        const nameA = getItemProductName(a).toLowerCase();
        const nameB = getItemProductName(b).toLowerCase();

        const nameCompare = nameA.localeCompare(nameB, 'vi');

        if (nameCompare !== 0) return nameCompare;

        const dateA = getInventoryExpiryDate(a)
            ? new Date(getInventoryExpiryDate(a)).getTime()
            : Number.MAX_SAFE_INTEGER;

        const dateB = getInventoryExpiryDate(b)
            ? new Date(getInventoryExpiryDate(b)).getTime()
            : Number.MAX_SAFE_INTEGER;

        if (dateA !== dateB) return dateA - dateB;

        return getInventoryBatchNumber(a).localeCompare(
            getInventoryBatchNumber(b),
            'vi'
        );
    });
}


/* =========================================================
   12. INVENTORY FILTER
========================================================= */

function getFilteredInventory() {
    const sku = document.getElementById('filterSku')?.value.trim().toLowerCase() || '';
    const name = document.getElementById('filterProduct')?.value.trim().toLowerCase() || '';
    const categoryId = document.getElementById('filterCategory')?.value || '';

    const filtered = state.inventory.filter(item => {
        const itemSku = getItemSKU(item).toLowerCase();
        const itemName = getItemProductName(item).toLowerCase();
        const itemCategoryId = getItemCategoryId(item);

        return (
            (!sku || itemSku.includes(sku)) &&
            (!name || itemName.includes(name)) &&
            (!categoryId || itemCategoryId === categoryId)
        );
    });

    return sortInventoryBySKU(filtered);
}


/* =========================================================
   13. GROUP INVENTORY BY SKU
========================================================= */

function groupInventoryBySKU(rows = []) {
    const map = new Map();

    rows.forEach(item => {
        const sku = getItemSKU(item) || 'NO-SKU';

        if (!map.has(sku)) {
            map.set(sku, {
                sku,
                productName: getItemProductName(item) || '-',
                categoryName: getItemCategoryName(item),
                items: [],
                totalQuantity: 0,
                totalAvailable: 0,
                totalAllocated: 0,
                totalMinStock: 0
            });
        }

        const group = map.get(sku);

        group.items.push(item);
        group.totalQuantity += getInventoryQuantity(item);
        group.totalAvailable += getInventoryAvailableQuantity(item);
        group.totalAllocated += getInventoryAllocatedQuantity(item);
        group.totalMinStock += getInventoryMinStockLevel(item);
    });

    return [...map.values()].sort((a, b) => {
        return a.sku.toLowerCase().localeCompare(
            b.sku.toLowerCase(),
            'vi'
        );
    });
}


/* =========================================================
   14. INVENTORY PAGINATION
========================================================= */

function getPaginatedInventory(rows) {
    const start = (state.inventoryPage - 1) * state.inventoryPageSize;
    const end = start + state.inventoryPageSize;

    return rows.slice(start, end);
}

function renderInventoryPagination(totalRows) {
    const tableCard = document.querySelector('#inventoryTab .table-card');

    if (!tableCard) return;

    let container = document.getElementById('inventoryPagination');

    if (!container) {
        container = document.createElement('div');
        container.id = 'inventoryPagination';
        container.className = 'pagination';

        tableCard.appendChild(container);
    }

    const totalPages = Math.ceil(totalRows / state.inventoryPageSize);

    if (totalPages <= 1) {
        container.innerHTML = '';
        return;
    }

    const currentPage = state.inventoryPage;

    let startPage = Math.max(1, currentPage - 2);
    let endPage = Math.min(totalPages, startPage + 4);

    if (endPage - startPage < 4) {
        startPage = Math.max(1, endPage - 4);
    }

    let buttons = '';

    buttons += `
        <button 
            type="button"
            class="page-btn" 
            data-page="${currentPage - 1}"
            ${currentPage === 1 ? 'disabled' : ''}
        >
            <i class="fa-solid fa-angle-left"></i>
        </button>
    `;

    for (let page = startPage; page <= endPage; page++) {
        buttons += `
            <button 
                type="button"
                class="page-btn ${page === currentPage ? 'active' : ''}" 
                data-page="${page}"
            >
                ${page}
            </button>
        `;
    }

    buttons += `
        <button 
            type="button"
            class="page-btn" 
            data-page="${currentPage + 1}"
            ${currentPage === totalPages ? 'disabled' : ''}
        >
            <i class="fa-solid fa-angle-right"></i>
        </button>
    `;

    container.innerHTML = `
        <div class="pagination-info">
            Trang ${currentPage}/${totalPages}
        </div>

        <div class="pagination-buttons">
            ${buttons}
        </div>
    `;

    container.querySelectorAll('.page-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            const page = Number(btn.dataset.page);

            if (!page || page < 1 || page > totalPages) return;

            state.inventoryPage = page;
            renderInventory();
        });
    });
}


/* =========================================================
   15. RENDER INVENTORY TABLE
========================================================= */

function renderInventory() {
    const body = document.getElementById('inventoryTableBody');
    const count = document.getElementById('inventoryCount');

    if (!body) return;

    const stockStatus = document.getElementById('filterStockStatus')?.value || '';

    const filteredRows = getFilteredInventory();

    let groupedRows = groupInventoryBySKU(filteredRows);

    if (stockStatus) {
        groupedRows = groupedRows.filter(group => {
            const status = getGroupStockStatus(group);
            return status.code === stockStatus;
        });
    }

    const rows = getPaginatedInventory(groupedRows);

    if (count) {
        count.textContent =
            `Hiển thị: ${rows.length}/${groupedRows.length} SKU`;
    }

    if (!groupedRows.length) {
        body.innerHTML = `
            <tr>
                <td colspan="9" class="empty-cell">
                    Không có dữ liệu tồn kho
                </td>
            </tr>
        `;

        renderInventoryPagination(0);
        return;
    }

    body.innerHTML = rows.map((group, index) => {
        const realIndex =
            (state.inventoryPage - 1) * state.inventoryPageSize + index + 1;

        const status = getGroupStockStatus(group);

        return `
            <tr 
                class="inventory-row"
                data-sku="${escapeHTML(group.sku)}"
            >
                <td>${String(realIndex).padStart(2, '0')}</td>

                <td class="sku">
                    <b>${escapeHTML(group.sku)}</b>
                </td>

                <td>
                    <b>${escapeHTML(group.productName)}</b>
                </td>

                <td>
                    <span class="badge">
                        ${escapeHTML(group.categoryName)}
                    </span>
                </td>

                <td>
                    <b>${formatNumber(group.totalAvailable)}</b>
                </td>

                <td>
                    <span class="status-dot ${status.color}"></span>
                    ${escapeHTML(status.text)}
                </td>
            </tr>
        `;
    }).join('');

    renderInventoryPagination(groupedRows.length);
}


/* =========================================================
   16. INVENTORY DETAIL MODAL
========================================================= */

function getInventoryItemsBySKU(sku) {
    return state.inventory
        .filter(item => getItemSKU(item) === sku)
        .sort((a, b) => {
            const dateA = getInventoryExpiryDate(a)
                ? new Date(getInventoryExpiryDate(a)).getTime()
                : Number.MAX_SAFE_INTEGER;

            const dateB = getInventoryExpiryDate(b)
                ? new Date(getInventoryExpiryDate(b)).getTime()
                : Number.MAX_SAFE_INTEGER;

            if (dateA !== dateB) return dateA - dateB;

            return getInventoryBatchNumber(a).localeCompare(
                getInventoryBatchNumber(b),
                'vi'
            );
        });
}

function openInventoryDetailModalBySKU(sku) {
    const items = getInventoryItemsBySKU(sku);

    if (!items.length) {
        showToast('Không tìm thấy chi tiết tồn kho theo SKU', 'error');
        return;
    }

    const firstItem = items[0];

    const productName = getItemProductName(firstItem) || '-';
    const categoryName = getItemCategoryName(firstItem);

    const totalQuantity = items.reduce((sum, item) => {
        return sum + getInventoryQuantity(item);
    }, 0);

    const totalAvailable = items.reduce((sum, item) => {
        return sum + getInventoryAvailableQuantity(item);
    }, 0);

    const totalAllocated = items.reduce((sum, item) => {
        return sum + getInventoryAllocatedQuantity(item);
    }, 0);

    const totalMinStock = items.reduce((sum, item) => {
        return sum + getInventoryMinStockLevel(item);
    }, 0);

    const groupStatus = getGroupStockStatus({
        items,
        totalAvailable,
        totalMinStock
    });

    const setText = (id, value) => {
        const el = document.getElementById(id);
        if (el) el.textContent = value;
    };

    setText('detailSku', sku);
    setText('detailProductName', productName);
    setText('detailCategory', categoryName);
    setText('detailStockStatus', groupStatus.text);

    setText('detailQuantity', formatNumber(totalQuantity));
    setText('detailAvailableQuantity', formatNumber(totalAvailable));
    setText('detailAllocatedQuantity', formatNumber(totalAllocated));
    setText('detailMinStockLevel', formatNumber(totalMinStock));

    const subtitle = document.getElementById('inventoryDetailSubtitle');

    if (subtitle) {
        subtitle.textContent = `${sku} - ${productName}`;
    }

    renderInventoryBatchDetails(items);

    openModal('inventoryDetailModal');
}

function renderInventoryBatchDetails(items = []) {
    const body = document.getElementById('inventoryBatchDetailBody');
    const count = document.getElementById('detailBatchCount');

    if (!body) return;

    if (count) {
        count.textContent = `${items.length} batch/lô thuộc SKU này`;
    }

    if (!items.length) {
        body.innerHTML = `
            <tr>
                <td colspan="9" class="empty-cell">
                    Không có dữ liệu batch/lô
                </td>
            </tr>
        `;
        return;
    }

    body.innerHTML = items.map((item, index) => {
        const status = getStockStatus(item);

        return `
            <tr>
                <td>${String(index + 1).padStart(2, '0')}</td>

                <td>
                    <b>${escapeHTML(getInventoryBatchNumber(item))}</b>
                </td>

                <td>
                    ${escapeHTML(getInventoryLocationRack(item))}
                </td>

                <td>
                    <b>${formatNumber(getInventoryQuantity(item))}</b>
                </td>

                <td>
                    <b>${formatNumber(getInventoryAvailableQuantity(item))}</b>
                </td>

                <td>
                    ${formatDate(getInventoryExpiryDate(item))}
                </td>

                <td>
                    <span class="status-dot ${status.color}"></span>
                    ${escapeHTML(status.text)}
                </td>
            </tr>
        `;
    }).join('');
}

function bindInventoryRowClick() {
    document.addEventListener('click', e => {
        const row = e.target.closest('.inventory-row');

        if (!row) return;

        const sku = row.dataset.sku;

        openInventoryDetailModalBySKU(sku);
    });
}


/* =========================================================
   17. SUPPLIERS RENDER
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

    body.innerHTML = state.suppliers.map((supplier, index) => `
        <tr>
            <td>${String(index + 1).padStart(2, '0')}</td>

            <td>
                <b>${escapeHTML(supplier.supplier_name || '-')}</b>
                <br>
                <small>${escapeHTML(supplier.address || '')}</small>
            </td>

            <td>${escapeHTML(supplier.contact_name || '-')}</td>
            <td>${escapeHTML(supplier.phone_number || '-')}</td>
            <td>${escapeHTML(supplier.email || '-')}</td>
            <td>${escapeHTML(supplier.tax_code || '-')}</td>

            <td>
                <span class="badge ${supplier.status === 'INACTIVE' ? 'red' : ''}">
                    ${escapeHTML(supplier.status || 'ACTIVE')}
                </span>
            </td>
        </tr>
    `).join('');
}


/* =========================================================
   18. SUPPLIER SELECTS
========================================================= */

function fillSupplierSelects() {
    const filterSupplier = document.getElementById('filterSupplier');
    const poSupplierSelect = document.getElementById('poSupplierSelect');

    const activeSuppliers = state.suppliers.filter(s => {
        return (s.status || 'ACTIVE') === 'ACTIVE';
    });

    if (filterSupplier) {
        filterSupplier.innerHTML = `
            <option value="">Tất cả nhà cung cấp</option>
            ${state.suppliers.map(s => `
                <option value="${s.supplier_id}">
                    ${escapeHTML(s.supplier_name)}
                </option>
            `).join('')}
        `;
    }

    if (poSupplierSelect) {
        poSupplierSelect.innerHTML = `
            <option value="">Chọn nhà cung cấp</option>
            ${activeSuppliers.map(s => `
                <option value="${s.supplier_id}">
                    ${escapeHTML(s.supplier_name)}
                </option>
            `).join('')}
        `;
    }
}


/* =========================================================
   19. PRODUCT META
========================================================= */

function fillProductMeta() {
    const categorySelect = document.getElementById('productCategorySelect');
    const unitSelect = document.getElementById('productUnitSelect');
    const filterCategorySelect = document.getElementById('filterCategory');

    const categoryOptions = state.categories.map(category => {
        const id =
            category.CategoryID ??
            category.category_id ??
            category.id;

        const name =
            category.CategoryName ??
            category.category_name ??
            category.name ??
            'Không tên';

        return `
            <option value="${id}">
                ${escapeHTML(name)}
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
            ${state.units.map(unit => {
                const id =
                    unit.PUnitID ??
                    unit.UnitID ??
                    unit.unit_id ??
                    unit.id;

                const name =
                    unit.Name ??
                    unit.UnitName ??
                    unit.name ??
                    'Không tên';

                return `
                    <option value="${id}">
                        ${escapeHTML(name)}
                    </option>
                `;
            }).join('')}
        `;
    }
}


/* =========================================================
   20. PO PRODUCT SELECT
========================================================= */

function getProductId(product) {
    return Number(
        product.ProductID ??
        product.product_id ??
        product.productId ??
        product.id ??
        0
    );
}

function getProductPrice(product) {
    return Number(
        product.Price ??
        product.price ??
        product.UnitPrice ??
        product.unit_price ??
        product.SellingPrice ??
        product.selling_price ??
        0
    );
}

function fillPOProductSelect(select) {
    if (!select) return;

    const sortedProducts = [...state.products].sort((a, b) => {
        const skuA = String(a.SKU || a.sku || '').toLowerCase();
        const skuB = String(b.SKU || b.sku || '').toLowerCase();

        return skuA.localeCompare(skuB, 'vi');
    });

    const productOptions = sortedProducts.map(product => {
        const id = getProductId(product);

        const sku =
            product.SKU ??
            product.sku ??
            'NO-SKU';

        const name =
            product.ProductName ??
            product.product_name ??
            product.name;

        if (!id || !name) return '';

        return `
            <option value="${id}">
                ${escapeHTML(sku)} - ${escapeHTML(name)}
            </option>
        `;
    }).join('');

    select.innerHTML = `
        <option value="">Chọn sản phẩm theo SKU</option>
        ${productOptions}
    `;
}


/* =========================================================
   20.1. PRODUCT MANAGER DASHBOARD -> PURCHASE ORDER
========================================================= */

function getIncomingProductId(item) {
    return Number(
        item.ProductID ??
        item.product_id ??
        item.productId ??
        item.id ??
        0
    );
}

function getIncomingSuggestedQuantity(item) {
    return Number(
        item.suggested_quantity ??
        item.suggestedQuantity ??
        item.quantity ??
        item.ordered_quantity ??
        10
    );
}

function findProductByIncomingItem(item) {
    const incomingId = getIncomingProductId(item);

    if (!incomingId) return null;

    return state.products.find(product => {
        return getProductId(product) === incomingId;
    }) || null;
}

function addPOLineWithProduct(product, quantity = 1, unitPrice = 0) {
    const wrap = document.getElementById('poLines');
    const template = document.getElementById('poLineTemplate');

    if (!wrap || !template || !product) {
        console.warn('Thiếu #poLines hoặc #poLineTemplate hoặc product');
        return false;
    }

    const productId = getProductId(product);

    if (!productId) return false;

    const node = template.content.cloneNode(true);

    const select = node.querySelector('.line-product');
    const quantityInput = node.querySelector('.line-quantity');
    const priceInput = node.querySelector('.line-price');

    fillPOProductSelect(select);

    if (select) {
        select.value = String(productId);
    }

    if (quantityInput) {
        quantityInput.value = Math.max(Number(quantity || 1), 1);
    }

    if (priceInput) {
        priceInput.value = Math.max(Number(unitPrice || 0), 0);
    }

    node.querySelector('.line-remove')?.addEventListener('click', e => {
        e.currentTarget.closest('.receipt-line')?.remove();
    });

    wrap.appendChild(node);

    return true;
}

function loadProductsFromProductManagerDashboard() {
    const localRaw = localStorage.getItem(PM_OUT_OF_STOCK_STORAGE_KEY);
    const sessionRaw = sessionStorage.getItem(PM_OUT_OF_STOCK_STORAGE_KEY);
    const raw = localRaw || sessionRaw;

    console.log('RAW OUT OF STOCK PRODUCTS FROM STORAGE:', raw);

    if (!raw) return false;

    let incomingProducts = [];

    try {
        incomingProducts = JSON.parse(raw);
    } catch (err) {
        console.error('Parse selected out-of-stock products error:', err);
        incomingProducts = [];
    }

    if (!Array.isArray(incomingProducts) || !incomingProducts.length) {
        localStorage.removeItem(PM_OUT_OF_STOCK_STORAGE_KEY);
        sessionStorage.removeItem(PM_OUT_OF_STOCK_STORAGE_KEY);
        return false;
    }

    console.log('PRODUCTS FROM PRODUCT MANAGER DASHBOARD:', incomingProducts);
    console.log('CURRENT PRODUCTS:', state.products);

    clearPOLines();

    let addedCount = 0;

    incomingProducts.forEach(item => {
        const product = findProductByIncomingItem(item);

        if (!product) {
            console.warn('Không tìm thấy sản phẩm trong state.products:', item);
            return;
        }

        const suggestedQuantity = getIncomingSuggestedQuantity(item);
        const unitPrice = getProductPrice(product);

        const added = addPOLineWithProduct(
            product,
            suggestedQuantity,
            unitPrice
        );

        if (added) addedCount += 1;
    });

    if (!addedCount) {
        addPOLine();

        showToast(
            'Không tự thêm được sản phẩm vào phiếu đặt hàng',
            'error',
            'Kiểm tra ProductID giữa dashboard và /api/products'
        );

        localStorage.removeItem(PM_OUT_OF_STOCK_STORAGE_KEY);
        sessionStorage.removeItem(PM_OUT_OF_STOCK_STORAGE_KEY);

        return false;
    }

    activateTab('purchaseOrderTab');

    openModal('purchaseOrderModal');

    showToast(
        `Đã thêm ${addedCount} sản phẩm hết hàng vào phiếu đặt hàng`,
        'success',
        'Vui lòng chọn nhà cung cấp rồi bấm tạo phiếu'
    );

    localStorage.removeItem(PM_OUT_OF_STOCK_STORAGE_KEY);
    sessionStorage.removeItem(PM_OUT_OF_STOCK_STORAGE_KEY);

    return true;
}


/* =========================================================
   21. PURCHASE ORDER LINES
========================================================= */

function addPOLine() {
    const wrap = document.getElementById('poLines');
    const template = document.getElementById('poLineTemplate');

    if (!wrap || !template) return;

    const node = template.content.cloneNode(true);
    const select = node.querySelector('.line-product');

    fillPOProductSelect(select);

    node.querySelector('.line-remove')?.addEventListener('click', e => {
        e.currentTarget.closest('.receipt-line')?.remove();
    });

    wrap.appendChild(node);
}

function clearPOLines() {
    const wrap = document.getElementById('poLines');

    if (wrap) {
        wrap.innerHTML = '';
    }
}

function collectPOItems() {
    return [...document.querySelectorAll('#poLines .receipt-line')]
        .map(line => ({
            product_id: Number(line.querySelector('.line-product')?.value),
            ordered_quantity: Number(line.querySelector('.line-quantity')?.value || 0),
            unit_price: Number(line.querySelector('.line-price')?.value || 0)
        }))
        .filter(item => {
            return item.product_id && item.ordered_quantity > 0;
        });
}


/* =========================================================
   22. PURCHASE ORDERS RENDER
========================================================= */

function getPOStatusText(status) {
    const map = {
        CREATED: 'Đã tạo',
        ORDERED: 'Đã đặt hàng',
        SENT: 'Đã gửi NCC',
        PARTIAL_RECEIVED: 'Nhận một phần',
        PARTIALLY_RECEIVED: 'Nhận một phần',
        RECEIVED: 'Đã nhận đủ',
        COMPLETED: 'Hoàn tất',
        CANCELLED: 'Đã hủy'
    };

    return map[status] || status || 'Không rõ';
}

function getEmailStatusText(status) {
    const map = {
        NOT_SENT: 'Chưa gửi',
        SENT: 'Đã gửi',
        FAILED: 'Gửi lỗi'
    };

    return map[status] || status || 'Không rõ';
}

function renderPurchaseOrders() {
    const body = document.getElementById('purchaseOrderTableBody');
    const count = document.getElementById('purchaseOrderCount');

    if (!body) return;

    if (count) {
        count.textContent = `Tổng: ${state.purchaseOrders.length} phiếu đặt hàng`;
    }

    if (!state.purchaseOrders.length) {
        body.innerHTML = `
            <tr>
                <td colspan="8" class="empty-cell">
                    Chưa có phiếu đặt hàng
                </td>
            </tr>
        `;
        return;
    }

    body.innerHTML = state.purchaseOrders.map((po, index) => {
        const totalAmount =
            po.total_amount ??
            po.totalAmount ??
            po.TotalAmount ??
            0;

        const poCode =
            po.po_code ||
            po.POCode ||
            `PO-${po.purchase_order_id || ''}`;

        return `
            <tr>
                <td>${String(index + 1).padStart(2, '0')}</td>

                <td>
                    <b>${escapeHTML(poCode)}</b>
                </td>

                <td>
                    ${escapeHTML(po.supplier_name || '-')}
                </td>

                <td>
                    ${formatDateTime(po.created_at || po.createdAt)}
                </td>

                <td>
                    ${formatDate(po.expected_delivery_date || po.expectedDeliveryDate)}
                </td>

                <td>
                    <b>${formatCurrency(totalAmount)}</b>
                </td>

                <td>
                    ${escapeHTML(getEmailStatusText(po.email_status || po.emailStatus || 'NOT_SENT'))}
                </td>

                <td>
                    <span class="badge">
                        ${escapeHTML(getPOStatusText(po.status))}
                    </span>
                </td>
            </tr>
        `;
    }).join('');
}


/* =========================================================
   23. LOAD DATA
========================================================= */

async function loadInventory() {
    try {
        const data = await request(API.inventory);
        state.inventory = normalizeList(data);
        state.inventoryPage = 1;
    } catch (err) {
        state.inventory = [];
        showToast('Không tải được tồn kho', 'error', err.message);
    }

    renderInventory();
}

async function loadSuppliers() {
    try {
        const data = await request(API.suppliers);
        state.suppliers = normalizeList(data);
    } catch (err) {
        state.suppliers = [];
        showToast('Không tải được nhà cung cấp', 'error', err.message);
    }

    renderSuppliers();
    fillSupplierSelects();
}

async function loadProducts() {
    try {
        const data = await request(`${API.products}?limit=500`);
        state.products = normalizeList(data);
    } catch (err) {
        state.products = [];
        showToast('Không tải được sản phẩm', 'error', err.message);
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
        showToast('Không tải được danh mục / đơn vị', 'error', err.message);
    }
}

async function loadPurchaseOrders() {
    try {
        const data = await request(API.purchaseOrders);
        state.purchaseOrders = normalizeList(data);
    } catch (err) {
        state.purchaseOrders = [];
        showToast('Không tải được phiếu đặt hàng', 'error', err.message);
    }

    renderPurchaseOrders();
}


/* =========================================================
   24. SUPPLIER FORM
========================================================= */

function bindSupplierForm() {
    const form = document.getElementById('supplierForm');

    if (!form) return;

    form.addEventListener('submit', async e => {
        e.preventDefault();

        try {
            const payload = formToObject(form);

            payload.supplier_name = payload.supplier_name?.trim();
            payload.contact_name = payload.contact_name?.trim() || null;
            payload.phone_number = payload.phone_number?.trim() || null;
            payload.email = payload.email?.trim() || null;
            payload.tax_code = payload.tax_code?.trim() || null;
            payload.address = payload.address?.trim() || null;
            payload.status = payload.status || 'ACTIVE';

            if (!payload.supplier_name) {
                throw new Error('Tên nhà cung cấp không được để trống');
            }

            await request(API.suppliers, {
                method: 'POST',
                body: JSON.stringify(payload)
            });

            showToast('Tạo nhà cung cấp thành công');

            form.reset();
            closeModal('supplierModal');

            await loadSuppliers();
        } catch (err) {
            showToast('Tạo nhà cung cấp thất bại', 'error', err.message);
        }
    });
}


/* =========================================================
   25. PRODUCT FORM
========================================================= */

function bindProductForm() {
    const form = document.getElementById('productForm');

    if (!form) return;

    form.addEventListener('submit', async e => {
        e.preventDefault();

        try {
            const payload = formToObject(form);

            payload.ProductName = payload.ProductName?.trim();
            payload.Price = Number(payload.Price || 0);
            payload.CategoryID = Number(payload.CategoryID);
            payload.UnitID = Number(payload.UnitID);
            payload.StatusID = Number(payload.StatusID || 1);
            payload.Brand = payload.Brand?.trim() || null;
            payload.Description = payload.Description?.trim() || null;
            payload.TechnicalContent = payload.TechnicalContent?.trim() || null;
            payload.UsageInstructions = payload.UsageInstructions?.trim() || null;

            if (!payload.ProductName) {
                throw new Error('Tên sản phẩm không được để trống');
            }

            if (!payload.CategoryID) {
                throw new Error('Vui lòng chọn danh mục');
            }

            if (!payload.UnitID) {
                throw new Error('Vui lòng chọn đơn vị');
            }

            await request(API.products, {
                method: 'POST',
                body: JSON.stringify(payload)
            });

            showToast('Tạo sản phẩm thành công');

            form.reset();
            closeModal('productModal');

            await Promise.all([
                loadProducts(),
                loadInventory()
            ]);
        } catch (err) {
            showToast('Tạo sản phẩm thất bại', 'error', err.message);
        }
    });
}


/* =========================================================
   26. PURCHASE ORDER FORM
========================================================= */

function bindPurchaseOrderForm() {
    const form = document.getElementById('purchaseOrderForm');
    const btnAdd = document.getElementById('btnAddPOLine');

    btnAdd?.addEventListener('click', addPOLine);

    if (!form) return;

    form.addEventListener('submit', async e => {
        e.preventDefault();

        try {
            const base = formToObject(form);

            const supplierId = Number(base.supplier_id);
            const items = collectPOItems();

            if (!supplierId) {
                throw new Error('Vui lòng chọn nhà cung cấp');
            }

            if (!items.length) {
                throw new Error('Phiếu đặt hàng cần ít nhất 1 dòng sản phẩm');
            }

            const payload = {
                supplier_id: supplierId,
                expected_delivery_date: base.expected_delivery_date || null,
                note: base.note?.trim() || null,
                items
            };

            await request(API.purchaseOrders, {
                method: 'POST',
                body: JSON.stringify(payload)
            });

            showToast(
                'Tạo phiếu đặt hàng thành công',
                'success',
                'Nếu mail đã cấu hình, nhà cung cấp sẽ nhận được thông báo'
            );

            form.reset();
            clearPOLines();
            addPOLine();

            closeModal('purchaseOrderModal');

            await loadPurchaseOrders();
        } catch (err) {
            showToast('Tạo phiếu đặt hàng thất bại', 'error', err.message);
        }
    });
}


/* =========================================================
   27. FILTERS
========================================================= */

function bindFilters() {
    const resetAndRender = () => {
        state.inventoryPage = 1;
        renderInventory();
    };

    document
        .getElementById('btnApplyFilter')
        ?.addEventListener('click', resetAndRender);

    ['filterSku', 'filterProduct'].forEach(id => {
        document
            .getElementById(id)
            ?.addEventListener('input', resetAndRender);
    });

    ['filterCategory', 'filterStockStatus', 'filterSupplier'].forEach(id => {
        document
            .getElementById(id)
            ?.addEventListener('change', resetAndRender);
    });
}


/* =========================================================
   28. INIT DATA
========================================================= */

async function initData() {
    await Promise.all([
        loadInventory(),
        loadSuppliers(),
        loadProducts(),
        loadProductMeta(),
        loadPurchaseOrders()
    ]);

    const loadedFromDashboard = loadProductsFromProductManagerDashboard();

    if (loadedFromDashboard) {
        return;
    }

    const poLines = document.getElementById('poLines');

    if (poLines && !poLines.children.length) {
        addPOLine();
    }
}


/* =========================================================
   29. PAGE INIT
========================================================= */

document.addEventListener('DOMContentLoaded', () => {
    bindModals();
    bindTabs();

    bindSupplierForm();
    bindProductForm();
    bindPurchaseOrderForm();

    bindFilters();
    bindInventoryRowClick();

    initData();
});