/* =========================================================
   PRODUCT MANAGER - GOODS RECEIPTS ISSUE REVIEW

   Nghiệp vụ:
   1. Product Manager xem danh sách phiếu nhận hàng do Warehouse tạo.
   2. Lọc phiếu có hàng lỗi.
   3. Lọc trạng thái xử lý lỗi:
      - NONE
      - WAITING_REVIEW
      - EMAIL_SENT
      - RESOLVED
   4. Xem chi tiết phiếu nhập.
   5. Xem ảnh minh chứng hàng lỗi.
   6. Gửi email cho nhà cung cấp đối với phiếu lỗi.
========================================================= */

const API = {
    goodsReceipts: '/api/inventory/goods-receipts'
};

const state = {
    receipts: [],
    currentReceipt: null
};

/* =========================================================
   API CLIENT
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
    }, 3500);
}

function getReceiptId(receipt) {
    return receipt.goods_receipt_id || receipt.receipt_id;
}

function normalizeIssueStatus(receipt) {
    const hasRejected = Number(receipt.has_rejected_items || 0) === 1;

    if (receipt.issue_status) {
        return String(receipt.issue_status);
    }

    return hasRejected ? 'WAITING_REVIEW' : 'NONE';
}

function getIssueStatusText(status) {
    const map = {
        NONE: 'Không có hàng lỗi',
        WAITING_REVIEW: 'Chờ xử lý',
        EMAIL_SENT: 'Đã gửi email NCC',
        RESOLVED: 'Đã xử lý xong'
    };

    return map[status] || status || 'Không rõ';
}

function getIssueStatusClass(status) {
    const map = {
        NONE: '',
        WAITING_REVIEW: 'orange',
        EMAIL_SENT: 'blue',
        RESOLVED: 'green'
    };

    return map[status] || '';
}

/* =========================================================
   LOAD LIST
========================================================= */

async function loadReceipts() {
    try {
        const data = await request(API.goodsReceipts);
        state.receipts = normalizeList(data);

    } catch (err) {
        state.receipts = [];
        showToast('Không tải được danh sách phiếu nhập', 'error', err.message);
    }

    renderSummary();
    renderReceipts();
}

/* =========================================================
   FILTER
========================================================= */

function getFilteredReceipts() {
    const keyword =
        document.getElementById('searchInput')?.value.trim().toLowerCase() || '';

    const rejectedFilter =
        document.getElementById('rejectedFilter')?.value || '';

    const issueStatusFilter =
        document.getElementById('issueStatusFilter')?.value || '';

    return state.receipts.filter(receipt => {
        const receiptCode = String(receipt.receipt_code || '').toLowerCase();
        const poCode = String(receipt.po_code || '').toLowerCase();
        const supplierName = String(receipt.supplier_name || '').toLowerCase();
        const supplierEmail = String(receipt.supplier_email || '').toLowerCase();
        const receivedByEmail = String(receipt.received_by_email || '').toLowerCase();

        const hasRejectedNumber = Number(receipt.has_rejected_items || 0);
        const hasRejected = String(hasRejectedNumber);

        const issueStatus = normalizeIssueStatus(receipt);

        const matchKeyword =
            !keyword ||
            receiptCode.includes(keyword) ||
            poCode.includes(keyword) ||
            supplierName.includes(keyword) ||
            supplierEmail.includes(keyword) ||
            receivedByEmail.includes(keyword);

        const matchRejected =
            !rejectedFilter || hasRejected === rejectedFilter;

        let matchIssueStatus = true;

        if (issueStatusFilter === 'HAS_REJECTED') {
            matchIssueStatus = hasRejectedNumber === 1;
        } else if (issueStatusFilter) {
            matchIssueStatus = issueStatus === issueStatusFilter;
        }

        return matchKeyword && matchRejected && matchIssueStatus;
    });
}

/* =========================================================
   SUMMARY
========================================================= */

function renderSummary() {
    const totalReceiptsEl = document.getElementById('totalReceipts');
    const totalRejectedReceiptsEl = document.getElementById('totalRejectedReceipts');
    const totalWaitingReviewEl = document.getElementById('totalWaitingReview');
    const totalEmailSentEl = document.getElementById('totalEmailSent');

    const totalReceipts = state.receipts.length;

    const rejectedReceipts = state.receipts.filter(receipt => {
        return Number(receipt.has_rejected_items || 0) === 1;
    }).length;

    const waitingReview = state.receipts.filter(receipt => {
        return normalizeIssueStatus(receipt) === 'WAITING_REVIEW';
    }).length;

    const emailSent = state.receipts.filter(receipt => {
        return normalizeIssueStatus(receipt) === 'EMAIL_SENT';
    }).length;

    if (totalReceiptsEl) {
        totalReceiptsEl.textContent = formatNumber(totalReceipts);
    }

    if (totalRejectedReceiptsEl) {
        totalRejectedReceiptsEl.textContent = formatNumber(rejectedReceipts);
    }

    if (totalWaitingReviewEl) {
        totalWaitingReviewEl.textContent = formatNumber(waitingReview);
    }

    if (totalEmailSentEl) {
        totalEmailSentEl.textContent = formatNumber(emailSent);
    }
}

