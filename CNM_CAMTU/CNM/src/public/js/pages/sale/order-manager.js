/* =========================================================
   SALE - ORDER MANAGER

   Chức năng:
   - Load + render danh sách đơn hàng từ /api/orders
   - Lọc đơn hàng theo trạng thái / ngày / khách hàng
   - Click dòng đơn hàng để xem chi tiết
   - Hủy đơn hàng PENDING
   - Tạo đơn hàng mới:
     + Chọn khu vực khách hàng
     + Chọn khách hàng
     + Chọn địa chỉ giao hàng bằng API
     + Load danh mục sản phẩm
     + Load sản phẩm
     + Lọc sản phẩm theo danh mục
     + Tìm sản phẩm theo tên hoặc SKU
     + Chọn sản phẩm -> thêm vào danh sách
     + Tính tổng tiền
     + Submit tạo đơn

   Lưu ý:
   - Đã chống double submit.
   - Đã đọc đúng product.category.id, product.category.name, product.unit.name.
   - Nếu EJS chưa có input tìm sản phẩm, JS tự tạo input.
========================================================= */


/* =========================================================
   GLOBAL STATE
========================================================= */

let currentStatusFilter = 'ALL';

let ordersData = [];
let customersData = [];
let productData = [];
let categoryData = [];
let paymentTermData = [];

let provincesData = [];
let districtsData = [];
let wardsData = [];

let selectedOrderItems = [];
let isCreatingOrder = false;

let currentPaymentOrder = null;
let currentPaymentRemainingAmount = 0;
let paymentPollingTimer = null;
let lastSuccessfulPaymentSignature = null;


/* =========================================================
   DOM READY
========================================================= */

document.addEventListener('DOMContentLoaded', () => {
    ensureProductSearchUI();
    ensureAddressPickerUI();
    ensurePaymentStatusColumnUI();

    bindOrderTableEvents();
    bindOrderFilters();
    bindCreateOrderEvents();
    bindPaymentEvents();

    loadOrders();
});


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

function formatCurrency(value) {
    return `${formatNumber(value)} đ`;
}

