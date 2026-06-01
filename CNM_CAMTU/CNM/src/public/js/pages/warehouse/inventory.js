/* =========================================================
   INVENTORY MANAGER JS

   Chức năng:
   - Load danh sách tồn kho từ /api/inventory
   - Load sản phẩm từ /api/products?limit=500 để map ProductID -> CategoryID/SKU/Unit
   - Load danh mục từ /api/products/categories
   - Lọc theo:
     + Từ khóa sản phẩm / SKU / ID
     + Danh mục
     + Trạng thái tồn kho
   - Nút Log: xem lịch sử nhập/xuất kho theo sản phẩm
   - Nút Kệ: xem vị trí kệ/lô hàng theo sản phẩm
   - Sort bảng theo header .sortable
========================================================= */


/* =========================================================
   GLOBAL STATE
========================================================= */

let allInventoryItems = [];
let currentFilteredItems = [];

let productCategoryMap = {};
let productCategoryNameMap = {};
let productInfoMap = {};

let categoryData = [];

let currentLogProductId = null;
let currentLogProductInfo = null;


/* =========================================================
   DOM READY
========================================================= */

document.addEventListener('DOMContentLoaded', async () => {
    await initInventoryPage();
});


async function initInventoryPage() {
    bindFilterEvents();
    bindModalEvents();
    bindTableSortEvents();
    bindInventoryLogFilterEvents();

    await loadInventory();
}


/* =========================================================
   COMMON HELPERS
========================================================= */

function normalizeList(payload) {
    if (Array.isArray(payload)) return payload;

    if (Array.isArray(payload?.data)) return payload.data;
    if (Array.isArray(payload?.items)) return payload.items;
    if (Array.isArray(payload?.rows)) return payload.rows;
    if (Array.isArray(payload?.products)) return payload.products;
    if (Array.isArray(payload?.categories)) return payload.categories;

    if (Array.isArray(payload?.data?.items)) return payload.data.items;
    if (Array.isArray(payload?.data?.rows)) return payload.data.rows;
    if (Array.isArray(payload?.data?.products)) return payload.data.products;
    if (Array.isArray(payload?.data?.categories)) return payload.data.categories;
    if (Array.isArray(payload?.data?.data)) return payload.data.data;

    if (Array.isArray(payload?.result)) return payload.result;
    if (Array.isArray(payload?.results)) return payload.results;

    return [];
}

function escapeHTML(value) {
    return String(value ?? '')
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#039;');
}

function normalizeText(value) {
    return String(value ?? '').trim().toLowerCase();
}

function normalizeId(value) {
    return String(value ?? '').trim();
}

function toNumber(value) {
    const number = Number(value ?? 0);
    return Number.isNaN(number) ? 0 : number;
}

