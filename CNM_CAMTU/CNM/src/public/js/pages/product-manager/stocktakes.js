/* =========================================================
   PRODUCT MANAGER STOCKTAKES APPROVAL PAGE
   Không dùng inline onclick để tránh CSP
   Có hiển thị ảnh kiểm kê trong modal chi tiết
   Có lọc danh sách khi bấm các ô thống kê
========================================================= */

const pmStocktakeState = {
  stocktakes: [],
  currentStocktakeId: null,
  currentStocktake: null
};

document.addEventListener('DOMContentLoaded', () => {
  bindEvents();
  loadStocktakes();
  loadSummaryCounts();
});


/* =========================================================
   EVENTS
========================================================= */

function bindEvents() {
  document.getElementById('btnFilter')?.addEventListener('click', () => {
    loadStocktakes();
  });

  document.getElementById('filterKeyword')?.addEventListener('keydown', (event) => {
    if (event.key === 'Enter') {
      loadStocktakes();
    }
  });

  document.getElementById('btnCloseDetailModal')?.addEventListener('click', closeDetailModal);
  document.getElementById('btnCloseDetailFooter')?.addEventListener('click', closeDetailModal);

  document.getElementById('btnApproveStocktake')?.addEventListener('click', approveCurrentStocktake);

  document.getElementById('btnOpenRejectBox')?.addEventListener('click', openRejectModal);
  document.getElementById('btnCloseRejectModal')?.addEventListener('click', closeRejectModal);
  document.getElementById('btnCancelReject')?.addEventListener('click', closeRejectModal);
  document.getElementById('btnConfirmReject')?.addEventListener('click', rejectCurrentStocktake);

  bindSummaryCardFilters();

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

    if (action === 'quick-approve') {
      await approveStocktakeById(id);
      return;
    }

    if (action === 'quick-reject') {
      pmStocktakeState.currentStocktakeId = id;
      document.getElementById('rejectReason').value = '';
      openRejectModal();
    }
  });
}


/* =========================================================
   SUMMARY CARD FILTERS
========================================================= */

function bindSummaryCardFilters() {
  const cards = document.querySelectorAll('.status-filter-card');

  cards.forEach(card => {
    card.addEventListener('click', async () => {
      const status = card.dataset.status || '';

      const filterStatus = document.getElementById('filterStatus');

      if (filterStatus) {
        filterStatus.value = status;
      }

      setActiveSummaryCard(status);

      await loadStocktakes();
    });
  });
}


function setActiveSummaryCard(status) {
  const cards = document.querySelectorAll('.status-filter-card');

  cards.forEach(card => {
    const cardStatus = card.dataset.status || '';

    if (cardStatus === status) {
      card.classList.add('active');
    } else {
      card.classList.remove('active');
    }
  });
}


/* =========================================================
   API HELPER
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


/* =========================================================
   LOAD LIST
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

    setActiveSummaryCard(status || '');

    if (status) params.append('status', status);
    if (fromDate) params.append('from_date', fromDate);
    if (toDate) params.append('to_date', toDate);
    if (keyword) params.append('keyword', keyword);

    const query = params.toString();
    const url = query
      ? `/api/inventory/stocktakes?${query}`
      : '/api/inventory/stocktakes';

    const result = await apiFetch(url);

    pmStocktakeState.stocktakes = result.data || [];
    countEl.textContent = `${pmStocktakeState.stocktakes.length} phiếu`;

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

  if (!pmStocktakeState.stocktakes.length) {
    tbody.innerHTML = `
      <tr>
        <td colspan="8" class="empty-cell">Không có phiếu kiểm kê phù hợp.</td>
      </tr>
    `;
    return;
  }

  tbody.innerHTML = pmStocktakeState.stocktakes.map((item) => {
    const status = item.status;

    return `
      <tr>
        <td><strong>${escapeHtml(item.stocktake_code)}</strong></td>
        <td>${formatDate(item.stocktake_date)}</td>
        <td>${escapeHtml(item.warehouse_area || '-')}</td>
        <td>${escapeHtml(item.created_by_name || '-')}</td>
        <td>${Number(item.total_items || 0)}</td>
        <td>${formatQuantity(item.total_difference_abs || 0)}</td>
        <td>${renderStatusBadge(status)}</td>
        <td class="text-right">
          <button 
            type="button"
            class="action-btn"
            data-action="view-detail"
            data-id="${Number(item.stocktake_id)}"
          >
            Xem
          </button>

          ${status === 'pending' ? `
            <button 
              type="button"
              class="action-btn"
              data-action="quick-approve"
              data-id="${Number(item.stocktake_id)}"
            >
              Duyệt
            </button>

            <button 
              type="button"
              class="action-btn"
              data-action="quick-reject"
              data-id="${Number(item.stocktake_id)}"
            >
              Từ chối
            </button>
          ` : ''}
        </td>
      </tr>
    `;
  }).join('');
}


/* =========================================================
   SUMMARY
========================================================= */