function normalizeList(payload) {
    if (Array.isArray(payload)) return payload;

    if (Array.isArray(payload?.data)) return payload.data;
    if (Array.isArray(payload?.items)) return payload.items;
    if (Array.isArray(payload?.rows)) return payload.rows;
    if (Array.isArray(payload?.products)) return payload.products;
    if (Array.isArray(payload?.customers)) return payload.customers;
    if (Array.isArray(payload?.categories)) return payload.categories;
    if (Array.isArray(payload?.results)) return payload.results;

    if (Array.isArray(payload?.data?.items)) return payload.data.items;
    if (Array.isArray(payload?.data?.rows)) return payload.data.rows;
    if (Array.isArray(payload?.data?.products)) return payload.data.products;
    if (Array.isArray(payload?.data?.customers)) return payload.data.customers;
    if (Array.isArray(payload?.data?.categories)) return payload.data.categories;
    if (Array.isArray(payload?.data?.data)) return payload.data.data;

    if (Array.isArray(payload?.result)) return payload.result;

    return [];
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

function parseViDate(dateText) {
    if (!dateText) return null;

    const parts = dateText.trim().split('/');

    if (parts.length !== 3) return null;

    const [day, month, year] = parts;
    const date = new Date(`${year}-${month}-${day}`);

    if (Number.isNaN(date.getTime())) return null;

    date.setHours(0, 0, 0, 0);

    return date;
}

function formatDate(value) {
    if (!value) return '---';

    const date = new Date(value);

    if (Number.isNaN(date.getTime())) {
        return '---';
    }

    return date.toLocaleDateString('vi-VN');
}

function setSelectLoading(select, text = 'Đang tải...') {
    if (!select) return;

    select.innerHTML = `
        <option value="">
            -- ${escapeHTML(text)} --
        </option>
    `;
    select.disabled = true;
}

function setSelectEmpty(select, text) {
    if (!select) return;

    select.innerHTML = `
        <option value="">
            -- ${escapeHTML(text)} --
        </option>
    `;
    select.disabled = false;
}


/* =========================================================
   LOAD + RENDER ORDERS FROM API
========================================================= */

async function loadOrders() {
    try {
        const result = await fetchJSON('/api/orders');

        ordersData = normalizeList(result);

        console.log('ORDERS DATA:', ordersData);

        renderOrderStats();
        renderOrderTable(ordersData);

    } catch (err) {
        console.error('LOAD ORDERS ERROR:', err);
        alert('Không tải được danh sách đơn hàng: ' + err.message);
    }
}

function getOrderId(order) {
    return order.order_id ?? order.id ?? order.OrderID;
}

function getOrderCustomerName(order) {
    return (
        order.customer_name ??
        order.company_name ??
        order.customer?.company_name ??
        order.customer?.name ??
        '---'
    );
}

function getOrderCreator(order) {
    return (
        order.created_by_email ??
        order.created_by_name ??
        order.staff_email ??
        order.staff_name ??
        order.user_email ??
        '---'
    );
}

function getOrderCreatedAt(order) {
    return order.created_at ?? order.createdAt ?? order.order_date ?? null;
}

function getOrderTotal(order) {
    return Number(order.total_amount ?? order.totalAmount ?? 0);
}

function getOrderStatus(order) {
    return order.status ?? 'PENDING';
}

function getOrderStatusText(status) {
    const map = {
        PENDING: 'Chờ xử lý',
        SHIPPED: 'Đã vận chuyển',
        SHIPPING: 'Đang giao',
        COMPLETED: 'Hoàn tất',
        CANCELLED: 'Huỷ'
    };

    return map[status] || status;
}

function getOrderPaidAmount(order) {
    return Number(order.paid_amount ?? order.paidAmount ?? 0);
}

function getOrderPaymentStatus(order) {
    const explicitStatus = String(
        order.payment_status ??
        order.paymentStatus ??
        ''
    ).trim().toUpperCase();

    if (explicitStatus) {
        return explicitStatus;
    }

    const totalAmount = getOrderTotal(order);
    const paidAmount = getOrderPaidAmount(order);
    const remainingAmount = getOrderRemainingAmount(order);

    if (totalAmount > 0 && (remainingAmount <= 0 || paidAmount >= totalAmount)) {
        return 'PAID';
    }

    if (paidAmount > 0) {
        return 'PARTIAL';
    }

    return 'UNPAID';
}

function getOrderPaymentStatusText(status) {
    const map = {
        UNPAID: 'Chưa thanh toán',
        PARTIAL: 'Thanh toán một phần',
        PAID: 'Đã thanh toán',
        OVERPAID: 'Thanh toán dư'
    };

    const normalizedStatus = String(status || '').toUpperCase();

    return map[normalizedStatus] || normalizedStatus || '---';
}

function getOrderPaymentStatusBadgeClass(status) {
    const normalizedStatus = String(status || '').toLowerCase();

    return `payment-status-badge payment-status-badge--${normalizedStatus}`;
}

function isOrderFullyPaid(order) {
    const paymentStatus = getOrderPaymentStatus(order);
    const totalAmount = getOrderTotal(order);
    const paidAmount = getOrderPaidAmount(order);
    const remainingAmount = getOrderRemainingAmount(order);

    return (
        paymentStatus === 'PAID' ||
        paymentStatus === 'OVERPAID' ||
        (totalAmount > 0 && (remainingAmount <= 0 || paidAmount >= totalAmount))
    );
}

function ensurePaymentStatusColumnUI() {
    if (!document.getElementById('paymentStatusInlineStyle')) {
        const style = document.createElement('style');

        style.id = 'paymentStatusInlineStyle';
        style.textContent = `
            .payment-status-badge {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                padding: 5px 10px;
                border-radius: 999px;
                font-size: 12px;
                font-weight: 700;
                white-space: nowrap;
            }

            .payment-status-badge--unpaid {
                color: #9a3412;
                background: #ffedd5;
                border: 1px solid #fed7aa;
            }

            .payment-status-badge--partial {
                color: #854d0e;
                background: #fef9c3;
                border: 1px solid #fde68a;
            }

            .payment-status-badge--paid,
            .payment-status-badge--overpaid {
                color: #166534;
                background: #dcfce7;
                border: 1px solid #bbf7d0;
            }

            .payment-done-text {
                display: inline-flex;
                align-items: center;
                gap: 6px;
                color: #166534;
                font-weight: 700;
                font-size: 13px;
                white-space: nowrap;
            }
        `;

        document.head.appendChild(style);
    }

    const body = document.getElementById('orderTableBody');
    const table = body?.closest('table');

    if (!table) return;

    const headerRow = table.querySelector('thead tr');

    if (!headerRow || headerRow.dataset.paymentStatusReady === '1') return;

    const headers = [...headerRow.querySelectorAll('th')];
    const hasPaymentHeader = headers.some(th => {
        return normalizeText(th.textContent).includes('trang thai thanh toan');
    });

    if (!hasPaymentHeader) {
        const actionHeader = headers[headers.length - 1];
        const th = document.createElement('th');

        th.textContent = 'Trạng thái thanh toán';

        if (actionHeader) {
            headerRow.insertBefore(th, actionHeader);
        } else {
            headerRow.appendChild(th);
        }
    }

    headerRow.dataset.paymentStatusReady = '1';
}

function renderOrderStats() {
    const pending = ordersData.filter(o => getOrderStatus(o) === 'PENDING').length;

    const shipped = ordersData.filter(o => {
        const status = getOrderStatus(o);
        return status === 'SHIPPED' || status === 'SHIPPING';
    }).length;

    const completed = ordersData.filter(o => getOrderStatus(o) === 'COMPLETED').length;
    const cancelled = ordersData.filter(o => getOrderStatus(o) === 'CANCELLED').length;

    const revenue = ordersData.reduce((sum, order) => {
        return sum + getOrderTotal(order);
    }, 0);

    const cards = document.querySelectorAll('.stat-card');

    cards.forEach(card => {
        const filter = card.dataset.filter;
        const valueEl = card.querySelector('p');

        if (!valueEl) return;

        if (filter === 'PENDING') {
            valueEl.textContent = `${pending} Đơn`;
        }

        if (filter === 'SHIPPED') {
            valueEl.textContent = `${shipped} Đơn`;
        }

        if (filter === 'COMPLETED') {
            valueEl.textContent = `${completed} Đơn`;
        }

        if (filter === 'CANCELLED') {
            valueEl.textContent = `${cancelled} Đơn`;
        }

        if (filter === 'ALL') {
            valueEl.textContent = `${formatNumber(revenue)} đ`;
        }
    });
}

function renderOrderTable(rows = []) {
    const body = document.getElementById('orderTableBody');

    if (!body) return;

    ensurePaymentStatusColumnUI();

    if (!rows.length) {
        body.innerHTML = `
            <tr>
                <td colspan="8" class="empty-cell">
                    Chưa có đơn hàng nào
                </td>
            </tr>
        `;
        return;
    }

    body.innerHTML = rows.map(order => {
        const orderId = getOrderId(order);
        const status = getOrderStatus(order);
        const paymentStatus = getOrderPaymentStatus(order);
        const fullyPaid = isOrderFullyPaid(order);

        return `
            <tr
                class="order-row"
                data-id="${escapeHTML(orderId)}"
                data-status="${escapeHTML(status)}"
                data-payment-status="${escapeHTML(paymentStatus)}"
            >
                <td>#${escapeHTML(orderId)}</td>

                <td>${escapeHTML(getOrderCustomerName(order))}</td>

                <td>${escapeHTML(getOrderCreator(order))}</td>

                <td>${formatDate(getOrderCreatedAt(order))}</td>

                <td>${formatCurrency(getOrderTotal(order))}</td>

                <td>
                    <span class="badge badge--${escapeHTML(status.toLowerCase())}">
                        ${escapeHTML(getOrderStatusText(status))}
                    </span>
                </td>

                <td>
                    <span class="${escapeHTML(getOrderPaymentStatusBadgeClass(paymentStatus))}">
                        ${escapeHTML(getOrderPaymentStatusText(paymentStatus))}
                    </span>
                    <br>
                    <small style="color:#777;">
                        ${escapeHTML(paymentStatus)}
                    </small>
                </td>

                <td class="action-cell">
                    ${
                        fullyPaid
                            ? `
                                <span class="payment-done-text">
                                    <i class="fa-solid fa-circle-check"></i>
                                    Đã thanh toán đủ
                                </span>
                            `
                            : `
                                <button class="payment-order-btn" data-id="${escapeHTML(orderId)}">
                                    <i class="fa-solid fa-qrcode"></i>
                                    Thanh toán
                                </button>
                            `
                    }

                    ${
                        status === 'PENDING'
                            ? `
                                <button class="cancel-order-btn" data-id="${escapeHTML(orderId)}">
                                    <i class="fa-solid fa-ban"></i>
                                    Hủy
                                </button>
                            `
                            : ''
                    }
                </td>
            </tr>
        `;
    }).join('');
}


/* =========================================================
   ORDER TABLE - DETAIL + CANCEL
========================================================= */

function bindOrderTableEvents() {
    const tableBody = document.getElementById('orderTableBody');
    const modal = document.getElementById('orderModal');
    const closeBtn = document.querySelector('.close');

    if (!tableBody) return;

    tableBody.addEventListener('click', async e => {
        const paymentBtn = e.target.closest('.payment-order-btn');

        if (paymentBtn) {
            e.stopPropagation();
            await openPaymentModal(paymentBtn.dataset.id);
            return;
        }

        const cancelBtn = e.target.closest('.cancel-order-btn');

        if (cancelBtn) {
            e.stopPropagation();
            await cancelOrder(cancelBtn.dataset.id);
            return;
        }

        const row = e.target.closest('.order-row');

        if (!row) return;

        await openOrderDetail(row.dataset.id);
    });

    closeBtn?.addEventListener('click', () => {
        modal?.classList.add('hidden');
    });

    window.addEventListener('click', e => {
        if (e.target === modal) {
            modal.classList.add('hidden');
        }
    });
}

async function openOrderDetail(orderId) {
    const modal = document.getElementById('orderModal');
    const detailBox = document.getElementById('orderDetail');

    if (!modal || !detailBox) return;

    try {
        const order = await fetchJSON(`/api/orders/${orderId}`);

        renderOrderDetailModal(order);

        modal.classList.remove('hidden');

    } catch (err) {
        console.error('FETCH ORDER DETAIL ERROR:', err);
        alert('Không load được chi tiết đơn hàng: ' + err.message);
    }
}

function renderOrderDetailModal(order) {
    const detailBox = document.getElementById('orderDetail');

    if (!detailBox) return;

    const items = Array.isArray(order.items) ? order.items : [];

    const itemsHtml = items.map(item => {
        const productName =
            item.ProductName ??
            item.product_name ??
            item.productName ??
            item.name ??
            'Sản phẩm';

        const sku =
            item.SKU ??
            item.sku ??
            item.Sku ??
            '---';

        const quantity = Number(item.quantity ?? item.Quantity ?? 0);
        const price = Number(item.price ?? item.unit_price ?? item.Price ?? 0);
        const subtotal = Number(item.subtotal ?? quantity * price);

        return `
            <tr>
                <td>${escapeHTML(sku)}</td>
                <td>${escapeHTML(productName)}</td>
                <td>${formatNumber(quantity)}</td>
                <td>${formatCurrency(price)}</td>
                <td>${formatCurrency(subtotal)}</td>
            </tr>
        `;
    }).join('');

    detailBox.innerHTML = `
        <div class="order-detail-info">
            <p><b>Mã đơn:</b> #${escapeHTML(order.order_id ?? order.id ?? '')}</p>
            <p><b>Khách hàng:</b> ${escapeHTML(order.customer_name ?? '---')}</p>
            <p><b>Người tạo:</b> ${escapeHTML(order.created_by_email ?? '---')}</p>
            <p><b>Trạng thái đơn:</b> ${escapeHTML(order.status ?? '---')}</p>
            <p><b>Trạng thái thanh toán:</b> ${escapeHTML(getOrderPaymentStatusText(getOrderPaymentStatus(order)))} (${escapeHTML(getOrderPaymentStatus(order))})</p>
            <p><b>Tổng tiền:</b> ${formatCurrency(order.total_amount)}</p>
            ${
                order.shipping_address
                    ? `<p><b>Địa chỉ giao:</b> ${escapeHTML(order.shipping_address)}</p>`
                    : ''
            }
        </div>

        <hr>

        <h3>Chi tiết sản phẩm</h3>

        <table class="table-detail">
            <thead>
                <tr>
                    <th>SKU</th>
                    <th>Sản phẩm</th>
                    <th>Số lượng</th>
                    <th>Giá</th>
                    <th>Thành tiền</th>
                </tr>
            </thead>

            <tbody>
                ${
                    itemsHtml ||
                    `
                        <tr>
                            <td colspan="5" style="text-align:center; color:#777;">
                                Không có sản phẩm
                            </td>
                        </tr>
                    `
                }
            </tbody>
        </table>
    `;
}

async function cancelOrder(orderId) {
    if (!orderId) return;

    const ok = confirm(`Bạn có chắc chắn muốn hủy đơn hàng #${orderId} không?`);

    if (!ok) return;

    try {
        const result = await fetchJSON(`/api/orders/${orderId}/cancel`, {
            method: 'POST',
            body: JSON.stringify({})
        });

        alert(result.message || 'Hủy đơn hàng thành công!');
        await loadOrders();

    } catch (err) {
        console.error('CANCEL ORDER ERROR:', err);
        alert('Không thể hủy đơn hàng: ' + err.message);
    }
}


/* =========================================================
   PAYMENT FRONTEND
========================================================= */

function getOrderRemainingAmount(order) {
    const explicitRemaining =
        order.remaining_amount ??
        order.remainingAmount ??
        order.unpaid_amount ??
        order.unpaidAmount;

    if (explicitRemaining !== undefined && explicitRemaining !== null) {
        return Math.max(0, Number(explicitRemaining || 0));
    }

    const total = Number(order.total_amount ?? order.totalAmount ?? 0);
    const paid = Number(order.paid_amount ?? order.paidAmount ?? 0);

    return Math.max(0, total - paid);
}

function getPaymentStatusText(status) {
    const map = {
        DRAFT: 'Nháp',
        QR_CREATED: 'Đã tạo QR',
        PENDING: 'Chờ thanh toán',
        CREATED: 'Chờ chuyển khoản',
        PAID: 'Đã thanh toán',
        COMPLETED: 'Hoàn tất',
        EXPIRED: 'Hết hạn',
        CANCELLED: 'Đã hủy',
        FAILED: 'Thất bại'
    };

    return map[String(status || '').toUpperCase()] || status || '---';
}

function bindPaymentEvents() {
    const paymentModal = document.getElementById('paymentModal');
    const closePayment = document.querySelector('.close-payment');
    const createPaymentForm = document.getElementById('createPaymentForm');
    const btnFillRemaining = document.getElementById('btnFillRemainingAmount');
    const btnReloadInstallments = document.getElementById('btnReloadInstallments');

    closePayment?.addEventListener('click', closePaymentModal);

    window.addEventListener('click', e => {
        if (e.target === paymentModal) {
            closePaymentModal();
        }
    });

    createPaymentForm?.addEventListener('submit', createPaymentInstallmentFromForm);

    btnFillRemaining?.addEventListener('click', () => {
        const input = document.getElementById('paymentAmountInput');
        if (input) input.value = Math.round(currentPaymentRemainingAmount || 0);
    });

    btnReloadInstallments?.addEventListener('click', async () => {
        const orderId = document.getElementById('paymentOrderId')?.value;
        if (orderId) await loadPaymentInstallments(orderId);
    });
}

async function openPaymentModal(orderId) {
    const paymentModal = document.getElementById('paymentModal');
    const orderIdInput = document.getElementById('paymentOrderId');
    const qrBox = document.getElementById('paymentQrBox');

    if (!paymentModal || !orderIdInput) return;

    orderIdInput.value = orderId;
    currentPaymentOrder = null;
    currentPaymentRemainingAmount = 0;
    lastSuccessfulPaymentSignature = null;

    if (qrBox) {
        qrBox.className = 'payment-qr-empty';
        qrBox.innerHTML = 'Chọn số tiền rồi bấm <b>Tạo mã QR</b> để khách thanh toán.';
    }

    paymentModal.classList.remove('hidden');

    await Promise.all([
        loadPaymentOrderSummary(orderId),
        loadPaymentInstallments(orderId)
    ]);

    startPaymentPolling(orderId);
}

function closePaymentModal() {
    document.getElementById('paymentModal')?.classList.add('hidden');
    stopPaymentPolling();
}

async function loadPaymentOrderSummary(orderId) {
    const summaryBox = document.getElementById('paymentOrderSummary');
    const amountInput = document.getElementById('paymentAmountInput');

    if (!summaryBox) return;

    summaryBox.innerHTML = 'Đang tải thông tin đơn hàng...';

    try {
        const order = await fetchJSON(`/api/orders/${orderId}`);

        currentPaymentOrder = order;
        currentPaymentRemainingAmount = getOrderRemainingAmount(order);

        if (amountInput) {
            amountInput.value = currentPaymentRemainingAmount > 0
                ? Math.round(currentPaymentRemainingAmount)
                : '';
            amountInput.max = Math.round(currentPaymentRemainingAmount || 0);
        }

        summaryBox.innerHTML = `
            <div class="payment-summary-grid">
                <span>Mã đơn</span>
                <b>#${escapeHTML(order.order_id ?? order.id ?? orderId)}</b>

                <span>Khách hàng</span>
                <b>${escapeHTML(order.customer_name ?? '---')}</b>

                <span>Tổng tiền</span>
                <b>${formatCurrency(order.total_amount)}</b>

                <span>Đã thanh toán</span>
                <b>${formatCurrency(order.paid_amount ?? 0)}</b>

                <span>Còn lại</span>
                <b class="payment-money-danger">${formatCurrency(currentPaymentRemainingAmount)}</b>

                <span>Trạng thái thanh toán</span>
                <b>${escapeHTML(getOrderPaymentStatusText(getOrderPaymentStatus(order)))} (${escapeHTML(getOrderPaymentStatus(order))})</b>
            </div>
        `;

    } catch (err) {
        console.error('LOAD PAYMENT ORDER SUMMARY ERROR:', err);
        summaryBox.innerHTML = `<div class="payment-error">${escapeHTML(err.message)}</div>`;
    }
}

function isSuccessfulPayment(row) {
    const status = String(row.status || row.qr_status || '').toUpperCase();
    return status === 'PAID' || status === 'COMPLETED' || status === 'SUCCESS' || status === 'SUCCESSFUL';
}

function getSuccessfulPaymentSignature(rows) {
    return rows
        .map(row => [
            row.payment_qr_id ?? row.id ?? row.installment_no ?? '',
            row.status ?? row.qr_status ?? '',
            row.paid_amount ?? row.qr_amount ?? row.input_amount ?? row.amount ?? '',
            row.paid_at ?? row.updated_at ?? row.created_at ?? ''
        ].join('|'))
        .join('@@');
}

async function loadPaymentInstallments(orderId, options = {}) {
    const listBox = document.getElementById('paymentInstallmentList');
    const { silent = false, refreshOrder = false } = options;

    if (!listBox) return;

    if (!silent) {
        listBox.innerHTML = 'Đang tải danh sách giao dịch thành công...';
    }

    try {
        const payload = await fetchJSON(`/api/payments/orders/${orderId}/installments`);
        const rows = normalizeList(payload);
        const successfulRows = rows.filter(isSuccessfulPayment);
        const signature = getSuccessfulPaymentSignature(successfulRows);
        const hasChanged = signature !== lastSuccessfulPaymentSignature;

        if (hasChanged || !silent) {
            renderPaymentInstallments(successfulRows);
            lastSuccessfulPaymentSignature = signature;
        }

        if ((hasChanged && successfulRows.length > 0) || refreshOrder) {
            await loadOrders();
            await loadPaymentOrderSummary(orderId);
        }

    } catch (err) {
        console.error('LOAD SUCCESSFUL PAYMENT INSTALLMENTS ERROR:', err);
        if (!silent) {
            listBox.innerHTML = `<div class="payment-error">${escapeHTML(err.message)}</div>`;
        }
    }
}

function renderPaymentInstallments(rows) {
    const listBox = document.getElementById('paymentInstallmentList');

    if (!listBox) return;

    if (!rows.length) {
        listBox.innerHTML = `
            <div class="payment-empty-state">
                Chưa có giao dịch thanh toán thành công nào cho đơn hàng này.
            </div>
        `;
        return;
    }

    listBox.innerHTML = `
        <table class="payment-history-table">
            <thead>
                <tr>
                    <th>Đợt</th>
                    <th>Số tiền đã thanh toán</th>
                    <th>Nội dung CK</th>
                    <th>Trạng thái</th>
                    <th>Ngày ghi nhận</th>
                </tr>
            </thead>
            <tbody>
                ${rows.map(row => `
                    <tr>
                        <td>#${escapeHTML(row.installment_no ?? row.payment_qr_id ?? row.id ?? '---')}</td>
                        <td>${formatCurrency(row.paid_amount ?? row.qr_amount ?? row.input_amount ?? row.amount)}</td>
                        <td><code>${escapeHTML(row.transfer_content ?? row.description ?? '---')}</code></td>
                        <td>
                            <span class="payment-status payment-status--paid">
                                ${escapeHTML(getPaymentStatusText(row.status || row.qr_status))}
                            </span>
                        </td>
                        <td>${formatDate(row.paid_at ?? row.updated_at ?? row.created_at ?? row.expired_at)}</td>
                    </tr>
                `).join('')}
            </tbody>
        </table>
    `;
}

async function createPaymentInstallmentFromForm(e) {
    e.preventDefault();

    const orderId = document.getElementById('paymentOrderId')?.value;
    const amountInput = document.getElementById('paymentAmountInput');
    const btn = document.getElementById('btnCreatePaymentQr');
    const amount = Number(amountInput?.value || 0);

    if (!orderId) {
        alert('Không xác định được đơn hàng cần thanh toán');
        return;
    }

    if (!Number.isFinite(amount) || amount <= 0) {
        alert('Vui lòng nhập số tiền thanh toán hợp lệ');
        amountInput?.focus();
        return;
    }

    if (currentPaymentRemainingAmount > 0 && amount > currentPaymentRemainingAmount) {
        alert(`Số tiền không được vượt quá số còn lại: ${formatCurrency(currentPaymentRemainingAmount)}`);
        amountInput?.focus();
        return;
    }

    try {
        if (btn) {
            btn.disabled = true;
            btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Đang tạo QR...';
        }

        const payload = await fetchJSON(`/api/payments/orders/${orderId}/installments`, {
            method: 'POST',
            body: JSON.stringify({ amount })
        });

        const data = payload.data || payload;

        renderPaymentQr(data);
        await loadPaymentInstallments(orderId, { refreshOrder: true });
        startPaymentPolling(orderId);

    } catch (err) {
        console.error('CREATE PAYMENT QR ERROR:', err);
        alert('Không tạo được mã QR: ' + err.message);
    } finally {
        if (btn) {
            btn.disabled = false;
            btn.innerHTML = '<i class="fa-solid fa-qrcode"></i> Tạo mã QR';
        }
    }
}

function renderPaymentQr(payment) {
    const qrBox = document.getElementById('paymentQrBox');

    if (!qrBox) return;

    const qrUrl = payment.qr_image_url || '';
    const transferContent = payment.transfer_content || '';
    const amount = Number(payment.amount || payment.qr_amount || 0);

    qrBox.className = 'payment-qr-result';
    qrBox.innerHTML = `
        <div class="payment-qr-image-wrap">
            ${
                qrUrl
                    ? `<img src="${escapeHTML(qrUrl)}" alt="QR thanh toán đơn hàng">`
                    : '<div class="payment-empty-state">Không có ảnh QR</div>'
            }
        </div>

        <div class="payment-transfer-info">
            <div>
                <span>Số tiền</span>
                <b>${formatCurrency(amount)}</b>
            </div>

            <div>
                <span>Nội dung chuyển khoản</span>
                <div class="payment-copy-line">
                    <code id="paymentTransferContent">${escapeHTML(transferContent)}</code>
                    <button type="button" class="secondary-btn" onclick="navigator.clipboard?.writeText('${escapeHTML(transferContent)}')">
                        Copy
                    </button>
                </div>
            </div>

            <p class="payment-note">
                Sau khi khách chuyển khoản, bấm <b>Tải lại</b> hoặc đợi hệ thống tự cập nhật trạng thái qua webhook SePay.
            </p>
        </div>
    `;
}

function startPaymentPolling(orderId) {
    stopPaymentPolling();

    paymentPollingTimer = setInterval(() => {
        const modal = document.getElementById('paymentModal');
        if (!modal || modal.classList.contains('hidden')) {
            stopPaymentPolling();
            return;
        }

        loadPaymentInstallments(orderId, { silent: true });
    }, 7000);
}

function stopPaymentPolling() {
    if (paymentPollingTimer) {
        clearInterval(paymentPollingTimer);
        paymentPollingTimer = null;
    }
}


/* =========================================================
   ORDER FILTERS
========================================================= */

function bindOrderFilters() {
    const statCards = document.querySelectorAll('.stat-card');
    const startDateInput = document.getElementById('filterStartDate');
    const endDateInput = document.getElementById('filterEndDate');
    const customerInput = document.getElementById('filterCustomerInput');
    const btnClearFilters = document.getElementById('btnClearFilters');

    statCards.forEach(card => {
        card.addEventListener('click', () => {
            currentStatusFilter = card.dataset.filter || 'ALL';
            applyOrderFilters();
        });
    });

    startDateInput?.addEventListener('change', applyOrderFilters);
    endDateInput?.addEventListener('change', applyOrderFilters);
    customerInput?.addEventListener('input', applyOrderFilters);

    btnClearFilters?.addEventListener('click', () => {
        if (startDateInput) startDateInput.value = '';
        if (endDateInput) endDateInput.value = '';
        if (customerInput) customerInput.value = '';

        currentStatusFilter = 'ALL';

        applyOrderFilters();
    });
}

function applyOrderFilters() {
    const rows = document.querySelectorAll('.order-row');

    const startDateInput = document.getElementById('filterStartDate');
    const endDateInput = document.getElementById('filterEndDate');
    const customerInput = document.getElementById('filterCustomerInput');

    const startDate = startDateInput?.value ? new Date(startDateInput.value) : null;
    const endDate = endDateInput?.value ? new Date(endDateInput.value) : null;
    const customerKeyword = customerInput?.value.trim().toLowerCase() || '';

    if (startDate) {
        startDate.setHours(0, 0, 0, 0);
    }

    if (endDate) {
        endDate.setHours(23, 59, 59, 999);
    }

    rows.forEach(row => {
        const rowStatus = row.dataset.status || '';

        const rowCustomer =
            row.querySelector('td:nth-child(2)')?.textContent.trim().toLowerCase() || '';

        const rowDateText =
            row.querySelector('td:nth-child(4)')?.textContent.trim() || '';

        const rowDate = parseViDate(rowDateText);

        const matchStatus =
            currentStatusFilter === 'ALL' ||
            rowStatus === currentStatusFilter;

        const matchCustomer =
            !customerKeyword ||
            rowCustomer.includes(customerKeyword);

        let matchDate = true;

        if (rowDate) {
            if (startDate && endDate) {
                matchDate = rowDate >= startDate && rowDate <= endDate;
            } else if (startDate && !endDate) {
                matchDate = rowDate.getTime() === startDate.getTime();
            } else if (!startDate && endDate) {
                matchDate = rowDate <= endDate;
            }
        }

        row.style.display =
            matchStatus && matchCustomer && matchDate
                ? ''
                : 'none';
    });
}


/* =========================================================
   CREATE ORDER - EVENTS
========================================================= */

function bindCreateOrderEvents() {
    const openCreateBtn = document.getElementById('openCreateOrder');
    const createModal = document.getElementById('createOrderModal');
    const closeCreateBtns = document.querySelectorAll('.close-create');

    ensureAddressPickerUI();
    ensureProductSearchUI();

    openCreateBtn?.addEventListener('click', async () => {
        createModal?.classList.remove('hidden');

        resetCreateOrderForm();
        ensureAddressPickerUI();
        ensureProductSearchUI();

        await Promise.all([
            loadCustomers(),
            loadProductsForOrder(),
            loadPaymentTermsForOrder(),
            loadProvinces()
        ]);

        fillRegionSelect();
        fillCustomerSelect();
        fillPaymentTermSelect();
        fillOrderProductSelect();

        renderSelectedProductTable();
        calculateOrderTotal();
        updateShippingAddressValue();
    });

    closeCreateBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            createModal?.classList.add('hidden');
        });
    });

    window.addEventListener('click', e => {
        if (e.target === createModal) {
            createModal.classList.add('hidden');
        }
    });

    document.getElementById('regionSelect')?.addEventListener('change', () => {
        fillCustomerSelect();
    });

    document.getElementById('customerSelect')?.addEventListener('change', () => {
        const shippingInput = document.getElementById('shippingAddressInput');

        if (shippingInput) {
            shippingInput.value = '';
        }

        resetAddressPickerOnly();
    });

    document.getElementById('paymentTermTemplateSelect')?.addEventListener('change', () => {
        renderPaymentTermHint();
    });

    document.getElementById('orderProductSearchInput')?.addEventListener('input', () => {
        fillOrderProductSelect();
    });

    document.getElementById('addSelectedProductBtn')?.addEventListener('click', () => {
        addSelectedProductToOrder();
    });

    document.getElementById('orderProductQuantity')?.addEventListener('keydown', e => {
        if (['-', '+', 'e', '.', ','].includes(e.key)) {
            e.preventDefault();
        }
    });

    document.getElementById('orderProductQuantity')?.addEventListener('blur', e => {
        const value = Number(e.target.value || 0);

        if (!Number.isInteger(value) || value <= 0) {
            e.target.value = 1;
        }
    });

    document.getElementById('selectedProductTableBody')?.addEventListener('input', e => {
        const input = e.target.closest('.selected-qty-input');

        if (!input) return;

        const productId = Number(input.dataset.id);
        let quantity = Number(input.value || 0);

        if (!Number.isInteger(quantity) || quantity <= 0) {
            quantity = 1;
            input.value = 1;
        }

        const item = selectedOrderItems.find(row => {
            return Number(row.product_id) === productId;
        });

        if (!item) return;

        item.quantity = quantity;

        renderSelectedProductTable();
        calculateOrderTotal();
    });

    document.getElementById('selectedProductTableBody')?.addEventListener('keydown', e => {
        if (
            e.target.classList.contains('selected-qty-input') &&
            ['-', '+', 'e', '.', ','].includes(e.key)
        ) {
            e.preventDefault();
        }
    });

    document.getElementById('selectedProductTableBody')?.addEventListener('click', e => {
        const btn = e.target.closest('.remove-selected-product-btn');

        if (!btn) return;

        const productId = Number(btn.dataset.id);

        selectedOrderItems = selectedOrderItems.filter(item => {
            return Number(item.product_id) !== productId;
        });

        renderSelectedProductTable();
        calculateOrderTotal();
    });

    document.getElementById('createOrderForm')?.addEventListener('submit', submitCreateOrderForm);
}


