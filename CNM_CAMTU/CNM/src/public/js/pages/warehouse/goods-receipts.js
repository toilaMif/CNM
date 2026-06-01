/* =========================================================
   WAREHOUSE - GOODS RECEIPTS
   Frontend nhận hàng thực tế theo Purchase Order

   Chức năng:
   1. Hiển thị danh sách PO cần nhận
   2. Tạo phiếu nhận hàng
   3. Upload ảnh hàng lỗi theo từng dòng sản phẩm
   4. Hiển thị lịch sử phiếu nhập kho
   5. Xem chi tiết phiếu nhập kho
   6. Hiển thị ảnh hàng lỗi trong chi tiết phiếu
========================================================= */

const API = {
    pendingPO: '/api/procurement/purchase-orders/pending-receive',
    poDetail: '/api/procurement/purchase-orders',
    goodsReceipts: '/api/inventory/goods-receipts'
};

const state = {
    purchaseOrders: [],
    goodsReceipts: [],
    currentPO: null,
    currentView: 'pending'
};

/* =========================================================
   API CLIENT - JSON
   Dùng cho GET hoặc request JSON bình thường
========================================================= */

async function request(url, options = {}) {
    const token =
        localStorage.getItem('accessToken') ||
        localStorage.getItem('access_token') ||
        localStorage.getItem('token') ||
        sessionStorage.getItem('accessToken') ||
        sessionStorage.getItem('access_token') ||
        sessionStorage.getItem('token');

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
   API CLIENT - FORM DATA
   Dùng cho tạo phiếu nhập có upload ảnh hàng lỗi

   Lưu ý:
   - Không set Content-Type.
   - Browser tự set multipart/form-data boundary.
========================================================= */

async function requestFormData(url, options = {}) {
    const token =
        localStorage.getItem('accessToken') ||
        localStorage.getItem('access_token') ||
        localStorage.getItem('token') ||
        sessionStorage.getItem('accessToken') ||
        sessionStorage.getItem('access_token') ||
        sessionStorage.getItem('token');

    const headers = {
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

function normalizeList(payload) {
    if (Array.isArray(payload)) return payload;
    if (Array.isArray(payload?.data)) return payload.data;
    if (Array.isArray(payload?.items)) return payload.items;
    if (Array.isArray(payload?.data?.items)) return payload.data.items;
    return [];
}

/* =========================================================
   HELPERS
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

function showToast(message, type = 'success', sub = '') {
    const box = document.getElementById('toastContainer');

    if (!box) {
        alert(message);
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

function getPOStatusText(status) {
    const map = {
        ORDERED: 'Đã đặt hàng',
        PARTIAL_RECEIVED: 'Nhận một phần',
        COMPLETED: 'Hoàn tất',
        CANCELLED: 'Đã hủy'
    };

    return map[status] || status || 'Không rõ';
}

function getIssueStatusText(status) {
    const map = {
        NONE: 'Bình thường',
        WAITING_REVIEW: 'Chờ xử lý lỗi',
        EMAIL_SENT: 'Đã gửi email NCC',
        RESOLVED: 'Đã xử lý'
    };

    return map[status] || status || 'Bình thường';
}

/* =========================================================
   VIEW SWITCH
========================================================= */

function switchView(view) {
    state.currentView = view;

    document.querySelectorAll('.view-btn').forEach(btn => {
        btn.classList.toggle('active', btn.dataset.view === view);
    });

    document.querySelectorAll('.view-panel').forEach(panel => {
        panel.classList.remove('active');
    });

    if (view === 'pending') {
        document.getElementById('pendingView')?.classList.add('active');
    }

    if (view === 'history') {
        document.getElementById('historyView')?.classList.add('active');
        loadGoodsReceiptHistory();
    }
}

/* =========================================================
   LOAD PENDING PO
========================================================= */

async function loadPendingPOs() {
    try {
        const data = await request(API.pendingPO);
        state.purchaseOrders = normalizeList(data);

    } catch (err) {
        state.purchaseOrders = [];
        showToast('Không tải được danh sách PO', 'error', err.message);
    }

    renderSummary();
    renderPendingPOs();
}

function getFilteredPOs() {
    const keyword =
        document.getElementById('searchInput')?.value.trim().toLowerCase() || '';

    const status =
        document.getElementById('statusFilter')?.value || '';

    return state.purchaseOrders.filter(po => {
        const poCode = String(po.po_code || '').toLowerCase();
        const supplierName = String(po.supplier_name || '').toLowerCase();
        const poStatus = String(po.status || '');

        return (
            (!keyword || poCode.includes(keyword) || supplierName.includes(keyword)) &&
            (!status || poStatus === status)
        );
    });
}

function renderSummary() {
    const totalPendingPO = document.getElementById('totalPendingPO');
    const totalEmailSent = document.getElementById('totalEmailSent');
    const totalPartial = document.getElementById('totalPartial');

    const total = state.purchaseOrders.length;
    const emailSent = state.purchaseOrders.filter(po => po.email_status === 'SENT').length;
    const partial = state.purchaseOrders.filter(po => po.status === 'PARTIAL_RECEIVED').length;

    if (totalPendingPO) totalPendingPO.textContent = total;
    if (totalEmailSent) totalEmailSent.textContent = emailSent;
    if (totalPartial) totalPartial.textContent = partial;
}

function renderPendingPOs() {
    const body = document.getElementById('pendingPOTableBody');
    const count = document.getElementById('poCount');

    if (!body) return;

    const rows = getFilteredPOs();

    if (count) {
        count.textContent = `Hiển thị: ${rows.length}/${state.purchaseOrders.length} phiếu`;
    }

    if (!rows.length) {
        body.innerHTML = `
            <tr>
                <td colspan="8" class="empty-cell">
                    Không có phiếu đặt hàng đang chờ nhận
                </td>
            </tr>
        `;
        return;
    }

    body.innerHTML = rows.map((po, index) => `
        <tr>
            <td>${String(index + 1).padStart(2, '0')}</td>

            <td>
                <b>${escapeHTML(po.po_code || '-')}</b>
            </td>

            <td>${escapeHTML(po.supplier_name || '-')}</td>

            <td>${escapeHTML(po.supplier_email || '-')}</td>

            <td>${formatDate(po.expected_delivery_date)}</td>

            <td><b>${formatCurrency(po.total_amount)}</b></td>

            <td>
                <span class="badge ${po.status === 'PARTIAL_RECEIVED' ? 'orange' : ''}">
                    ${escapeHTML(getPOStatusText(po.status))}
                </span>
            </td>

            <td>
                <button 
                    type="button"
                    class="btn btn-success btn-sm btn-receive"
                    data-id="${po.purchase_order_id}">
                    <i class="fa-solid fa-box-open"></i>
                    Nhận hàng
                </button>
            </td>
        </tr>
    `).join('');
}

/* =========================================================
   LOAD GOODS RECEIPT HISTORY
========================================================= */

async function loadGoodsReceiptHistory() {
    try {
        const data = await request(API.goodsReceipts);
        state.goodsReceipts = normalizeList(data);

    } catch (err) {
        state.goodsReceipts = [];
        showToast('Không tải được lịch sử phiếu nhập', 'error', err.message);
    }

    renderReceiptHistory();
}

function getFilteredReceipts() {
    const keyword =
        document.getElementById('historySearchInput')?.value.trim().toLowerCase() || '';

    const rejectedFilter =
        document.getElementById('historyRejectedFilter')?.value || '';

    return state.goodsReceipts.filter(receipt => {
        const receiptCode = String(receipt.receipt_code || '').toLowerCase();
        const poCode = String(receipt.po_code || '').toLowerCase();
        const supplierName = String(receipt.supplier_name || '').toLowerCase();
        const hasRejected = String(receipt.has_rejected_items ?? '');

        return (
            (!keyword ||
                receiptCode.includes(keyword) ||
                poCode.includes(keyword) ||
                supplierName.includes(keyword)) &&
            (!rejectedFilter || hasRejected === rejectedFilter)
        );
    });
}

function renderReceiptHistory() {
    const body = document.getElementById('receiptHistoryTableBody');
    const count = document.getElementById('receiptHistoryCount');

    if (!body) return;

    const rows = getFilteredReceipts();

    if (count) {
        count.textContent = `Hiển thị: ${rows.length}/${state.goodsReceipts.length} phiếu nhập`;
    }

    if (!rows.length) {
        body.innerHTML = `
            <tr>
                <td colspan="10" class="empty-cell">
                    Chưa có phiếu nhập kho
                </td>
            </tr>
        `;
        return;
    }

    body.innerHTML = rows.map((receipt, index) => {
        const totalReceived = Number(receipt.total_received_quantity || 0);
        const totalAccepted = Number(receipt.total_accepted_quantity || 0);
        const totalRejected = Number(receipt.total_rejected_quantity || 0);

        const hasRejected = Number(receipt.has_rejected_items || 0) === 1;
        const issueStatus = receipt.issue_status || (hasRejected ? 'WAITING_REVIEW' : 'NONE');

        return `
            <tr>
                <td>${String(index + 1).padStart(2, '0')}</td>

                <td>
                    <b>${escapeHTML(receipt.receipt_code || '-')}</b>
                </td>

                <td>${escapeHTML(receipt.po_code || '-')}</td>

                <td>${escapeHTML(receipt.supplier_name || '-')}</td>

                <td>${formatDate(receipt.received_date || receipt.created_at)}</td>

                <td><b>${formatNumber(totalReceived)}</b></td>

                <td><b>${formatNumber(totalAccepted)}</b></td>

                <td>
                    <b class="${hasRejected ? 'text-red' : ''}">
                        ${formatNumber(totalRejected)}
                    </b>
                </td>

                <td>
                    <span class="badge ${hasRejected ? 'red' : ''}">
                        ${escapeHTML(getIssueStatusText(issueStatus))}
                    </span>
                </td>

                <td>
                    <button 
                        type="button"
                        class="btn btn-outline btn-sm btn-view-receipt"
                        data-id="${receipt.goods_receipt_id || receipt.receipt_id}">
                        <i class="fa-solid fa-eye"></i>
                        Chi tiết
                    </button>
                </td>
            </tr>
        `;
    }).join('');
}

/* =========================================================
   OPEN RECEIVE MODAL
========================================================= */

async function openReceiptModal(purchaseOrderId) {
    try {
        const data = await request(`${API.poDetail}/${purchaseOrderId}`);
        const po = data.data;

        if (!po) {
            throw new Error('Không tìm thấy phiếu đặt hàng');
        }

        state.currentPO = po;

        fillPODetail(po);
        renderReceiptLines(po.items || []);

        document.getElementById('goodsReceiptModal')?.classList.add('show');

    } catch (err) {
        showToast('Không tải được chi tiết PO', 'error', err.message);
    }
}

function closeReceiptModal() {
    document.getElementById('goodsReceiptModal')?.classList.remove('show');
    state.currentPO = null;

    const note = document.getElementById('receiptNote');

    if (note) {
        note.value = '';
    }
}

function fillPODetail(po) {
    document.getElementById('purchaseOrderId').value = po.purchase_order_id || '';

    document.getElementById('detailPOCode').textContent = po.po_code || '---';
    document.getElementById('detailSupplierName').textContent = po.supplier_name || '---';
    document.getElementById('detailExpectedDate').textContent = formatDate(po.expected_delivery_date);
    document.getElementById('detailStatus').textContent = getPOStatusText(po.status);

    const subtitle = document.getElementById('modalSubtitle');

    if (subtitle) {
        subtitle.textContent = `Nhận hàng từ nhà cung cấp: ${po.supplier_name || '---'}`;
    }
}

/* =========================================================
   RECEIPT LINES
========================================================= */

function renderReceiptLines(items = []) {
    const wrap = document.getElementById('receiptLines');
    const template = document.getElementById('receiptLineTemplate');

    if (!wrap || !template) return;

    wrap.innerHTML = '';

    const receivableItems = items.filter(item => {
        return Number(item.remaining_quantity || 0) > 0;
    });

    if (!receivableItems.length) {
        wrap.innerHTML = `
            <div class="empty-box">
                Phiếu này không còn sản phẩm nào cần nhận.
            </div>
        `;
        return;
    }

    receivableItems.forEach(item => {
        const node = template.content.cloneNode(true);
        const remaining = Number(item.remaining_quantity || 0);

        node.querySelector('.line-po-detail-id').value = item.purchase_order_detail_id;
        node.querySelector('.line-product-id').value = item.product_id;
        node.querySelector('.line-unit-price').value = item.unit_price || 0;
        node.querySelector('.line-remaining-value').value = remaining;

        node.querySelector('.line-product-name').textContent =
            item.ProductName || item.product_name || 'Sản phẩm';

        node.querySelector('.line-sku').textContent = item.SKU || item.sku || '-';
        node.querySelector('.line-ordered').textContent = formatNumber(item.ordered_quantity);
        node.querySelector('.line-received-before').textContent = formatNumber(item.received_quantity);
        node.querySelector('.line-remaining').textContent = formatNumber(remaining);

        const receivedInput = node.querySelector('.line-received');
        const acceptedInput = node.querySelector('.line-accepted');
        const rejectedInput = node.querySelector('.line-rejected');
        const fileInput = node.querySelector('.line-fault-images');

        receivedInput.max = remaining;
        acceptedInput.max = remaining;
        rejectedInput.max = remaining;

        receivedInput.value = remaining;
        acceptedInput.value = remaining;
        rejectedInput.value = 0;

        receivedInput.addEventListener('input', () => {
            syncAcceptedQuantity(receivedInput, acceptedInput, rejectedInput);
        });

        rejectedInput.addEventListener('input', () => {
            syncAcceptedQuantity(receivedInput, acceptedInput, rejectedInput);
        });

        if (fileInput) {
            fileInput.addEventListener('change', () => {
                renderSelectedFileCount(fileInput);
            });
        }

        wrap.appendChild(node);
    });
}

function syncAcceptedQuantity(receivedInput, acceptedInput, rejectedInput) {
    const received = Number(receivedInput.value || 0);
    const rejected = Number(rejectedInput.value || 0);

    acceptedInput.value = Math.max(received - rejected, 0);
}

function renderSelectedFileCount(fileInput) {
    const group = fileInput.closest('.form-group');

    if (!group) return;

    let hint = group.querySelector('.file-count-hint');

    if (!hint) {
        hint = document.createElement('small');
        hint.className = 'file-count-hint';
        group.appendChild(hint);
    }

    const count = fileInput.files.length;

    hint.textContent = count > 0
        ? `Đã chọn ${count} ảnh`
        : '';
}

/* =========================================================
   COLLECT + VALIDATE
========================================================= */

function collectReceiptItems() {
    return [...document.querySelectorAll('#receiptLines .receipt-line')]
        .map(line => {
            const purchaseOrderDetailId = Number(line.querySelector('.line-po-detail-id')?.value);
            const productId = Number(line.querySelector('.line-product-id')?.value);
            const unitPrice = Number(line.querySelector('.line-unit-price')?.value || 0);
            const remaining = Number(line.querySelector('.line-remaining-value')?.value || 0);

            const receivedQuantity = Number(line.querySelector('.line-received')?.value || 0);
            const acceptedQuantity = Number(line.querySelector('.line-accepted')?.value || 0);
            const rejectedQuantity = Number(line.querySelector('.line-rejected')?.value || 0);

            const rejectReason = line.querySelector('.line-reject-reason')?.value.trim() || null;
            const manufacturerBatch = line.querySelector('.line-manufacturer-batch')?.value.trim() || null;
            const expiryDate = line.querySelector('.line-expiry')?.value || null;
            const locationRack = line.querySelector('.line-rack')?.value.trim() || null;

            return {
                purchase_order_detail_id: purchaseOrderDetailId,
                product_id: productId,
                received_quantity: receivedQuantity,
                accepted_quantity: acceptedQuantity,
                rejected_quantity: rejectedQuantity,
                reject_reason: rejectReason,
                manufacturer_batch: manufacturerBatch,
                expiry_date: expiryDate,
                location_rack: locationRack,
                unit_price: unitPrice,
                remaining_quantity: remaining
            };
        })
        .filter(item => item.received_quantity > 0);
}

function validateReceiptItems(items) {
    if (!items.length) {
        throw new Error('Cần nhập ít nhất 1 sản phẩm');
    }

    for (const item of items) {
        if (!item.purchase_order_detail_id || !item.product_id) {
            throw new Error('Dữ liệu sản phẩm không hợp lệ');
        }

        if (item.received_quantity <= 0) {
            throw new Error('Số lượng thực nhận phải lớn hơn 0');
        }

        if (item.received_quantity > item.remaining_quantity) {
            throw new Error('Số lượng thực nhận không được vượt quá số lượng còn lại');
        }

        if (item.accepted_quantity < 0 || item.rejected_quantity < 0) {
            throw new Error('Số lượng đạt hoặc lỗi không hợp lệ');
        }

        if (item.accepted_quantity + item.rejected_quantity > item.received_quantity) {
            throw new Error('Số lượng đạt + lỗi không được vượt quá số lượng thực nhận');
        }

        if (item.accepted_quantity > 0 && !item.location_rack) {
            throw new Error('Sản phẩm đạt cần có vị trí kệ');
        }

        if (item.rejected_quantity > 0 && !item.reject_reason) {
            throw new Error('Có hàng lỗi thì cần nhập lý do lỗi');
        }
    }
}

/* =========================================================
   SUBMIT GOODS RECEIPT
   Gửi multipart/form-data để backend nhận được:
   - req.body.payload
   - req.files
========================================================= */

async function submitGoodsReceipt(e) {
    e.preventDefault();

    try {
        const purchaseOrderId = Number(document.getElementById('purchaseOrderId')?.value);
        const note = document.getElementById('receiptNote')?.value.trim() || null;

        if (!purchaseOrderId) {
            throw new Error('Thiếu ID phiếu đặt hàng');
        }

        const items = collectReceiptItems();

        validateReceiptItems(items);

        const payload = {
            purchase_order_id: purchaseOrderId,
            note,
            items: items.map(item => ({
                purchase_order_detail_id: item.purchase_order_detail_id,
                product_id: item.product_id,
                received_quantity: item.received_quantity,
                accepted_quantity: item.accepted_quantity,
                rejected_quantity: item.rejected_quantity,
                reject_reason: item.reject_reason,
                manufacturer_batch: item.manufacturer_batch,
                expiry_date: item.expiry_date,
                location_rack: item.location_rack,
                unit_price: item.unit_price
            }))
        };

        const formData = new FormData();

        formData.append('payload', JSON.stringify(payload));

        document.querySelectorAll('#receiptLines .receipt-line').forEach(line => {
            const poDetailId = line.querySelector('.line-po-detail-id')?.value;
            const fileInput = line.querySelector('.line-fault-images');

            if (!poDetailId || !fileInput) return;

            [...fileInput.files].forEach(file => {
                formData.append(`fault_images_${poDetailId}`, file);
            });
        });

        await requestFormData(API.goodsReceipts, {
            method: 'POST',
            body: formData
        });

        showToast('Nhận hàng thành công', 'success', 'Tồn kho đã được cập nhật');

        closeReceiptModal();

        await loadPendingPOs();
        await loadGoodsReceiptHistory();

    } catch (err) {
        showToast('Nhận hàng thất bại', 'error', err.message);
    }
}

/* =========================================================
   RECEIPT DETAIL MODAL
========================================================= */

async function openReceiptDetail(receiptId) {
    try {
        const data = await request(`${API.goodsReceipts}/${receiptId}`);
        const receipt = data.data;

        if (!receipt) {
            throw new Error('Không tìm thấy phiếu nhập');
        }

        fillReceiptDetail(receipt);

        document.getElementById('receiptDetailModal')?.classList.add('show');

    } catch (err) {
        showToast('Không tải được chi tiết phiếu nhập', 'error', err.message);
    }
}

function closeReceiptDetailModal() {
    document.getElementById('receiptDetailModal')?.classList.remove('show');
}

function fillReceiptDetail(receipt) {
    const hasRejected = Number(receipt.has_rejected_items || 0) === 1;
    const issueStatus = receipt.issue_status || (hasRejected ? 'WAITING_REVIEW' : 'NONE');

    document.getElementById('detailReceiptCode').textContent =
        receipt.receipt_code || '---';

    document.getElementById('detailReceiptPOCode').textContent =
        receipt.po_code || '---';

    document.getElementById('detailReceiptSupplier').textContent =
        receipt.supplier_name || '---';

    document.getElementById('detailReceiptStatus').textContent =
        getIssueStatusText(issueStatus);

    const subtitle = document.getElementById('receiptDetailSubtitle');

    if (subtitle) {
        subtitle.textContent =
            `Ngày nhận: ${formatDate(receipt.received_date || receipt.created_at)}`;
    }

    renderReceiptDetailItems(receipt.items || []);
}

function renderReceiptDetailItems(items = []) {
    const body = document.getElementById('receiptDetailTableBody');

    if (!body) return;

    if (!items.length) {
        body.innerHTML = `
            <tr>
                <td colspan="12" class="empty-cell">
                    Phiếu nhập không có chi tiết sản phẩm
                </td>
            </tr>
        `;
        return;
    }

    body.innerHTML = items.map((item, index) => {
        const rejected = Number(item.rejected_quantity || 0);

        const faultImages = Array.isArray(item.fault_images)
            ? item.fault_images
            : [];

        return `
            <tr>
                <td>${String(index + 1).padStart(2, '0')}</td>

                <td><b>${escapeHTML(item.ProductName || '-')}</b></td>

                <td>${escapeHTML(item.SKU || '-')}</td>

                <td>${formatNumber(item.received_quantity)}</td>

                <td>${formatNumber(item.accepted_quantity)}</td>

                <td>
                    <b class="${rejected > 0 ? 'text-red' : ''}">
                        ${formatNumber(rejected)}
                    </b>
                </td>

                <td>${escapeHTML(item.reject_reason || '-')}</td>

                <td>${escapeHTML(item.batch_number || '-')}</td>

                <td>${escapeHTML(item.manufacturer_batch || '-')}</td>

                <td>${formatDate(item.expiry_date)}</td>

                <td>${escapeHTML(item.location_rack || '-')}</td>

                <td>
                    ${renderFaultImages(faultImages)}
                </td>
            </tr>
        `;
    }).join('');
}

function renderFaultImages(images = []) {
    if (!images.length) {
        return '-';
    }

    return `
        <div class="fault-images">
            ${images.map(url => `
                <a href="${escapeHTML(url)}" target="_blank" class="fault-image-link">
                    <img src="${escapeHTML(url)}" alt="Ảnh hàng lỗi">
                </a>
            `).join('')}
        </div>
    `;
}

/* =========================================================
   EVENTS
========================================================= */

function bindEvents() {
    document.getElementById('btnReload')?.addEventListener('click', async () => {
        await loadPendingPOs();
        await loadGoodsReceiptHistory();
    });

    document.querySelectorAll('.view-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            switchView(btn.dataset.view);
        });
    });

    document.getElementById('searchInput')?.addEventListener('input', renderPendingPOs);
    document.getElementById('statusFilter')?.addEventListener('change', renderPendingPOs);

    document.getElementById('historySearchInput')?.addEventListener('input', renderReceiptHistory);
    document.getElementById('historyRejectedFilter')?.addEventListener('change', renderReceiptHistory);

    document.addEventListener('click', e => {
        const receiveBtn = e.target.closest('.btn-receive');

        if (receiveBtn) {
            const purchaseOrderId = Number(receiveBtn.dataset.id);

            if (purchaseOrderId) {
                openReceiptModal(purchaseOrderId);
            }

            return;
        }

        const detailBtn = e.target.closest('.btn-view-receipt');

        if (detailBtn) {
            const receiptId = Number(detailBtn.dataset.id);

            if (receiptId) {
                openReceiptDetail(receiptId);
            }
        }
    });

    document.getElementById('btnCloseModal')?.addEventListener('click', closeReceiptModal);
    document.getElementById('btnCancelReceipt')?.addEventListener('click', closeReceiptModal);

    document.getElementById('goodsReceiptModal')?.addEventListener('click', e => {
        if (e.target.id === 'goodsReceiptModal') {
            closeReceiptModal();
        }
    });

    document.getElementById('btnCloseReceiptDetail')?.addEventListener('click', closeReceiptDetailModal);

    document.getElementById('receiptDetailModal')?.addEventListener('click', e => {
        if (e.target.id === 'receiptDetailModal') {
            closeReceiptDetailModal();
        }
    });

    document.getElementById('goodsReceiptForm')?.addEventListener('submit', submitGoodsReceipt);
}

/* =========================================================
   INIT
========================================================= */

document.addEventListener('DOMContentLoaded', () => {
    bindEvents();

    loadPendingPOs();
    loadGoodsReceiptHistory();
});