async function fetchJSON(url, options = {}) {
    const res = await fetch(url, {
        credentials: 'include',
        ...options,
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

async function fetchJSONFallback(urls, options = {}) {
    let lastError = null;

    for (const url of urls) {
        try {
            return await fetchJSON(url, options);
        } catch (err) {
            lastError = err;
            console.warn(`Không gọi được API: ${url}`, err);
        }
    }

    throw lastError || new Error('Không gọi được API');
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

function buildQueryString(params = {}) {
    const searchParams = new URLSearchParams();

    Object.entries(params).forEach(([key, value]) => {
        if (
            value !== undefined &&
            value !== null &&
            value !== '' &&
            value !== 'all'
        ) {
            searchParams.append(key, value);
        }
    });

    const query = searchParams.toString();

    return query ? `?${query}` : '';
}


/* =========================================================
   INVENTORY FIELD HELPERS
========================================================= */

function getInventoryProductId(item) {
    return (
        item.ProductID ??
        item.product_id ??
        item.productId ??
        item.productid ??
        item.id ??
        ''
    );
}

function getProductInfoByInventoryItem(item) {
    const productId = normalizeId(getInventoryProductId(item));
    return productInfoMap[productId] || {};
}

function getInventoryProductName(item) {
    const info = getProductInfoByInventoryItem(item);

    return (
        item.ProductName ??
        item.product_name ??
        item.productName ??
        item.name ??
        info.name ??
        info.product_name ??
        '---'
    );
}

function getInventorySku(item) {
    const info = getProductInfoByInventoryItem(item);

    return (
        item.SKU ??
        item.sku ??
        item.Sku ??
        info.sku ??
        info.SKU ??
        ''
    );
}

function getInventoryUnitName(item) {
    const info = getProductInfoByInventoryItem(item);

    return (
        item.UnitName ??
        item.unit_name ??
        item.unitName ??
        item.unit?.name ??
        item.unit?.Name ??
        info.unit_name ??
        info.unitName ??
        info.unit?.name ??
        '-'
    );
}

function getInventoryRack(item) {
    return (
        item.LocationRacks ??
        item.LocationRack ??
        item.locationRacks ??
        item.locationRack ??
        item.location_rack ??
        item.locationrack ??
        '---'
    );
}

function getInventoryQuantity(item) {
    return toNumber(
        item.TotalPhysicalQty ??
        item.total_physical_qty ??
        item.totalphysicalqty ??
        item.totalPhysicalQty ??
        item.total_quantity ??
        item.totalQuantity ??
        item.Quantity ??
        item.quantity ??
        0
    );
}

function getInventoryAllocated(item) {
    return toNumber(
        item.TotalAllocatedQty ??
        item.total_allocated_qty ??
        item.totalallocatedqty ??
        item.totalAllocatedQty ??
        item.allocated_quantity ??
        item.allocatedQuantity ??
        item.AllocatedQuantity ??
        0
    );
}

function getInventoryAvailable(item) {
    const explicitValue =
        item.TotalAvailableQty ??
        item.total_available_qty ??
        item.totalavailableqty ??
        item.totalAvailableQty ??
        item.available_quantity ??
        item.availableQuantity ??
        item.AvailableQuantity;

    if (
        explicitValue !== undefined &&
        explicitValue !== null &&
        explicitValue !== ''
    ) {
        return toNumber(explicitValue);
    }

    return getInventoryQuantity(item) - getInventoryAllocated(item);
}

function getInventoryMinStock(item) {
    return toNumber(
        item.MinStockLevel ??
        item.minstocklevel ??
        item.minStockLevel ??
        item.min_stock_level ??
        0
    );
}

function getInventoryTotalBatches(item) {
    return toNumber(
        item.TotalBatches ??
        item.total_batches ??
        item.totalBatches ??
        item.batch_count ??
        item.batchCount ??
        item.total_lots ??
        item.totalLots ??
        0
    );
}

function getInventoryCategoryId(item) {
    const info = getProductInfoByInventoryItem(item);

    const directCategoryId =
        item.CategoryID ??
        item.CategoryId ??
        item.category_id ??
        item.categoryId ??
        item.category?.id ??
        item.category?.CategoryID ??
        item.category?.category_id ??
        info.category_id ??
        info.categoryId ??
        info.category?.id ??
        info.category?.CategoryID;

    if (
        directCategoryId !== undefined &&
        directCategoryId !== null &&
        directCategoryId !== ''
    ) {
        return normalizeId(directCategoryId);
    }

    const productId = normalizeId(getInventoryProductId(item));

    return productCategoryMap[productId] || '';
}

function getInventoryCategoryName(item) {
    const info = getProductInfoByInventoryItem(item);

    const directCategoryName =
        item.CategoryName ??
        item.category_name ??
        item.categoryName ??
        item.category?.name ??
        item.category?.CategoryName ??
        info.category_name ??
        info.categoryName ??
        info.category?.name ??
        info.category?.CategoryName;

    if (directCategoryName) {
        return directCategoryName;
    }

    const categoryId = getInventoryCategoryId(item);

    return productCategoryNameMap[categoryId] || 'Chưa phân loại';
}


/* =========================================================
   STOCK STATUS
========================================================= */

function getStockStatusInfo(quantity, minStock) {
    const qty = toNumber(quantity);
    const min = toNumber(minStock);

    if (qty <= 0) {
        return {
            code: 'OUT_OF_STOCK',
            text: 'Hết hàng',
            className: 'out-of-stock'
        };
    }

    if (min > 0 && qty <= min) {
        return {
            code: 'LOW_STOCK',
            text: 'Sắp hết',
            className: 'low-stock'
        };
    }

    return {
        code: 'NORMAL',
        text: 'Bình thường',
        className: 'normal'
    };
}

function normalizeStatusFilter(value) {
    const raw = String(value ?? '').trim();

    const map = {
        all: 'all',
        ALL: 'all',
        '': 'all',

        OUT_OF_STOCK: 'OUT_OF_STOCK',
        LOW_STOCK: 'LOW_STOCK',
        NORMAL: 'NORMAL',

        OUT: 'OUT_OF_STOCK',
        LOW: 'LOW_STOCK',
        AVAILABLE: 'NORMAL',
        IN_STOCK: 'NORMAL',

        'Hết hàng': 'OUT_OF_STOCK',
        'Sắp hết': 'LOW_STOCK',
        'Bình thường': 'NORMAL'
    };

    return map[raw] || raw;
}


/* =========================================================
   LOAD INVENTORY
========================================================= */

async function loadInventory() {
    try {
        renderTableLoading();

        const result = await fetchJSON('/api/inventory');

        console.log('API inventory:', result);

        const rows = normalizeList(result);

        if (!Array.isArray(rows)) {
            console.error('Inventory data không phải array:', rows);
            allInventoryItems = [];
            currentFilteredItems = [];
            renderTable([]);
            return;
        }

        allInventoryItems = rows;

        await Promise.all([
            loadProductCategoryMap(),
            loadCategoryOptions()
        ]);

        filterInventory();

    } catch (err) {
        console.error('Lỗi load inventory:', err);
        allInventoryItems = [];
        currentFilteredItems = [];
        renderTable([]);
    }
}


/* =========================================================
   LOAD PRODUCT CATEGORY MAP
========================================================= */

async function loadProductCategoryMap() {
    try {
        const result = await fetchJSON('/api/products?limit=500');

        const products = normalizeList(result);

        productCategoryMap = {};
        productCategoryNameMap = {};
        productInfoMap = {};

        products.forEach(product => {
            const productId = normalizeId(
                product.id ??
                product.ProductID ??
                product.product_id ??
                product.productId
            );

            const categoryId = normalizeId(
                product.category?.id ??
                product.category?.CategoryID ??
                product.category?.category_id ??
                product.CategoryID ??
                product.CategoryId ??
                product.category_id ??
                product.categoryId
            );

            const categoryName =
                product.category?.name ??
                product.category?.CategoryName ??
                product.category?.category_name ??
                product.CategoryName ??
                product.categoryName ??
                product.category_name ??
                '';

            const sku =
                product.sku ??
                product.SKU ??
                product.Sku ??
                '';

            const productName =
                product.name ??
                product.ProductName ??
                product.product_name ??
                product.productName ??
                '';

            const unitName =
                product.unit?.name ??
                product.unit?.Name ??
                product.UnitName ??
                product.unitName ??
                product.unit_name ??
                product.product_unit?.Name ??
                product.product_unit?.name ??
                '';

            if (productId) {
                productCategoryMap[productId] = categoryId;

                productInfoMap[productId] = {
                    ...product,
                    sku,
                    name: productName,
                    category_id: categoryId,
                    category_name: categoryName,
                    unit_name: unitName
                };
            }

            if (categoryId && categoryName) {
                productCategoryNameMap[categoryId] = categoryName;
            }
        });

        console.log('PRODUCT CATEGORY MAP:', productCategoryMap);
        console.log('CATEGORY NAME MAP:', productCategoryNameMap);
        console.log('PRODUCT INFO MAP:', productInfoMap);

    } catch (err) {
        console.error('Không thể tải map danh mục sản phẩm:', err);
        productCategoryMap = {};
        productCategoryNameMap = {};
        productInfoMap = {};
    }
}


/* =========================================================
   LOAD CATEGORY SELECT
========================================================= */

async function loadCategoryOptions() {
    const categoryFilter = document.getElementById('inventoryCategoryFilter');

    if (!categoryFilter) return;

    try {
        const result = await fetchJSON('/api/products/categories');

        categoryData = normalizeList(result);

        if (!categoryData.length) {
            return;
        }

        categoryFilter.innerHTML = `
            <option value="all">Tất cả danh mục</option>
            ${
                categoryData.map(category => {
                    const id = normalizeId(
                        category.id ??
                        category.CategoryID ??
                        category.category_id
                    );

                    const name =
                        category.name ??
                        category.CategoryName ??
                        category.category_name ??
                        'Không tên';

                    if (id && name) {
                        productCategoryNameMap[id] = name;
                    }

                    return `
                        <option value="${escapeHTML(id)}">
                            ${escapeHTML(name)}
                        </option>
                    `;
                }).join('')
            }
        `;

    } catch (err) {
        console.error('Không thể tải danh mục:', err);
    }
}


/* =========================================================
   RENDER TABLE
========================================================= */

function renderTableLoading() {
    const tbody = document.getElementById('inventoryTableBody');

    if (!tbody) return;

    tbody.innerHTML = `
        <tr>
            <td colspan="11" class="empty-cell">
                Đang tải dữ liệu tồn kho...
            </td>
        </tr>
    `;
}

function renderTable(items) {
    const tbody = document.getElementById('inventoryTableBody');

    if (!tbody) return;

    if (!Array.isArray(items) || !items.length) {
        tbody.innerHTML = `
            <tr>
                <td colspan="11" class="empty-cell">
                    Không có sản phẩm phù hợp
                </td>
            </tr>
        `;
        return;
    }

    tbody.innerHTML = '';

    items.forEach((item, index) => {
        const productId = getInventoryProductId(item);
        const sku = getInventorySku(item);
        const productName = getInventoryProductName(item);
        const categoryName = getInventoryCategoryName(item);
        const unitName = getInventoryUnitName(item);

        const quantity = getInventoryQuantity(item);
        const allocated = getInventoryAllocated(item);
        const available = getInventoryAvailable(item);
        const min = getInventoryMinStock(item);
        const totalBatches = getInventoryTotalBatches(item);

        const status = getStockStatusInfo(quantity, min);

        const tr = document.createElement('tr');
        tr.className = 'inventory-product-row';
        tr.dataset.productId = productId;

        tr.innerHTML = `
            <td>${index + 1}</td>

            <td>
                ${
                    sku
                        ? `<span class="product-sku">${escapeHTML(sku)}</span>`
                        : '<span class="muted-text">---</span>'
                }
            </td>

            <td>
                <b>${escapeHTML(productName)}</b>
            </td>

            <td>${escapeHTML(categoryName)}</td>

            <td>${escapeHTML(unitName)}</td>

            <td>${quantity}</td>

            <td>${allocated}</td>

            <td>${available}</td>

            <td>${totalBatches}</td>

            <td>
                <span class="stock-badge stock-badge--${status.className}">
                    ${escapeHTML(status.text)}
                </span>
            </td>

            <td class="action-cell">
                <button
                    type="button"
                    class="table-action-btn log-btn"
                    data-action="log"
                    data-product-id="${escapeHTML(productId)}"
                    data-product-name="${escapeHTML(productName)}"
                    data-sku="${escapeHTML(sku)}"
                >
                    <i class="fa-solid fa-clock-rotate-left"></i>
                    Log
                </button>

                <button
                    type="button"
                    class="table-action-btn rack-btn"
                    data-action="rack"
                    data-product-id="${escapeHTML(productId)}"
                    data-product-name="${escapeHTML(productName)}"
                    data-sku="${escapeHTML(sku)}"
                >
                    <i class="fa-solid fa-location-dot"></i>
                    Kệ
                </button>
            </td>
        `;

        tbody.appendChild(tr);
    });

    bindTableActionEvents();
}

function bindTableActionEvents() {
    const tbody = document.getElementById('inventoryTableBody');

    if (!tbody) return;

    tbody.querySelectorAll('.log-btn').forEach(button => {
        button.addEventListener('click', async e => {
            e.stopPropagation();

            const productId = button.dataset.productId;
            const productName = button.dataset.productName;
            const sku = button.dataset.sku;

            if (!productId) {
                alert('Không tìm thấy ID sản phẩm');
                return;
            }

            await openInventoryLogModal(productId, {
                productName,
                sku
            });
        });
    });

    tbody.querySelectorAll('.rack-btn').forEach(button => {
        button.addEventListener('click', async e => {
            e.stopPropagation();

            const productId = button.dataset.productId;
            const productName = button.dataset.productName;
            const sku = button.dataset.sku;

            if (!productId) {
                alert('Không tìm thấy ID sản phẩm');
                return;
            }

            await openRackLocationModal(productId, {
                productName,
                sku
            });
        });
    });
}


/* =========================================================
   INVENTORY LOG MODAL
========================================================= */

async function openInventoryLogModal(productId, productInfo = {}) {
    currentLogProductId = productId;
    currentLogProductInfo = productInfo;

    const modal = document.getElementById('inventoryLogModal');
    const info = document.getElementById('selectedProductLogInfo');

    if (info) {
        info.innerHTML = `
            Sản phẩm:
            <b>${escapeHTML(productInfo.productName || '---')}</b>
            ${
                productInfo.sku
                    ? ` - Mã SP: <b>${escapeHTML(productInfo.sku)}</b>`
                    : ''
            }
        `;
    }

    if (modal) {
        modal.classList.add('show');
    }

    await loadInventoryLogs(productId);
}

async function loadInventoryLogs(productId) {
    const tbody = document.getElementById('inventoryLogTableBody');

    if (!tbody) return;

    try {
        tbody.innerHTML = `
            <tr>
                <td colspan="9" class="empty-cell">
                    Đang tải lịch sử kho...
                </td>
            </tr>
        `;

        const logType = document.getElementById('inventoryLogTypeFilter')?.value || 'all';
        const fromDate = document.getElementById('inventoryLogFromDate')?.value || '';
        const toDate = document.getElementById('inventoryLogToDate')?.value || '';

        const query = buildQueryString({
            logType,
            fromDate,
            toDate
        });

        const result = await fetchJSON(
            `/api/inventory/products/${productId}/inventory-logs${query}`
        );

        console.log('Inventory logs:', result);

        const logs = normalizeList(result);

        renderInventoryLogTable(logs);

    } catch (err) {
        console.error('Lỗi load inventory logs:', err);

        tbody.innerHTML = `
            <tr>
                <td colspan="9" class="empty-cell">
                    Không thể tải lịch sử kho: ${escapeHTML(err.message)}
                </td>
            </tr>
        `;
    }
}

function renderInventoryLogTable(logs) {
    const tbody = document.getElementById('inventoryLogTableBody');

    if (!tbody) return;

    if (!Array.isArray(logs) || !logs.length) {
        tbody.innerHTML = `
            <tr>
                <td colspan="9" class="empty-cell">
                    Chưa có dữ liệu lịch sử kho.
                </td>
            </tr>
        `;
        return;
    }

    tbody.innerHTML = logs.map((log, index) => {
        const logType = getLogType(log);
        const changeQuantity = getLogChangeQuantity(log);
        const quantityClass = changeQuantity >= 0 ? 'quantity-plus' : 'quantity-minus';

        return `
            <tr>
                <td>${index + 1}</td>

                <td>
                    ${escapeHTML(formatDateTime(
                        log.CreatedAt ??
                        log.created_at ??
                        log.createdAt
                    ))}
                </td>

                <td>
                    <span class="log-type-badge log-type-${escapeHTML(logType.className)}">
                        ${escapeHTML(logType.text)}
                    </span>
                </td>

                <td class="${quantityClass}">
                    ${changeQuantity > 0 ? '+' : ''}${changeQuantity}
                </td>

                <td>
                    ${escapeHTML(
                        log.BatchNumber ??
                        log.batch_number ??
                        log.batchNumber ??
                        '-'
                    )}
                </td>

                <td>
                    ${escapeHTML(
                        log.LocationRack ??
                        log.location_rack ??
                        log.locationRack ??
                        '-'
                    )}
                </td>

                <td>
                    ${escapeHTML(
                        log.performed_by_name ??
                        log.performedByName ??
                        log.PerformedByName ??
                        log.performed_by_email ??
                        log.performedByEmail ??
                        log.email ??
                        log.PerformedBy ??
                        log.performed_by ??
                        '-'
                    )}
                </td>

                <td>
                    ${escapeHTML(log.Note ?? log.note ?? '-')}
                </td>

                <td>
                    ${escapeHTML(log.ReferenceID ?? log.reference_id ?? log.referenceId ?? '-')}
                </td>
            </tr>
        `;
    }).join('');
}

function getLogType(log) {
    const raw = String(
        log.LogType ??
        log.log_type ??
        log.logType ??
        ''
    ).toUpperCase();

    const map = {
        IMPORT: {
            text: 'Nhập kho',
            className: 'import'
        },
        EXPORT: {
            text: 'Xuất kho',
            className: 'export'
        },
        ADJUSTMENT: {
            text: 'Điều chỉnh',
            className: 'adjustment'
        },
        STOCKTAKE: {
            text: 'Kiểm kê',
            className: 'stocktake'
        }
    };

    return map[raw] || {
        text: raw || 'Khác',
        className: 'other'
    };
}

function getLogChangeQuantity(log) {
    return toNumber(
        log.ChangeQuantity ??
        log.change_quantity ??
        log.changeQuantity ??
        0
    );
}

function closeInventoryLogModal() {
    const modal = document.getElementById('inventoryLogModal');

    if (!modal) return;

    modal.classList.remove('show');
}

function bindInventoryLogFilterEvents() {
    const reloadBtn = document.getElementById('reloadInventoryLogBtn');
    const typeFilter = document.getElementById('inventoryLogTypeFilter');
    const fromDate = document.getElementById('inventoryLogFromDate');
    const toDate = document.getElementById('inventoryLogToDate');

    if (reloadBtn) {
        reloadBtn.addEventListener('click', async () => {
            if (!currentLogProductId) return;
            await loadInventoryLogs(currentLogProductId);
        });
    }

    if (typeFilter) {
        typeFilter.addEventListener('change', async () => {
            if (!currentLogProductId) return;
            await loadInventoryLogs(currentLogProductId);
        });
    }

    if (fromDate) {
        fromDate.addEventListener('change', async () => {
            if (!currentLogProductId) return;
            await loadInventoryLogs(currentLogProductId);
        });
    }

    if (toDate) {
        toDate.addEventListener('change', async () => {
            if (!currentLogProductId) return;
            await loadInventoryLogs(currentLogProductId);
        });
    }
}


/* =========================================================
   RACK LOCATION / LOT MODAL
========================================================= */

async function openRackLocationModal(productId, productInfo = {}) {
    const modal = document.getElementById('rackLocationModal');
    const info = document.getElementById('selectedProductRackInfo');

    if (info) {
        info.innerHTML = `
            Sản phẩm:
            <b>${escapeHTML(productInfo.productName || '---')}</b>
            ${
                productInfo.sku
                    ? ` - Mã SP: <b>${escapeHTML(productInfo.sku)}</b>`
                    : ''
            }
        `;
    }

    if (modal) {
        modal.classList.add('show');
    }

    await loadRackLocations(productId);
}

async function loadRackLocations(productId) {
    const tbody = document.getElementById('rackLocationTableBody');

    if (!tbody) return;

    try {
        tbody.innerHTML = `
            <tr>
                <td colspan="9" class="empty-cell">
                    Đang tải vị trí kệ...
                </td>
            </tr>
        `;

        const result = await fetchJSONFallback([
            `/api/inventory/products/${productId}/lots`,
            `/api/inventory/lots/${productId}`
        ]);

        console.log('Rack locations / lots:', result);

        const lots = normalizeList(result);

        renderRackLocationTable(lots);

    } catch (err) {
        console.error('Lỗi load vị trí kệ:', err);

        tbody.innerHTML = `
            <tr>
                <td colspan="9" class="empty-cell">
                    Không thể tải vị trí kệ: ${escapeHTML(err.message)}
                </td>
            </tr>
        `;
    }
}

function renderRackLocationTable(lots) {
    const tbody = document.getElementById('rackLocationTableBody');

    if (!tbody) return;

    if (!Array.isArray(lots) || !lots.length) {
        tbody.innerHTML = `
            <tr>
                <td colspan="9" class="empty-cell">
                    Chưa có dữ liệu vị trí kệ.
                </td>
            </tr>
        `;
        return;
    }

    tbody.innerHTML = lots.map((lot, index) => {
        const quantity = toNumber(lot.Quantity ?? lot.quantity ?? 0);
        const allocated = toNumber(
            lot.AllocatedQuantity ??
            lot.allocatedQuantity ??
            lot.allocated_quantity ??
            0
        );

        const available = toNumber(
            lot.AvailableQty ??
            lot.availableQty ??
            lot.available_quantity ??
            lot.AvailableQuantity ??
            quantity - allocated
        );

        return `
            <tr>
                <td>${index + 1}</td>

                <td>
                    ${escapeHTML(
                        lot.BatchNumber ??
                        lot.batchNumber ??
                        lot.batch_number ??
                        '-'
                    )}
                </td>

                <td>
                    ${escapeHTML(formatDate(
                        lot.ExpiryDate ??
                        lot.expiryDate ??
                        lot.expiry_date
                    ))}
                </td>

                <td>
                    ${escapeHTML(
                        lot.LocationRack ??
                        lot.locationRack ??
                        lot.location_rack ??
                        '-'
                    )}
                </td>

                <td>${quantity}</td>

                <td>${allocated}</td>

                <td>${available}</td>

                <td>
                    ${renderExpiryBadge(
                        lot.ExpiryStatus ??
                        lot.expiryStatus ??
                        lot.expiry_status
                    )}
                </td>

                <td>
                    ${escapeHTML(formatDateTime(
                        lot.UpdatedAt ??
                        lot.updatedAt ??
                        lot.updated_at
                    ))}
                </td>
            </tr>
        `;
    }).join('');
}

function renderExpiryBadge(status) {
    const raw = String(status ?? '').toUpperCase();

    const map = {
        NO_EXPIRY: {
            text: 'Không hạn',
            className: 'no-expiry'
        },
        EXPIRED: {
            text: 'Hết hạn',
            className: 'expired'
        },
        WARNING: {
            text: 'Sắp hết hạn',
            className: 'warning'
        },
        OK: {
            text: 'Còn hạn',
            className: 'ok'
        }
    };

    const item = map[raw] || {
        text: raw || '-',
        className: 'unknown'
    };

    return `
        <span class="expiry-badge expiry-badge--${escapeHTML(item.className)}">
            ${escapeHTML(item.text)}
        </span>
    `;
}

function closeRackLocationModal() {
    const modal = document.getElementById('rackLocationModal');

    if (!modal) return;

    modal.classList.remove('show');
}


/* =========================================================
   MODAL EVENTS
========================================================= */

function bindModalEvents() {
    document.addEventListener('click', e => {
        const target = e.target;

        if (target.closest('#closeInventoryLogModalBtn')) {
            closeInventoryLogModal();
        }

        if (target.closest('#closeRackLocationModalBtn')) {
            closeRackLocationModal();
        }

        if (target.id === 'inventoryLogModal') {
            closeInventoryLogModal();
        }

        if (target.id === 'rackLocationModal') {
            closeRackLocationModal();
        }
    });

    document.addEventListener('keydown', e => {
        if (e.key === 'Escape') {
            closeInventoryLogModal();
            closeRackLocationModal();
        }
    });
}


/* =========================================================
   FILTER INVENTORY
========================================================= */

function filterInventory() {
    const searchInput = document.getElementById('inventorySearchInput');
    const statusFilter = document.getElementById('inventoryStatusFilter');
    const categoryFilter = document.getElementById('inventoryCategoryFilter');

    const keyword = normalizeText(searchInput?.value || '');
    const selectedStatus = normalizeStatusFilter(statusFilter?.value || 'all');
    const selectedCategory = normalizeId(categoryFilter?.value || 'all');

    currentFilteredItems = allInventoryItems.filter(item => {
        const productId = normalizeId(getInventoryProductId(item));
        const productIdText = normalizeText(productId);

        const productName = normalizeText(getInventoryProductName(item));
        const sku = normalizeText(getInventorySku(item));

        const categoryId = getInventoryCategoryId(item);

        const quantity = getInventoryQuantity(item);
        const min = getInventoryMinStock(item);
        const status = getStockStatusInfo(quantity, min);

        const matchesKeyword =
            !keyword ||
            productName.includes(keyword) ||
            productIdText.includes(keyword) ||
            sku.includes(keyword);

        const matchesStatus =
            selectedStatus === 'all' ||
            status.code === selectedStatus ||
            status.text === selectedStatus;

        const matchesCategory =
            selectedCategory === 'all' ||
            categoryId === selectedCategory;

        return matchesKeyword && matchesStatus && matchesCategory;
    });

    renderTable(currentFilteredItems);
}


/* =========================================================
   FILTER EVENTS
========================================================= */

function bindFilterEvents() {
    const searchInput = document.getElementById('inventorySearchInput');
    const statusFilter = document.getElementById('inventoryStatusFilter');
    const categoryFilter = document.getElementById('inventoryCategoryFilter');

    if (searchInput) {
        searchInput.addEventListener('input', filterInventory);
    }

    if (statusFilter) {
        statusFilter.addEventListener('change', filterInventory);
    }

    if (categoryFilter) {
        categoryFilter.addEventListener('change', filterInventory);
    }
}


/* =========================================================
   TABLE SORT
========================================================= */

function bindTableSortEvents() {
    const table = document.querySelector('.product-table');

    if (!table) return;

    const headers = table.querySelectorAll('th.sortable');
    const tbody = table.querySelector('tbody');

    if (!tbody || !headers.length) return;

    headers.forEach(header => {
        header.addEventListener('click', () => {
            const currentDirection = header.classList.contains('asc') ? 'desc' : 'asc';

            headers.forEach(h => {
                h.classList.remove('asc', 'desc');

                const icon = h.querySelector('.sort-icon');

                if (icon) {
                    icon.className = 'fa-solid fa-sort sort-icon';
                }
            });

            header.classList.add(currentDirection);

            const currentIcon = header.querySelector('.sort-icon');

            if (currentIcon) {
                currentIcon.className =
                    currentDirection === 'asc'
                        ? 'fa-solid fa-sort-up sort-icon'
                        : 'fa-solid fa-sort-down sort-icon';
            }

            const index = Array.from(header.parentNode.children).indexOf(header);

            const rows = Array.from(tbody.querySelectorAll('tr'))
                .filter(row => !row.querySelector('.empty-cell'));

            const sortedRows = rows.sort((rowA, rowB) => {
                const cellA = rowA.children[index]?.textContent.trim() || '';
                const cellB = rowB.children[index]?.textContent.trim() || '';

                const numA = parseFloat(cellA.replace(/[^0-9.-]/g, ''));
                const numB = parseFloat(cellB.replace(/[^0-9.-]/g, ''));

                if (!Number.isNaN(numA) && !Number.isNaN(numB)) {
                    return currentDirection === 'asc'
                        ? numA - numB
                        : numB - numA;
                }

                return currentDirection === 'asc'
                    ? cellA.localeCompare(cellB, 'vi', { sensitivity: 'base' })
                    : cellB.localeCompare(cellA, 'vi', { sensitivity: 'base' });
            });

            tbody.innerHTML = '';
            tbody.append(...sortedRows);

            Array.from(tbody.querySelectorAll('tr')).forEach((row, idx) => {
                if (row.children[0]) {
                    row.children[0].textContent = idx + 1;
                }
            });
        });
    });
}