/* =========================================================
   PRODUCT SEARCH UI
========================================================= */

function ensureProductSearchUI() {
    if (document.getElementById('orderProductSearchInput')) {
        return;
    }

    const productSelect = document.getElementById('orderProductSelect');

    if (!productSelect) return;

    const productSelectGroup = productSelect.closest('.form-group');

    if (!productSelectGroup) return;

    const searchGroup = document.createElement('div');
    searchGroup.className = 'form-group product-search-group';

    searchGroup.innerHTML = `
        <label>Tìm sản phẩm / SKU</label>
        <input
            type="text"
            id="orderProductSearchInput"
            placeholder="Nhập tên sản phẩm hoặc mã SKU..."
            autocomplete="off"
        >
    `;

    productSelectGroup.parentNode.insertBefore(searchGroup, productSelectGroup);
}


/* =========================================================
   CREATE ORDER - RESET
========================================================= */

function resetCreateOrderForm() {
    const form = document.getElementById('createOrderForm');

    form?.reset();

    selectedOrderItems = [];

    const regionSelect = document.getElementById('regionSelect');
    const customerSelect = document.getElementById('customerSelect');
    const paymentTermSelect = document.getElementById('paymentTermTemplateSelect');
    const paymentTermHint = document.getElementById('paymentTermHint');
    const productSearchInput = document.getElementById('orderProductSearchInput');
    const productSelect = document.getElementById('orderProductSelect');
    const quantityInput = document.getElementById('orderProductQuantity');
    const shippingInput = document.getElementById('shippingAddressInput');

    if (regionSelect) {
        regionSelect.innerHTML = '<option value="">-- Tất cả khu vực --</option>';
    }

    if (customerSelect) {
        customerSelect.innerHTML = '<option value="">-- Chọn khách hàng --</option>';
    }

    if (paymentTermSelect) {
        paymentTermSelect.innerHTML = '<option value="">-- Chọn chương trình khuyến mãi --</option>';
    }

    if (paymentTermHint) {
        paymentTermHint.innerHTML = 'Chọn chương trình để lưu chính sách thanh toán cho đơn hàng.';
    }

    if (productSearchInput) {
        productSearchInput.value = '';
    }

    if (productSelect) {
        productSelect.innerHTML = '<option value="">-- Chọn sản phẩm --</option>';
    }

    if (quantityInput) {
        quantityInput.value = 1;
    }

    if (shippingInput) {
        shippingInput.value = '';
        shippingInput.readOnly = true;
        shippingInput.placeholder = 'Địa chỉ sẽ tự ghép từ số nhà, phường/xã, quận/huyện, tỉnh/thành';
    }

    resetAddressPickerOnly();

    renderSelectedProductTable();
    calculateOrderTotal();
}


