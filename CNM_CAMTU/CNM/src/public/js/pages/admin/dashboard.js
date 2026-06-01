let allUsers = [];

/* =========================================================
   FILTER STATE
========================================================= */

let currentFilters = {
  role: '',
  status: ''
};

/* =========================================================
   LOAD DASHBOARD
========================================================= */

async function loadDashboard() {

  try {

    const token = localStorage.getItem('accesstoken');

    const response = await fetch('/api/users', {
      headers: {
        Authorization: `Bearer ${token}`,
        'Content-Type': 'application/json'
      }
    });

    if (!response.ok) {

      if (response.status === 401) {
        window.location.href = '/login';
        return;
      }

      const errorText = await response.text();
      console.error(errorText);

      throw new Error('Cannot load users');
    }

    const result = await response.json();

    allUsers = result.users || result.data || result;

    updateStats(allUsers);
    renderUsers(allUsers);

  } catch (err) {

    console.error(err);

    const tbody = document.getElementById('usersTableBody');

    if (tbody) {
      tbody.innerHTML = `
        <tr>
          <td colspan="7" class="loading">
            Lỗi tải dữ liệu
          </td>
        </tr>
      `;
    }
  }
}

/* =========================================================
   UPDATE STATS
========================================================= */

function updateStats(users) {

  document.getElementById('totalUsers').textContent = users.length;

  const activeUsers = users.filter(
    u => Number(u.is_active) === 1
  );

  const inactiveUsers = users.filter(
    u => Number(u.is_active) === 0
  );

  document.getElementById('activeUsers').textContent = activeUsers.length;
  document.getElementById('lockedUsers').textContent = inactiveUsers.length;
}

/* =========================================================
   RENDER USERS
========================================================= */

function renderUsers(users) {

  const tbody = document.getElementById('usersTableBody');

  if (!tbody) return;

  if (!users || users.length === 0) {
    tbody.innerHTML = `
      <tr>
        <td colspan="7" class="loading">
          Không có dữ liệu
        </td>
      </tr>
    `;
    return;
  }

  tbody.innerHTML = users.map(user => {

    const isActive = Number(user.is_active) === 1;

    return `
      <tr>
        <td>#${user.id}</td>
        <td>${user.email}</td>
        <td>${user.full_name || '-'}</td>
        <td>${user.phone_number || '-'}</td>

        <td>
          <span class="badge badge-admin">
            ${user.role_name || 'N/A'}
          </span>
        </td>

        <td>
          <span class="badge ${
            isActive ? 'badge-success' : 'badge-danger'
          }">
            ${isActive ? 'Active' : 'Inactive'}
          </span>
        </td>

        <td>
          <div class="action-buttons">

            <a
              href="/admin/users/edit/${user.id}"
              class="btn-action"
            >
              ✏️
            </a>



          </div>
        </td>
      </tr>
    `;
  }).join('');
}

/* =========================================================
   FILTER + SEARCH LOGIC
========================================================= */

function applyFilters() {

  const keyword = (document.getElementById('searchUsers')?.value || '')
    .toLowerCase();

  const filtered = allUsers.filter(user => {

    const matchSearch =
      (user.email || '').toLowerCase().includes(keyword) ||
      (user.full_name || '').toLowerCase().includes(keyword) ||
      (user.phone_number || '').includes(keyword);

    const matchRole =
      currentFilters.role
        ? String(user.role_id) === String(currentFilters.role)
        : true;

    const matchStatus =
      currentFilters.status !== ''
        ? String(user.is_active) === String(currentFilters.status)
        : true;

    return matchSearch && matchRole && matchStatus;
  });

  renderUsers(filtered);
}

/* =========================================================
   SEARCH EVENT
========================================================= */

document.getElementById('searchUsers')?.addEventListener('input', applyFilters);

/* =========================================================
   ROLE FILTER
========================================================= */

document.getElementById('filterRole')?.addEventListener('change', function (e) {
  currentFilters.role = e.target.value;
  applyFilters();
});

/* =========================================================
   STATUS FILTER
========================================================= */

document.getElementById('filterStatus')?.addEventListener('change', function (e) {
  currentFilters.status = e.target.value;
  applyFilters();
});

/* =========================================================
   TOGGLE ACTIVE
========================================================= */

async function toggleActive(userId, currentStatus) {

  try {

    const token = localStorage.getItem('accesstoken');

    const response = await fetch(`/api/users/${userId}/status`, {
      method: 'PATCH',
      headers: {
        Authorization: `Bearer ${token}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        is_active: currentStatus ? 0 : 1
      })
    });

    if (!response.ok) {
      throw new Error('Cannot update user status');
    }

    loadDashboard();

  } catch (err) {
    console.error(err);
    alert(err.message);
  }
}

/* =========================================================
   INIT
========================================================= */

document.addEventListener('DOMContentLoaded', loadDashboard);