async function loadSummaryCounts() {
  try {
    const result = await apiFetch('/api/inventory/stocktakes');

    const list = result.data || [];

    const pending = list.filter(item => item.status === 'pending').length;
    const approved = list.filter(item => item.status === 'approved').length;
    const rejected = list.filter(item => item.status === 'rejected').length;

    document.getElementById('pendingCount').textContent = pending;
    document.getElementById('approvedCount').textContent = approved;
    document.getElementById('rejectedCount').textContent = rejected;
    document.getElementById('totalCount').textContent = list.length;

  } catch (error) {
    document.getElementById('pendingCount').textContent = '0';
    document.getElementById('approvedCount').textContent = '0';
    document.getElementById('rejectedCount').textContent = '0';
    document.getElementById('totalCount').textContent = '0';
  }
}


/* =========================================================
   DETAIL MODAL
========================================================= */

async function openDetailModal(stocktakeId) {
  const modal = document.getElementById('detailModal');
  const content = document.getElementById('detailContent');

  pmStocktakeState.currentStocktakeId = stocktakeId;
  pmStocktakeState.currentStocktake = null;

  modal.classList.add('show');
  content.innerHTML = `<div class="empty-box">Đang tải chi tiết...</div>`;

  try {
    const result = await apiFetch(`/api/inventory/stocktakes/${stocktakeId}`);

    pmStocktakeState.currentStocktake = result.data;

    renderStocktakeDetail(result.data);
    updateModalFooter(result.data.status);

  } catch (error) {
    content.innerHTML = `<div class="empty-box">${escapeHtml(error.message)}</div>`;
    updateModalFooter(null);
  }
}


function closeDetailModal() {
  document.getElementById('detailModal').classList.remove('show');
  pmStocktakeState.currentStocktakeId = null;
  pmStocktakeState.currentStocktake = null;
}


function updateModalFooter(status) {
  const approveBtn = document.getElementById('btnApproveStocktake');
  const rejectBtn = document.getElementById('btnOpenRejectBox');

  const canApprove = status === 'pending';

  approveBtn.style.display = canApprove ? 'inline-flex' : 'none';
  rejectBtn.style.display = canApprove ? 'inline-flex' : 'none';
}