/* =========================================================
   CREATE ORDER - CUSTOMERS
========================================================= */

async function loadCustomers() {
    try {
        const result = await fetchJSON('/api/sale/customers');

        customersData = result.customers || normalizeList(result);

        console.log('CUSTOMERS DATA:', customersData);

    } catch (err) {
        customersData = [];
        console.error('LOAD CUSTOMERS ERROR:', err);
        alert('Không load được danh sách khách hàng: ' + err.message);
    }
}

function getCustomerId(customer) {
    return (
        customer.customer_id ??
        customer.CustomerID ??
        customer.id
    );
}

function getCustomerName(customer) {
    return (
        customer.company_name ??
        customer.customer_name ??
        customer.full_name ??
        customer.name ??
        'Không tên'
    );
}

function getCustomerAddress(customer) {
    return (
        customer.address ??
        customer.company_address ??
        customer.shipping_address ??
        ''
    );
}

function getCustomerRegion(customer) {
    const address = getCustomerAddress(customer);

    if (!address) return '';

    const parts = address.split(',');
    const region = parts[parts.length - 1]?.trim();

    return region || '';
}

function fillRegionSelect() {
    const regionSelect = document.getElementById('regionSelect');

    if (!regionSelect) return;

    const regions = new Set();

    customersData.forEach(customer => {
        const region = getCustomerRegion(customer);

        if (region) {
            regions.add(region);
        }
    });

    regionSelect.innerHTML = `
        <option value="">-- Tất cả khu vực --</option>
        ${
            [...regions]
                .sort((a, b) => a.localeCompare(b, 'vi'))
                .map(region => `
                    <option value="${escapeHTML(region)}">
                        ${escapeHTML(region)}
                    </option>
                `)
                .join('')
        }
    `;
}