/* =========================================================
   RENDER MAIN TABLE
========================================================= */

function renderReceipts() {
    const body = document.getElementById('receiptTableBody');
    const count = document.getElementById('receiptCount');

    if (!body) return;

    const rows = getFilteredReceipts();

    if (count) {
        count.textContent = `Hiển thị: ${rows.length}/${state.receipts.length} phiếu`;
    }

    if (!rows.length) {
        body.innerHTML = `
            <tr>
                <td colspan="12" class="empty-cell">
                    Không có phiếu nhận hàng phù hợp
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
        const issueStatus = normalizeIssueStatus(receipt);

        return `
            <tr>
                <td>${String(index + 1).padStart(2, '0')}</td>

                <td>
                    <b>${escapeHTML(receipt.receipt_code || '-')}</b>
                </td>
                
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
                    <span class="badge ${getIssueStatusClass(issueStatus)}">
                        ${escapeHTML(getIssueStatusText(issueStatus))}
                    </span>
                </td>

                <td>
                    <button 
                        type="button"
                        class="btn btn-outline btn-sm btn-view-detail"
                        data-id="${getReceiptId(receipt)}">
                        <i class="fa-solid fa-eye"></i>
                        Chi tiết
                    </button>
                </td>
            </tr>
        `;
    }).join('');
}

/* =========================================================
   DETAIL
========================================================= */

async function openReceiptDetail(receiptId) {
    try {
        const data = await request(`${API.goodsReceipts}/${receiptId}`);
        const receipt = data.data;

        if (!receipt) {
            throw new Error('Không tìm thấy phiếu nhập');
        }

        state.currentReceipt = receipt;

        fillReceiptDetail(receipt);

        document.getElementById('receiptDetailModal')?.classList.add('show');

    } catch (err) {
        showToast('Không tải được chi tiết phiếu nhập', 'error', err.message);
    }
}

function closeReceiptDetail() {
    document.getElementById('receiptDetailModal')?.classList.remove('show');
    state.currentReceipt = null;
}

function fillReceiptDetail(receipt) {
    const hasRejected = Number(receipt.has_rejected_items || 0) === 1;
    const issueStatus = normalizeIssueStatus(receipt);

    document.getElementById('detailReceiptCode').textContent =
        receipt.receipt_code || '---';

    document.getElementById('detailPOCode').textContent =
        receipt.po_code || '---';

    document.getElementById('detailSupplierName').textContent =
        receipt.supplier_name || '---';

    document.getElementById('detailSupplierEmail').textContent =
        receipt.supplier_email || '---';

    document.getElementById('detailStatus').textContent =
        hasRejected ? 'Có hàng lỗi' : 'Bình thường';

    document.getElementById('detailIssueStatus').textContent =
        getIssueStatusText(issueStatus);

    document.getElementById('detailReceivedBy').textContent =
        receipt.received_by_email || '---';

    document.getElementById('detailReceivedDate').textContent =
        formatDate(receipt.received_date || receipt.created_at);

    document.getElementById('detailNote').textContent =
        receipt.note || 'Không có ghi chú';

    const subtitle = document.getElementById('modalSubtitle');

    if (subtitle) {
        subtitle.textContent =
            `Ngày nhận: ${formatDate(receipt.received_date || receipt.created_at)}`;
    }

    renderIssueAction(receipt);
    renderReceiptDetailItems(receipt.items || []);
}

/* =========================================================
   ISSUE ACTION
========================================================= */

function renderIssueAction(receipt) {
    const box = document.getElementById('issueActionBox');
    const text = document.getElementById('issueActionText');
    const btn = document.getElementById('btnSendIssueEmail');

    if (!box || !btn) return;

    const hasRejected = Number(receipt.has_rejected_items || 0) === 1;
    const issueStatus = normalizeIssueStatus(receipt);
    const hasSupplierEmail = Boolean(receipt.supplier_email);

    if (!hasRejected) {
        box.classList.add('disabled');
        btn.disabled = true;

        if (text) {
            text.textContent = 'Phiếu này không có hàng lỗi nên không cần gửi email nhà cung cấp.';
        }

        return;
    }

    if (!hasSupplierEmail) {
        box.classList.remove('disabled');
        btn.disabled = true;

        if (text) {
            text.textContent = 'Nhà cung cấp chưa có email, không thể gửi thông báo.';
        }

        return;
    }

    if (issueStatus === 'EMAIL_SENT') {
        box.classList.remove('disabled');
        btn.disabled = true;

        if (text) {
            const sentAt = receipt.issue_email_sent_at
                ? ` lúc ${formatDate(receipt.issue_email_sent_at)}`
                : '';

            text.textContent = `Email thông báo hàng lỗi đã được gửi cho nhà cung cấp${sentAt}.`;
        }

        return;
    }

    if (issueStatus === 'RESOLVED') {
        box.classList.remove('disabled');
        btn.disabled = true;

        if (text) {
            text.textContent = 'Phiếu lỗi này đã được xử lý xong.';
        }

        return;
    }

    box.classList.remove('disabled');
    btn.disabled = false;

    if (text) {
        text.textContent =
            'Phiếu có hàng lỗi và đang chờ xử lý. Bạn có thể gửi email kèm ảnh lỗi cho nhà cung cấp.';
    }
}

async function sendIssueEmail() {
    const receipt = state.currentReceipt;

    if (!receipt) {
        showToast('Chưa chọn phiếu nhập', 'error');
        return;
    }

    const receiptId = getReceiptId(receipt);

    if (!receiptId) {
        showToast('Không xác định được phiếu nhập', 'error');
        return;
    }

    const ok = confirm(
        `Bạn có chắc muốn gửi email thông báo hàng lỗi cho nhà cung cấp "${receipt.supplier_name || ''}" không?`
    );

    if (!ok) return;

    const btn = document.getElementById('btnSendIssueEmail');

    try {
        if (btn) {
            btn.disabled = true;
            btn.innerHTML = `
                <i class="fa-solid fa-spinner fa-spin"></i>
                Đang gửi...
            `;
        }

        const result = await request(`${API.goodsReceipts}/${receiptId}/send-issue-email`, {
            method: 'POST',
            body: JSON.stringify({})
        });

        showToast(
            result.message || 'Đã gửi email cho nhà cung cấp',
            'success'
        );

        await loadReceipts();
        await openReceiptDetail(receiptId);

    } catch (err) {
        showToast('Gửi email thất bại', 'error', err.message);

    } finally {
        if (btn) {
            btn.innerHTML = `
                <i class="fa-solid fa-paper-plane"></i>
                Gửi email NCC
            `;
        }
    }
}

/* =========================================================
   DETAIL ITEMS
========================================================= */

function renderReceiptDetailItems(items = []) {
    const body = document.getElementById('detailTableBody');
    const count = document.getElementById('detailItemCount');

    if (!body) return;

    if (count) {
        count.textContent = `${items.length} sản phẩm trong phiếu`;
    }

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

                <td>
                    <b>${escapeHTML(item.ProductName || '-')}</b>
                </td>

                <td>${escapeHTML(item.SKU || '-')}</td>

                <td>${formatNumber(item.received_quantity)}</td>

                <td>${formatNumber(item.accepted_quantity)}</td>

                <td>
                    <b class="${rejected > 0 ? 'text-red' : ''}">
                        ${formatNumber(rejected)}
                    </b>
                </td>

                <td>${escapeHTML(item.reject_reason || '-')}</td>

                <td>
                    ${renderFaultImages(faultImages)}
                </td>

                <td>${escapeHTML(item.batch_number || '-')}</td>

                <td>${escapeHTML(item.manufacturer_batch || '-')}</td>

                <td>${formatDate(item.expiry_date)}</td>

                <td>${escapeHTML(item.location_rack || '-')}</td>
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
                <a 
                    href="${escapeHTML(url)}" 
                    target="_blank" 
                    class="fault-image-link"
                    title="Xem ảnh lỗi">
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
    document.getElementById('btnReload')?.addEventListener('click', loadReceipts);

    document.getElementById('searchInput')?.addEventListener('input', renderReceipts);

    document.getElementById('rejectedFilter')?.addEventListener('change', renderReceipts);

    document.getElementById('issueStatusFilter')?.addEventListener('change', renderReceipts);

    document.getElementById('btnSendIssueEmail')?.addEventListener('click', sendIssueEmail);

    document.addEventListener('click', e => {
        const btn = e.target.closest('.btn-view-detail');

        if (!btn) return;

        const receiptId = Number(btn.dataset.id);

        if (receiptId) {
            openReceiptDetail(receiptId);
        }
    });

    document.getElementById('btnCloseModal')?.addEventListener('click', closeReceiptDetail);

    document.getElementById('receiptDetailModal')?.addEventListener('click', e => {
        if (e.target.id === 'receiptDetailModal') {
            closeReceiptDetail();
        }
    });
}

/* =========================================================
   INIT
========================================================= */

document.addEventListener('DOMContentLoaded', () => {
    bindEvents();
    loadReceipts();
});