function renderStocktakeDetail(data) {
  const content = document.getElementById('detailContent');
  const subtitle = document.getElementById('detailSubtitle');

  subtitle.textContent = `${data.stocktake_code} - ${getStatusText(data.status)}`;

  const items = Array.isArray(data.items) ? data.items : [];
  const hasDifference = items.some(item => Number(item.difference_quantity || 0) !== 0);
  const hasImage = items.some(item => Boolean(item.image_url));

  content.innerHTML = `
    ${data.status === 'pending' ? `
      <div class="approval-note">
        Khi duyệt phiếu này, hệ thống sẽ cập nhật tồn kho theo số lượng thực tế trong phiếu.
      </div>
    ` : ''}

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

      ${data.approved_by_name ? `
        <div class="detail-item">
          <span>Người duyệt</span>
          <strong>${escapeHtml(data.approved_by_name)}</strong>
        </div>
      ` : ''}

      ${data.rejected_by_name ? `
        <div class="detail-item">
          <span>Người từ chối</span>
          <strong>${escapeHtml(data.rejected_by_name)}</strong>
        </div>
      ` : ''}

      ${data.reject_reason ? `
        <div class="detail-item">
          <span>Lý do từ chối</span>
          <strong>${escapeHtml(data.reject_reason)}</strong>
        </div>
      ` : ''}
    </div>

    <div class="table-heading">
      <h2>Danh sách vật tư kiểm kê</h2>
      <span>${items.length} dòng</span>
    </div>

    ${hasImage ? `
      <div class="approval-note">
        Phiếu có ảnh minh chứng. Bấm vào ảnh để xem kích thước đầy đủ.
      </div>
    ` : ''}

    <div class="table-wrapper">
      <table>
        <thead>
          <tr>
            <th>Vật tư</th>
            <th>SKU</th>
            <th>Lô</th>
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

            return `
              <tr>
                <td><strong>${escapeHtml(item.product_name)}</strong></td>
                <td>${escapeHtml(item.sku || '-')}</td>
                <td>${escapeHtml(item.batch_number || '-')}</td>
                <td>${formatDate(item.expiry_date)}</td>
                <td>${escapeHtml(item.unit_name || '-')}</td>
                <td>${formatQuantity(item.system_quantity)}</td>
                <td>${formatQuantity(item.actual_quantity)}</td>
                <td>${renderDifference(diff)}</td>
                <td>${escapeHtml(item.item_condition || '-')}</td>
                <td>${escapeHtml(item.loss_reason || '-')}</td>
                <td>
                  ${item.image_url ? `
                    <a href="${escapeAttribute(item.image_url)}" target="_blank" rel="noopener">
                      <img
                        src="${escapeAttribute(item.image_url)}"
                        class="detail-stocktake-img"
                        alt="Ảnh kiểm kê"
                      >
                    </a>
                  ` : `
                    <span class="no-image-text">Không có</span>
                  `}
                </td>
                <td>${escapeHtml(item.note || '-')}</td>
              </tr>
            `;
          }).join('') : `
            <tr>
              <td colspan="12" class="empty-cell">Phiếu chưa có vật tư.</td>
            </tr>
          `}
        </tbody>
      </table>
    </div>

    ${!hasDifference ? `
      <div class="approval-note" style="margin-top:16px;">
        Phiếu này không có chênh lệch tồn kho.
      </div>
    ` : ''}
  `;
}


/* =========================================================
   APPROVE / REJECT
========================================================= */

async function approveCurrentStocktake() {
  const id = pmStocktakeState.currentStocktakeId;

  if (!id) {
    alert('Không tìm thấy phiếu kiểm kê cần duyệt');
    return;
  }

  await approveStocktakeById(id);
}


async function approveStocktakeById(stocktakeId) {
  try {
    if (!confirm('Bạn có chắc muốn duyệt phiếu này? Tồn kho sẽ được cập nhật theo số lượng thực tế.')) {
      return;
    }

    const result = await apiFetch(`/api/inventory/stocktakes/${stocktakeId}/approve`, {
      method: 'POST',
      body: JSON.stringify({})
    });

    alert(result.message || 'Duyệt phiếu kiểm kê thành công');

    closeDetailModal();
    await loadStocktakes();
    await loadSummaryCounts();

  } catch (error) {
    alert(error.message);
  }
}


function openRejectModal() {
  document.getElementById('rejectModal').classList.add('show');
}


function closeRejectModal() {
  document.getElementById('rejectModal').classList.remove('show');
}


async function rejectCurrentStocktake() {
  const id = pmStocktakeState.currentStocktakeId;
  const reason = document.getElementById('rejectReason').value.trim();

  if (!id) {
    alert('Không tìm thấy phiếu kiểm kê cần từ chối');
    return;
  }

  if (!reason) {
    alert('Vui lòng nhập lý do từ chối');
    return;
  }

  try {
    if (!confirm('Bạn có chắc muốn từ chối phiếu kiểm kê này?')) {
      return;
    }

    const result = await apiFetch(`/api/inventory/stocktakes/${id}/reject`, {
      method: 'POST',
      body: JSON.stringify({
        reason
      })
    });

    alert(result.message || 'Từ chối phiếu kiểm kê thành công');

    closeRejectModal();
    closeDetailModal();

    await loadStocktakes();
    await loadSummaryCounts();

  } catch (error) {
    alert(error.message);
  }
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