function fillCustomerSelect() {
    const regionSelect = document.getElementById('regionSelect');
    const customerSelect = document.getElementById('customerSelect');

    if (!customerSelect) return;

    const selectedRegion = regionSelect?.value || '';

    const filteredCustomers = customersData.filter(customer => {
        if (!selectedRegion) return true;

        return getCustomerAddress(customer).includes(selectedRegion);
    });

    customerSelect.innerHTML = `
        <option value="">-- Chọn khách hàng --</option>
        ${
            filteredCustomers
                .map(customer => `
                    <option value="${escapeHTML(getCustomerId(customer))}">
                        ${escapeHTML(getCustomerName(customer))}
                    </option>
                `)
                .join('')
        }
    `;
}


/* =========================================================
   CREATE ORDER - PAYMENT TERM / PROMOTION PROGRAM
========================================================= */

async function loadPaymentTermsForOrder() {
    try {
        const result = await fetchJSON('/api/payment-terms');

        paymentTermData = normalizeList(result);

        console.log('PAYMENT TERM API RESULT:', result);
        console.log('PAYMENT TERM DATA:', paymentTermData);

    } catch (err) {
        paymentTermData = [];
        console.error('LOAD PAYMENT TERMS ERROR:', err);
        alert('Không load được chương trình khuyến mãi: ' + err.message);
    }
}

function getPaymentTermId(term) {
    return (
        term.payment_term_template_id ??
        term.PaymentTermTemplateID ??
        term.paymentTermTemplateId ??
        term.id
    );
}

function getPaymentTermName(term) {
    return (
        term.term_name ??
        term.program_name ??
        term.name ??
        'Chương trình không tên'
    );
}

function getPaymentTermCreditDays(term) {
    return Number(term.credit_days ?? term.creditDays ?? 0);
}

function getPaymentTermEarlyRate(term) {
    return Number(
        term.early_commission_rate_per_day ??
        term.earlyCommissionRatePerDay ??
        0
    );
}

function getPaymentTermLateRate(term) {
    return Number(
        term.late_interest_rate_per_day ??
        term.lateInterestRatePerDay ??
        0
    );
}

function findPaymentTermById(termId) {
    return paymentTermData.find(term => {
        return String(getPaymentTermId(term)) === String(termId);
    });
}

function formatPercent(value) {
    const number = Number(value || 0);

    if (!Number.isFinite(number)) {
        return '0%';
    }

    return `${number.toLocaleString('vi-VN')}%`;
}

function buildPaymentTermLabel(term) {
    const name = getPaymentTermName(term);
    const creditDays = getPaymentTermCreditDays(term);
    const earlyRate = getPaymentTermEarlyRate(term);
    const lateRate = getPaymentTermLateRate(term);

    const parts = [name];

    if (creditDays > 0) {
        parts.push(`${creditDays} ngày công nợ`);
    }

    if (earlyRate > 0) {
        parts.push(`hoa hồng sớm ${formatPercent(earlyRate)}/ngày`);
    }

    if (lateRate > 0) {
        parts.push(`phạt trễ ${formatPercent(lateRate)}/ngày`);
    }

    return parts.join(' - ');
}

function fillPaymentTermSelect() {
    const select = document.getElementById('paymentTermTemplateSelect');

    if (!select) return;

    if (!paymentTermData.length) {
        select.innerHTML = '<option value="">-- Không có chương trình khuyến mãi --</option>';
        renderPaymentTermHint();
        return;
    }

    select.innerHTML = `
        <option value="">-- Chọn chương trình khuyến mãi --</option>
        ${
            paymentTermData.map(term => `
                <option value="${escapeHTML(getPaymentTermId(term))}">
                    ${escapeHTML(buildPaymentTermLabel(term))}
                </option>
            `).join('')
        }
    `;

    renderPaymentTermHint();
}

function renderPaymentTermHint() {
    const select = document.getElementById('paymentTermTemplateSelect');
    const hint = document.getElementById('paymentTermHint');

    if (!hint) return;

    const termId = select?.value || '';
    const term = termId ? findPaymentTermById(termId) : null;

    if (!term) {
        hint.innerHTML = 'Chọn chương trình để lưu chính sách thanh toán cho đơn hàng.';
        return;
    }

    const creditDays = getPaymentTermCreditDays(term);
    const earlyRate = getPaymentTermEarlyRate(term);
    const lateRate = getPaymentTermLateRate(term);
    const description = term.description || '';

    hint.innerHTML = `
        <div class="payment-term-preview">
            <b>${escapeHTML(getPaymentTermName(term))}</b>
            <span>Công nợ: ${escapeHTML(creditDays)} ngày</span>
            <span>Hoa hồng trả sớm: ${escapeHTML(formatPercent(earlyRate))}/ngày</span>
            <span>Lãi phạt trả trễ: ${escapeHTML(formatPercent(lateRate))}/ngày</span>
            ${description ? `<small>${escapeHTML(description)}</small>` : ''}
        </div>
    `;
}


/* =========================================================
   ADDRESS PICKER
========================================================= */

function ensureAddressPickerUI() {
    const houseInput = document.getElementById('shippingHouseNumberInput');
    const provinceSelect = document.getElementById('shippingProvinceSelect');
    const districtSelect = document.getElementById('shippingDistrictSelect');
    const wardSelect = document.getElementById('shippingWardSelect');
    const shippingInput = document.getElementById('shippingAddressInput');

    if (!houseInput || !provinceSelect || !districtSelect || !wardSelect || !shippingInput) {
        console.warn('Thiếu input/select địa chỉ trong EJS');
        return;
    }

    shippingInput.readOnly = true;
    shippingInput.placeholder = 'Địa chỉ sẽ tự ghép sau khi chọn đầy đủ';

    bindAddressPickerEvents();
}

function bindAddressPickerEvents() {
    const houseInput = document.getElementById('shippingHouseNumberInput');
    const provinceSelect = document.getElementById('shippingProvinceSelect');
    const districtSelect = document.getElementById('shippingDistrictSelect');
    const wardSelect = document.getElementById('shippingWardSelect');

    if (houseInput && !houseInput.dataset.bound) {
        houseInput.addEventListener('input', updateShippingAddressValue);
        houseInput.dataset.bound = '1';
    }

    if (provinceSelect && !provinceSelect.dataset.bound) {
        provinceSelect.addEventListener('change', async () => {
            await onProvinceChange();
        });
        provinceSelect.dataset.bound = '1';
    }

    if (districtSelect && !districtSelect.dataset.bound) {
        districtSelect.addEventListener('change', async () => {
            await onDistrictChange();
        });
        districtSelect.dataset.bound = '1';
    }

    if (wardSelect && !wardSelect.dataset.bound) {
        wardSelect.addEventListener('change', () => {
            updateShippingAddressValue();
        });
        wardSelect.dataset.bound = '1';
    }
}

function resetAddressPickerOnly() {
    const houseInput = document.getElementById('shippingHouseNumberInput');
    const provinceSelect = document.getElementById('shippingProvinceSelect');
    const districtSelect = document.getElementById('shippingDistrictSelect');
    const wardSelect = document.getElementById('shippingWardSelect');

    if (houseInput) {
        houseInput.value = '';
    }

    if (provinceSelect) {
        provinceSelect.value = '';
    }

    setSelectEmpty(districtSelect, 'Chọn quận / huyện');
    if (districtSelect) districtSelect.disabled = true;

    setSelectEmpty(wardSelect, 'Chọn phường / xã');
    if (wardSelect) wardSelect.disabled = true;

    updateShippingAddressValue();
}

async function loadProvinces() {
    const provinceSelect = document.getElementById('shippingProvinceSelect');

    if (!provinceSelect) return;

    try {
        setSelectLoading(provinceSelect, 'Đang tải tỉnh / thành phố');

        const result = await fetchJSON('/api/address/provinces');

        provincesData = normalizeList(result);

        provinceSelect.innerHTML = `
            <option value="">-- Chọn tỉnh / thành phố --</option>
            ${
                provincesData.map(province => `
                    <option
                        value="${escapeHTML(province.code)}"
                        data-name="${escapeHTML(province.name)}"
                    >
                        ${escapeHTML(province.name)}
                    </option>
                `).join('')
            }
        `;

        provinceSelect.disabled = false;

    } catch (err) {
        provincesData = [];
        console.error('LOAD PROVINCES ERROR:', err);
        setSelectEmpty(provinceSelect, 'Không tải được tỉnh / thành phố');
    }
}

async function onProvinceChange() {
    const provinceSelect = document.getElementById('shippingProvinceSelect');
    const districtSelect = document.getElementById('shippingDistrictSelect');
    const wardSelect = document.getElementById('shippingWardSelect');

    const provinceId = provinceSelect?.value || '';

    districtsData = [];
    wardsData = [];

    setSelectEmpty(districtSelect, 'Chọn quận / huyện');
    if (districtSelect) districtSelect.disabled = true;

    setSelectEmpty(wardSelect, 'Chọn phường / xã');
    if (wardSelect) wardSelect.disabled = true;

    updateShippingAddressValue();

    if (!provinceId) return;

    try {
        setSelectLoading(districtSelect, 'Đang tải quận / huyện');

        const result = await fetchJSON(`/api/address/districts/${provinceId}`);

        districtsData = normalizeList(result);

        districtSelect.innerHTML = `
            <option value="">-- Chọn quận / huyện --</option>
            ${
                districtsData.map(district => `
                    <option
                        value="${escapeHTML(district.code)}"
                        data-name="${escapeHTML(district.name)}"
                    >
                        ${escapeHTML(district.name)}
                    </option>
                `).join('')
            }
        `;

        districtSelect.disabled = false;

    } catch (err) {
        districtsData = [];
        console.error('LOAD DISTRICTS ERROR:', err);
        setSelectEmpty(districtSelect, 'Không tải được quận / huyện');
    }
}

async function onDistrictChange() {
    const districtSelect = document.getElementById('shippingDistrictSelect');
    const wardSelect = document.getElementById('shippingWardSelect');

    const districtId = districtSelect?.value || '';

    wardsData = [];

    setSelectEmpty(wardSelect, 'Chọn phường / xã');
    if (wardSelect) wardSelect.disabled = true;

    updateShippingAddressValue();

    if (!districtId) return;

    try {
        setSelectLoading(wardSelect, 'Đang tải phường / xã');

        const result = await fetchJSON(`/api/address/wards/${districtId}`);

        wardsData = normalizeList(result);

        wardSelect.innerHTML = `
            <option value="">-- Chọn phường / xã --</option>
            ${
                wardsData.map(ward => `
                    <option
                        value="${escapeHTML(ward.code)}"
                        data-name="${escapeHTML(ward.name)}"
                    >
                        ${escapeHTML(ward.name)}
                    </option>
                `).join('')
            }
        `;

        wardSelect.disabled = false;

    } catch (err) {
        wardsData = [];
        console.error('LOAD WARDS ERROR:', err);
        setSelectEmpty(wardSelect, 'Không tải được phường / xã');
    }
}

function getSelectedOptionName(selectId) {
    const select = document.getElementById(selectId);

    if (!select || !select.value) return '';

    const option = select.options[select.selectedIndex];

    return option?.dataset?.name || option?.textContent?.trim() || '';
}

function updateShippingAddressValue() {
    const houseInput = document.getElementById('shippingHouseNumberInput');
    const shippingInput = document.getElementById('shippingAddressInput');

    if (!shippingInput) return;

    const houseNumber = houseInput?.value.trim() || '';
    const wardName = getSelectedOptionName('shippingWardSelect');
    const districtName = getSelectedOptionName('shippingDistrictSelect');
    const provinceName = getSelectedOptionName('shippingProvinceSelect');

    const parts = [
        houseNumber,
        wardName,
        districtName,
        provinceName
    ].filter(Boolean);

    shippingInput.value = parts.join(', ');
}

function validateShippingAddressPicker() {
    const houseInput = document.getElementById('shippingHouseNumberInput');
    const provinceSelect = document.getElementById('shippingProvinceSelect');
    const districtSelect = document.getElementById('shippingDistrictSelect');
    const wardSelect = document.getElementById('shippingWardSelect');

    if (!houseInput?.value.trim()) {
        houseInput?.focus();
        throw new Error('Vui lòng nhập số nhà / tên đường');
    }

    if (!provinceSelect?.value) {
        provinceSelect?.focus();
        throw new Error('Vui lòng chọn tỉnh / thành phố');
    }

    if (!districtSelect?.value) {
        districtSelect?.focus();
        throw new Error('Vui lòng chọn quận / huyện');
    }

    if (!wardSelect?.value) {
        wardSelect?.focus();
        throw new Error('Vui lòng chọn phường / xã');
    }

    updateShippingAddressValue();

    const shippingAddress = document.getElementById('shippingAddressInput')?.value.trim();

    if (!shippingAddress) {
        throw new Error('Địa chỉ giao hàng không hợp lệ');
    }

    return shippingAddress;
}


/* =========================================================
   CREATE ORDER - CATEGORIES
========================================================= */

async function loadCategoriesForOrder() {
    try {
        const result = await fetchJSON('/api/products/categories');

        categoryData = normalizeList(result);

        console.log('CATEGORY API RESULT:', result);
        console.log('CATEGORY DATA:', categoryData);

    } catch (err) {
        categoryData = [];
        console.error('LOAD CATEGORIES ERROR:', err);
        alert('Không load được danh mục sản phẩm: ' + err.message);
    }
}

function getCategoryId(category) {
    return String(
        category.CategoryID ??
        category.CategoryId ??
        category.category_id ??
        category.categoryId ??
        category.id ??
        ''
    ).trim();
}

function getCategoryName(category) {
    return String(
        category.CategoryName ??
        category.category_name ??
        category.categoryName ??
        category.name ??
        'Không tên'
    ).trim();
}

function findCategoryNameById(categoryId) {
    const found = categoryData.find(category => {
        return getCategoryId(category) === String(categoryId);
    });

    return found ? getCategoryName(found) : '';
}


/* =========================================================
   CREATE ORDER - PRODUCTS
========================================================= */

async function loadProductsForOrder() {
    try {
        const result = await fetchJSON('/api/products?limit=500');

        productData = normalizeList(result);

        console.log('PRODUCT API RESULT:', result);
        console.log('PRODUCT DATA:', productData);
        console.table(productData.map(p => ({
            id: getProductId(p),
            sku: getProductSKU(p),
            name: getProductName(p),
            categoryId: getProductCategoryId(p),
            categoryName: getProductCategoryName(p)
        })));

        if (!productData.length) {
            alert('API sản phẩm không trả về danh sách sản phẩm. Kiểm tra /api/products?limit=500');
        }

    } catch (err) {
        productData = [];
        console.error('LOAD PRODUCTS ERROR:', err);
        alert('Không load được sản phẩm: ' + err.message);
    }
}

function getProductId(product) {
    return (
        product.ProductID ??
        product.ProductId ??
        product.product_id ??
        product.productId ??
        product.id
    );
}

function getProductName(product) {
    return (
        product.ProductName ??
        product.product_name ??
        product.productName ??
        product.name ??
        'Sản phẩm không tên'
    );
}

function normalizeText(value) {
    return String(value ?? '')
        .trim()
        .toLowerCase()
        .normalize('NFD')
        .replace(/[\u0300-\u036f]/g, '')
        .replace(/đ/g, 'd')
        .replace(/\s+/g, ' ');
}

function getProductSKU(product) {
    return (
        product.SKU ??
        product.sku ??
        product.Sku ??
        product.ProductSKU ??
        product.product_sku ??
        product.productSku ??
        product.ProductCode ??
        product.product_code ??
        product.productCode ??
        product.Code ??
        product.code ??
        product.ItemCode ??
        product.item_code ??
        product.ItemSKU ??
        product.item_sku ??
        product.Barcode ??
        product.barcode ??
        'NO-SKU'
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
        product.SalePrice ??
        product.sale_price ??
        product.OutputPrice ??
        product.output_price ??
        0
    );
}

function getProductCategoryId(product) {
    return String(
        product.CategoryID ??
        product.CategoryId ??
        product.category_id ??
        product.categoryId ??
        product.categoryID ??
        product.ProductCategoryID ??
        product.product_category_id ??
        product.productCategoryId ??
        product.Category?.CategoryID ??
        product.Category?.CategoryId ??
        product.Category?.id ??
        product.category?.CategoryID ??
        product.category?.CategoryId ??
        product.category?.category_id ??
        product.category?.categoryId ??
        product.category?.id ??
        product.product_category?.id ??
        product.product_category?.category_id ??
        product.productCategory?.id ??
        product.productCategory?.category_id ??
        ''
    ).trim();
}

function getProductCategoryName(product) {
    const directName = String(
        product.CategoryName ??
        product.category_name ??
        product.categoryName ??
        product.ProductCategoryName ??
        product.product_category_name ??
        product.productCategoryName ??
        product.Category?.CategoryName ??
        product.Category?.category_name ??
        product.Category?.categoryName ??
        product.Category?.Name ??
        product.Category?.name ??
        product.category?.CategoryName ??
        product.category?.category_name ??
        product.category?.categoryName ??
        product.category?.Name ??
        product.category?.name ??
        product.product_category?.name ??
        product.product_category?.category_name ??
        product.productCategory?.name ??
        product.productCategory?.category_name ??
        ''
    ).trim();

    if (directName && directName !== '[object Object]') {
        return directName;
    }

    if (typeof product.Category === 'string') {
        return product.Category.trim();
    }

    if (typeof product.category === 'string') {
        return product.category.trim();
    }

    const categoryId = getProductCategoryId(product);

    return findCategoryNameById(categoryId) || 'Chưa phân loại';
}

function getProductBrand(product) {
    return (
        product.Brand ??
        product.brand ??
        product.Manufacturer ??
        product.manufacturer ??
        product.SupplierName ??
        product.supplier_name ??
        '---'
    );
}

function getProductUnit(product) {
    const unitName =
        product.UnitName ??
        product.unit_name ??
        product.unitName ??
        product.Unit?.Name ??
        product.Unit?.name ??
        product.unit?.Name ??
        product.unit?.name;

    if (unitName) {
        return String(unitName);
    }

    if (typeof product.unit === 'string') {
        return product.unit;
    }

    if (typeof product.Unit === 'string') {
        return product.Unit;
    }

    return '---';
}

function fillOrderCategorySelect() {
    // Đã bỏ chọn theo danh mục trong form tạo đơn.
    // Giữ hàm rỗng để không lỗi nếu file EJS cũ vẫn còn select này.
}

function fillOrderProductSelect() {
    const productSelect = document.getElementById('orderProductSelect');
    const productSearchInput = document.getElementById('orderProductSearchInput');

    if (!productSelect) {
        console.error('Không tìm thấy #orderProductSelect trong EJS');
        return;
    }

    const keyword = normalizeText(productSearchInput?.value || '');

    let filteredProducts = productData.filter(product => {
        const productId = getProductId(product);

        if (!productId) return false;

        const sku = normalizeText(getProductSKU(product));
        const name = normalizeText(getProductName(product));
        const categoryName = normalizeText(getProductCategoryName(product));
        const brand = normalizeText(getProductBrand(product));

        return !keyword ||
            sku.includes(keyword) ||
            name.includes(keyword) ||
            categoryName.includes(keyword) ||
            brand.includes(keyword);
    });

    filteredProducts = filteredProducts.sort((a, b) => {
        const skuA = String(getProductSKU(a)).toLowerCase();
        const skuB = String(getProductSKU(b)).toLowerCase();

        return skuA.localeCompare(skuB, 'vi');
    });

    if (!filteredProducts.length) {
        productSelect.innerHTML = `
            <option value="">-- Không có sản phẩm phù hợp --</option>
        `;
        return;
    }

    productSelect.innerHTML = `
        <option value="">-- Chọn sản phẩm --</option>
        ${
            filteredProducts.map(product => {
                const id = getProductId(product);
                const sku = getProductSKU(product);
                const name = getProductName(product);
                const categoryName = getProductCategoryName(product);
                const price = getProductPrice(product);
                const unit = getProductUnit(product);

                return `
                    <option value="${escapeHTML(id)}">
                        ${escapeHTML(sku)} - ${escapeHTML(name)} - ${escapeHTML(categoryName)} - ${formatCurrency(price)} / ${escapeHTML(unit)}
                    </option>
                `;
            }).join('')
        }
    `;
}

/* =========================================================
   CREATE ORDER - SELECTED PRODUCTS
========================================================= */

function addSelectedProductToOrder() {
    const productSelect = document.getElementById('orderProductSelect');
    const quantityInput = document.getElementById('orderProductQuantity');
    const productSearchInput = document.getElementById('orderProductSearchInput');

    if (!productSelect) {
        alert('Không tìm thấy ô chọn sản phẩm. Kiểm tra id="orderProductSelect" trong EJS');
        return;
    }

    if (!quantityInput) {
        alert('Không tìm thấy ô số lượng. Kiểm tra id="orderProductQuantity" trong EJS');
        return;
    }

    const productId = Number(productSelect.value || 0);
    const quantity = Number(quantityInput.value || 0);

    if (!productId) {
        alert('Vui lòng chọn sản phẩm');
        productSelect.focus();
        return;
    }

    if (!Number.isInteger(quantity) || quantity <= 0) {
        alert('Số lượng phải là số nguyên lớn hơn 0');
        quantityInput.focus();
        return;
    }

    const product = productData.find(item => {
        return Number(getProductId(item)) === productId;
    });

    if (!product) {
        console.log('PRODUCT DATA:', productData);
        console.log('PRODUCT ID SELECTED:', productId);
        alert('Sản phẩm không hợp lệ hoặc không tìm thấy trong danh sách API');
        return;
    }

    const price = getProductPrice(product);

    if (price < 0 || Number.isNaN(price)) {
        alert('Giá sản phẩm không hợp lệ');
        return;
    }

    const existed = selectedOrderItems.find(item => {
        return Number(item.product_id) === productId;
    });

    if (existed) {
        existed.quantity += quantity;
    } else {
        selectedOrderItems.push({
            product_id: productId,
            sku: getProductSKU(product),
            name: getProductName(product),
            category: getProductCategoryName(product),
            brand: getProductBrand(product),
            unit: getProductUnit(product),
            price,
            quantity
        });
    }

    quantityInput.value = 1;
    productSelect.value = '';

    if (productSearchInput) {
        productSearchInput.value = '';
    }

    fillOrderProductSelect();
    renderSelectedProductTable();
    calculateOrderTotal();

    console.log('SELECTED ORDER ITEMS:', selectedOrderItems);
}

function renderSelectedProductTable() {
    const body = document.getElementById('selectedProductTableBody');

    if (!body) return;

    if (!selectedOrderItems.length) {
        body.innerHTML = `
            <tr>
                <td colspan="8" style="text-align:center; color:#777; padding:12px;">
                    Chưa chọn sản phẩm nào
                </td>
            </tr>
        `;
        return;
    }

    body.innerHTML = selectedOrderItems.map((item, index) => {
        const subtotal = Number(item.price || 0) * Number(item.quantity || 0);

        return `
            <tr>
                <td>${index + 1}</td>

                <td>
                    <b>${escapeHTML(item.sku)}</b>
                </td>

                <td>
                    <b>${escapeHTML(item.name)}</b>
                    <br>
                    <small>
                        Thương hiệu: ${escapeHTML(item.brand || '---')}
                        |
                        Đơn vị: ${escapeHTML(item.unit || '---')}
                    </small>
                </td>

                <td>${escapeHTML(item.category)}</td>

                <td>${formatCurrency(item.price)}</td>

                <td>
                    <input
                        type="number"
                        min="1"
                        step="1"
                        class="selected-qty-input"
                        data-id="${item.product_id}"
                        value="${item.quantity}"
                        style="width:70px; padding:5px;"
                    >
                </td>

                <td>
                    <b>${formatCurrency(subtotal)}</b>
                </td>

                <td>
                    <button
                        type="button"
                        class="remove-selected-product-btn"
                        data-id="${item.product_id}"
                        style="background:#ff4d4d; color:white; border:none; padding:5px 10px; cursor:pointer; border-radius:4px;"
                    >
                        X
                    </button>
                </td>
            </tr>
        `;
    }).join('');
}

function calculateOrderTotal() {
    const total = selectedOrderItems.reduce((sum, item) => {
        return sum + Number(item.price || 0) * Number(item.quantity || 0);
    }, 0);

    const displayElement = document.getElementById('totalAmountDisplay');
    const inputElement = document.getElementById('totalAmountInput');

    if (displayElement) {
        displayElement.value = formatCurrency(total);
    }

    if (inputElement) {
        inputElement.value = total;
    }
}

function collectOrderItems() {
    if (!selectedOrderItems.length) {
        throw new Error('Vui lòng chọn ít nhất một sản phẩm');
    }

    return selectedOrderItems.map((item, index) => {
        const productId = Number(item.product_id || 0);
        const quantity = Number(item.quantity || 0);

        if (!productId) {
            throw new Error(`Dòng ${index + 1}: Sản phẩm không hợp lệ`);
        }

        if (!Number.isInteger(quantity) || quantity <= 0) {
            throw new Error(`Dòng ${index + 1}: Số lượng phải là số nguyên lớn hơn 0`);
        }

        return {
            product_id: productId,
            quantity
        };
    });
}


/* =========================================================
   CREATE ORDER - SUBMIT
========================================================= */

function setCreateOrderSubmitting(isSubmitting) {
    const form = document.getElementById('createOrderForm');
    const submitBtn = form?.querySelector('button[type="submit"]');

    if (!submitBtn) return;

    submitBtn.disabled = isSubmitting;

    submitBtn.innerHTML = isSubmitting
        ? `<i class="fa-solid fa-spinner fa-spin"></i> Đang tạo...`
        : `Tạo đơn`;
}

async function submitCreateOrderForm(e) {
    e.preventDefault();

    if (isCreatingOrder) return;

    const customerId = document.getElementById('customerSelect')?.value;
    const paymentTermTemplateId = document.getElementById('paymentTermTemplateSelect')?.value;
    const totalAmount = Number(document.getElementById('totalAmountInput')?.value || 0);

    try {
        isCreatingOrder = true;
        setCreateOrderSubmitting(true);

        if (!customerId) {
            throw new Error('Vui lòng chọn khách hàng');
        }

        if (!paymentTermTemplateId) {
            throw new Error('Vui lòng chọn chương trình khuyến mãi / chính sách thanh toán');
        }

        const shippingAddress = validateShippingAddressPicker();

        const items = collectOrderItems();

        if (totalAmount <= 0) {
            throw new Error('Tổng tiền đơn hàng phải lớn hơn 0');
        }

        const result = await fetchJSON('/api/orders', {
            method: 'POST',
            body: JSON.stringify({
                customer_id: Number(customerId),
                payment_term_template_id: Number(paymentTermTemplateId),
                shipping_address: shippingAddress,
                total_amount: totalAmount,
                items
            })
        });

        alert(result.message || 'Tạo đơn thành công!');

        document.getElementById('createOrderModal')?.classList.add('hidden');

        resetCreateOrderForm();

        await loadOrders();

    } catch (err) {
        console.error('CREATE ORDER ERROR:', err);
        alert('Tạo đơn thất bại: ' + err.message);

    } finally {
        isCreatingOrder = false;
        setCreateOrderSubmitting(false);
    }
}