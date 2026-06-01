let customers = [];

/* =====================================================
   ADDRESS ELEMENTS - CREATE
===================================================== */
const provinceEl = document.getElementById('province');
const districtEl = document.getElementById('district');
const wardEl = document.getElementById('ward');
const streetEl = document.getElementById('street');

/* =====================================================
   ADDRESS ELEMENTS - EDIT
===================================================== */
const editProvinceEl = document.getElementById('editProvince');
const editDistrictEl = document.getElementById('editDistrict');
const editWardEl = document.getElementById('editWard');
const editStreetEl = document.getElementById('editStreet');

/* =====================================================
   MODALS
===================================================== */
const modal = document.getElementById('createModal');
const editModal = document.getElementById('editModal');

const openBtn = document.getElementById('openCreateModal');
const closeBtn = document.getElementById('closeModal');
const closeEditBtn = document.getElementById('closeEditModal');

/* =====================================================
   FETCH CUSTOMERS
===================================================== */
async function fetchCustomers() {
    try {
        const response = await fetch('/api/sale/customers', {
            credentials: 'include'
        });

        const result = await response.json();

        if (!response.ok || !result.success) {
            throw new Error(result.message || 'Lỗi tải danh sách khách hàng');
        }

        customers = result.customers || [];

        renderCustomers(customers);
        updateStats(customers);

    } catch (err) {
        console.error('Fetch customers error:', err);

        const tbody = document.getElementById('customerTableBody');

        if (tbody) {
            tbody.innerHTML = `
                <tr>
                    <td colspan="8" class="empty">
                        ${err.message || 'Không thể tải danh sách khách hàng'}
                    </td>
                </tr>
            `;
        }
    }
}

/* =====================================================
   STATS
===================================================== */
function updateStats(data = []) {
    const totalEl = document.getElementById('totalCustomers');
    const debtEl = document.getElementById('totalDebt');

    if (totalEl) {
        totalEl.textContent = data.length;
    }

    const totalDebt = data.reduce((sum, c) => {
        return sum + Number(c.current_debt || 0);
    }, 0);

    if (debtEl) {
        debtEl.textContent = formatCurrency(totalDebt);
    }
}

/* =====================================================
   SEARCH
===================================================== */
document.getElementById('searchInput')?.addEventListener('keyup', e => {
    const keyword = e.target.value.trim().toLowerCase();

    if (!keyword) {
        renderCustomers(customers);
        return;
    }

    const filtered = customers.filter(c => {
        const address = c.address || c.company_address || '';

        return (
            String(c.customer_id || '').toLowerCase().includes(keyword) ||
            String(c.tax_code || '').toLowerCase().includes(keyword) ||
            String(c.company_name || '').toLowerCase().includes(keyword) ||
            String(address || '').toLowerCase().includes(keyword) ||
            String(c.email || '').toLowerCase().includes(keyword) ||
            String(c.phone_number || '').toLowerCase().includes(keyword)
        );
    });

    renderCustomers(filtered);
});

/* =====================================================
   MODAL EVENTS
===================================================== */
openBtn?.addEventListener('click', () => {
    modal?.classList.add('active');
});

closeBtn?.addEventListener('click', () => {
    modal?.classList.remove('active');
});

closeEditBtn?.addEventListener('click', () => {
    editModal?.classList.remove('active');
});

modal?.addEventListener('click', e => {
    if (e.target === modal) {
        modal.classList.remove('active');
    }
});

editModal?.addEventListener('click', e => {
    if (e.target === editModal) {
        editModal.classList.remove('active');
    }
});

document.addEventListener('keydown', e => {
    if (e.key === 'Escape') {
        modal?.classList.remove('active');
        editModal?.classList.remove('active');
    }
});

/* =====================================================
   API - CREATE CUSTOMER
===================================================== */
async function createCustomer(payload) {
    const response = await fetch('/api/sale/customers', {
        method: 'POST',
        credentials: 'include',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(payload)
    });

    const result = await response.json();

    if (!response.ok || !result.success) {
        throw new Error(result.message || 'Tạo khách hàng thất bại');
    }

    return result;
}

/* =====================================================
   API - UPDATE CUSTOMER
===================================================== */
async function updateCustomer(customerId, payload) {
    const response = await fetch(`/api/sale/customers/${customerId}`, {
        method: 'PUT',
        credentials: 'include',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(payload)
    });

    const result = await response.json();

    if (!response.ok || !result.success) {
        throw new Error(result.message || 'Cập nhật khách hàng thất bại');
    }

    return result;
}

/* =====================================================
   API - DELETE CUSTOMER
===================================================== */
async function deleteCustomer(userId) {
    const response = await fetch(`/api/sale/customers/${userId}`, {
        method: 'DELETE',
        credentials: 'include'
    });

    const result = await response.json();

    if (!response.ok || !result.success) {
        throw new Error(result.message || 'Xóa khách hàng thất bại');
    }

    return result;
}

/* =====================================================
   VALIDATION
===================================================== */
function validateEmail(email) {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}

function validatePhone(phone) {
    return /^(0|\+84)[0-9]{9,10}$/.test(phone);
}

function validateRequired(value) {
    return value !== undefined &&
        value !== null &&
        value.toString().trim().length > 0;
}

function validateCreditLimit(value) {
    const num = Number(value);
    return !Number.isNaN(num) && num >= 0;
}

/* =====================================================
   ADDRESS API - CREATE
===================================================== */
async function loadProvinces() {
    try {
        if (!provinceEl) return;

        const res = await fetch('/api/address/provinces');
        const data = await res.json();

        if (!data.success) return;

        provinceEl.innerHTML = `<option value="">Chọn tỉnh / thành phố</option>`;

        data.results.forEach(p => {
            provinceEl.innerHTML += `<option value="${p.code}">${p.name}</option>`;
        });

    } catch (err) {
        console.error('Load provinces error:', err);
    }
}

async function loadDistricts(provinceId) {
    try {
        if (!districtEl) return;

        const res = await fetch(`/api/address/districts/${provinceId}`);
        const data = await res.json();

        if (!data.success) return;

        districtEl.innerHTML = `<option value="">Chọn quận / huyện</option>`;
        districtEl.disabled = false;

        data.results.forEach(d => {
            districtEl.innerHTML += `<option value="${d.code}">${d.name}</option>`;
        });

    } catch (err) {
        console.error('Load districts error:', err);
    }
}

async function loadWards(districtId) {
    try {
        if (!wardEl) return;

        const res = await fetch(`/api/address/wards/${districtId}`);
        const data = await res.json();

        if (!data.success) return;

        wardEl.innerHTML = `<option value="">Chọn phường / xã</option>`;
        wardEl.disabled = false;

        data.results.forEach(w => {
            wardEl.innerHTML += `<option value="${w.code}">${w.name}</option>`;
        });

    } catch (err) {
        console.error('Load wards error:', err);
    }
}

/* =====================================================
   ADDRESS EVENTS - CREATE
===================================================== */
provinceEl?.addEventListener('change', async e => {
    const provinceId = e.target.value;

    if (districtEl) {
        districtEl.innerHTML = `<option value="">Chọn quận / huyện</option>`;
        districtEl.disabled = true;
    }

    if (wardEl) {
        wardEl.innerHTML = `<option value="">Chọn phường / xã</option>`;
        wardEl.disabled = true;
    }

    if (provinceId) {
        await loadDistricts(provinceId);
    }
});

districtEl?.addEventListener('change', async e => {
    const districtId = e.target.value;

    if (wardEl) {
        wardEl.innerHTML = `<option value="">Chọn phường / xã</option>`;
        wardEl.disabled = true;
    }

    if (districtId) {
        await loadWards(districtId);
    }
});

/* =====================================================
   ADDRESS API - EDIT
===================================================== */
async function loadEditProvinces() {
    try {
        if (!editProvinceEl) return;

        const res = await fetch('/api/address/provinces');
        const data = await res.json();

        if (!data.success) return;

        editProvinceEl.innerHTML = `<option value="">Chọn tỉnh / thành phố</option>`;

        data.results.forEach(p => {
            editProvinceEl.innerHTML += `<option value="${p.code}">${p.name}</option>`;
        });

    } catch (err) {
        console.error('Load edit provinces error:', err);
    }
}

async function loadEditDistricts(provinceId) {
    try {
        if (!editDistrictEl) return;

        const res = await fetch(`/api/address/districts/${provinceId}`);
        const data = await res.json();

        if (!data.success) return;

        editDistrictEl.innerHTML = `<option value="">Chọn quận / huyện</option>`;
        editDistrictEl.disabled = false;

        data.results.forEach(d => {
            editDistrictEl.innerHTML += `<option value="${d.code}">${d.name}</option>`;
        });

    } catch (err) {
        console.error('Load edit districts error:', err);
    }
}

async function loadEditWards(districtId) {
    try {
        if (!editWardEl) return;

        const res = await fetch(`/api/address/wards/${districtId}`);
        const data = await res.json();

        if (!data.success) return;

        editWardEl.innerHTML = `<option value="">Chọn phường / xã</option>`;
        editWardEl.disabled = false;

        data.results.forEach(w => {
            editWardEl.innerHTML += `<option value="${w.code}">${w.name}</option>`;
        });

    } catch (err) {
        console.error('Load edit wards error:', err);
    }
}

/* =====================================================
   ADDRESS EVENTS - EDIT
===================================================== */
editProvinceEl?.addEventListener('change', async e => {
    const provinceId = e.target.value;

    if (editDistrictEl) {
        editDistrictEl.innerHTML = `<option value="">Chọn quận / huyện</option>`;
        editDistrictEl.disabled = true;
    }

    if (editWardEl) {
        editWardEl.innerHTML = `<option value="">Chọn phường / xã</option>`;
        editWardEl.disabled = true;
    }

    if (provinceId) {
        await loadEditDistricts(provinceId);
    }
});

editDistrictEl?.addEventListener('change', async e => {
    const districtId = e.target.value;

    if (editWardEl) {
        editWardEl.innerHTML = `<option value="">Chọn phường / xã</option>`;
        editWardEl.disabled = true;
    }

    if (districtId) {
        await loadEditWards(districtId);
    }
});

/* =====================================================
   BUILD ADDRESS
===================================================== */
function buildCreateAddress() {
    const provinceText = provinceEl?.value
        ? provinceEl.selectedOptions[0].text.trim()
        : '';

    const districtText = districtEl?.value
        ? districtEl.selectedOptions[0].text.trim()
        : '';

    const wardText = wardEl?.value
        ? wardEl.selectedOptions[0].text.trim()
        : '';

    const street = streetEl?.value?.trim() || '';

    return [street, wardText, districtText, provinceText]
        .filter(Boolean)
        .join(', ');
}

function buildEditAddress() {
    const provinceText = editProvinceEl?.value
        ? editProvinceEl.selectedOptions[0].text.trim()
        : '';

    const districtText = editDistrictEl?.value
        ? editDistrictEl.selectedOptions[0].text.trim()
        : '';

    const wardText = editWardEl?.value
        ? editWardEl.selectedOptions[0].text.trim()
        : '';

    const street = editStreetEl?.value?.trim() || '';

    return [street, wardText, districtText, provinceText]
        .filter(Boolean)
        .join(', ');
}

/* =====================================================
   CREATE CUSTOMER SUBMIT
===================================================== */
document.getElementById('createCustomerForm')?.addEventListener('submit', async e => {
    e.preventDefault();

    try {
        const email = document.getElementById('email').value.trim();
        const fullName = document.getElementById('fullName')?.value?.trim() || '';
        const phone = document.getElementById('phoneNumber')?.value?.trim() || '';
        const gender = document.getElementById('gender')?.value || 'hidden';
        const dob = document.getElementById('dob')?.value || null;

        const companyName = document.getElementById('companyName').value.trim();
        const taxCode = document.getElementById('taxCode')?.value?.trim() || '';
        const creditLimit = document.getElementById('creditLimit').value;

        const address = buildCreateAddress();

        if (!validateRequired(email)) {
            throw new Error('Email không được để trống');
        }

        if (!validateEmail(email)) {
            throw new Error('Email không hợp lệ');
        }

        if (phone && !validatePhone(phone)) {
            throw new Error('Số điện thoại không hợp lệ');
        }

        if (!validateRequired(companyName)) {
            throw new Error('Tên công ty không được để trống');
        }

        if (!validateCreditLimit(creditLimit)) {
            throw new Error('Hạn mức tín dụng không hợp lệ');
        }

        const body = {
            email,
            full_name: fullName || null,
            phone_number: phone || null,
            gender,
            date_of_birth: dob,

            company_name: companyName,
            tax_code: taxCode || null,

            address: address || null,
            credit_limit: Number(creditLimit)
        };

        await createCustomer(body);

        modal?.classList.remove('active');
        e.target.reset();

        resetCreateAddress();

        showToast('Tạo khách hàng thành công!', 'success');

        await fetchCustomers();

    } catch (err) {
        console.error('Create customer error:', err);
        showToast(err.message || 'Có lỗi xảy ra khi tạo khách hàng', 'error');
    }
});

/* =====================================================
   RENDER CUSTOMERS
===================================================== */
function renderCustomers(data = []) {
    const tbody = document.getElementById('customerTableBody');

    if (!tbody) return;

    if (!data.length) {
        tbody.innerHTML = `
            <tr>
                <td colspan="8" class="empty">
                    Không có khách hàng
                </td>
            </tr>
        `;
        return;
    }

    tbody.innerHTML = data.map(c => {
        const address = c.address || c.company_address || '-';

        return `
            <tr>
                <td>KH-${c.customer_id}</td>

                <td>${escapeHTML(c.tax_code || '-')}</td>

                <td>${escapeHTML(c.company_name || '-')}</td>

                <td>${escapeHTML(address)}</td>

                <td>${escapeHTML(c.email || '-')}</td>

                <td class="debt">
                    ${formatCurrency(c.current_debt || 0)}
                </td>

                <td>
                    <span class="badge ${c.is_active ? 'active' : 'inactive'}">
                        ${c.is_active ? 'ACTIVE' : 'INACTIVE'}
                    </span>
                </td>

                <td>
                    <div class="actions">
                        <button 
                            type="button"
                            class="edit-btn" 
                            data-id="${c.customer_id}">
                            Sửa
                        </button>

                        <button 
                            type="button"
                            class="delete-btn" 
                            data-id="${c.user_id}">
                            Xóa
                        </button>
                    </div>
                </td>
            </tr>
        `;
    }).join('');
}

/* =====================================================
   DELETE CUSTOMER
===================================================== */
document.addEventListener('click', async e => {
    if (!e.target.classList.contains('delete-btn')) return;

    const userId = e.target.dataset.id;

    if (!userId) {
        showToast('Thiếu ID tài khoản khách hàng', 'error');
        return;
    }

    if (!confirm('Bạn có chắc muốn xóa khách hàng này?')) return;

    try {
        await deleteCustomer(userId);

        showToast('Xóa khách hàng thành công!', 'success');

        await fetchCustomers();

    } catch (err) {
        console.error('Delete customer error:', err);
        showToast(err.message || 'Có lỗi xảy ra khi xóa khách hàng', 'error');
    }
});

/* =====================================================
   OPEN EDIT MODAL
===================================================== */
document.addEventListener('click', async e => {
    if (!e.target.classList.contains('edit-btn')) return;

    const customerId = e.target.dataset.id;

    const customer = customers.find(c => {
        return Number(c.customer_id) === Number(customerId);
    });

    if (!customer) {
        showToast('Không tìm thấy khách hàng', 'error');
        return;
    }

    await openEditModal(customer);
});

/* =====================================================
   FILL EDIT MODAL
===================================================== */
async function openEditModal(c) {
    const address = c.address || c.company_address || '';

    document.getElementById('editCustomerId').value = c.customer_id || '';

    document.getElementById('editEmail').value = c.email || '';
    document.getElementById('editFullName').value = c.full_name || '';
    document.getElementById('editPhoneNumber').value = c.phone_number || '';
    document.getElementById('editGender').value = c.gender || 'hidden';
    document.getElementById('editDob').value = formatDateForInput(c.date_of_birth);

    document.getElementById('editCompanyName').value = c.company_name || '';
    document.getElementById('editTaxCode').value = c.tax_code || '';
    document.getElementById('editCreditLimit').value = Number(c.credit_limit || 0);

    resetEditAddress();

    if (address) {
        await fillAddressToEdit(address);
    } else {
        await loadEditProvinces();
    }

    editModal?.classList.add('active');
}

/* =====================================================
   SPLIT ADDRESS AND FILL EDIT ADDRESS
===================================================== */
async function fillAddressToEdit(address) {
    if (!address) {
        await loadEditProvinces();
        return;
    }

    const parts = address.split(',').map(item => item.trim());

    const street = parts[0] || '';
    const ward = parts[1] || '';
    const district = parts[2] || '';
    const province = parts[3] || '';

    if (editStreetEl) {
        editStreetEl.value = street;
    }

    await setEditAddressByText(province, district, ward);
}

async function setEditAddressByText(province, district, ward) {
    await loadEditProvinces();

    if (!province || !editProvinceEl) return;

    const provinceOption = [...editProvinceEl.options].find(option => {
        return option.text.trim() === province.trim();
    });

    if (!provinceOption) return;

    editProvinceEl.value = provinceOption.value;

    await loadEditDistricts(provinceOption.value);

    if (!district || !editDistrictEl) return;

    const districtOption = [...editDistrictEl.options].find(option => {
        return option.text.trim() === district.trim();
    });

    if (!districtOption) return;

    editDistrictEl.value = districtOption.value;

    await loadEditWards(districtOption.value);

    if (!ward || !editWardEl) return;

    const wardOption = [...editWardEl.options].find(option => {
        return option.text.trim() === ward.trim();
    });

    if (wardOption) {
        editWardEl.value = wardOption.value;
    }
}

/* =====================================================
   EDIT CUSTOMER SUBMIT
===================================================== */
document.getElementById('editCustomerForm')?.addEventListener('submit', async e => {
    e.preventDefault();

    try {
        const id = document.getElementById('editCustomerId').value;

        const email = document.getElementById('editEmail').value.trim();
        const fullName = document.getElementById('editFullName').value.trim();
        const phone = document.getElementById('editPhoneNumber').value.trim();
        const gender = document.getElementById('editGender').value || 'hidden';
        const dob = document.getElementById('editDob').value || null;

        const companyName = document.getElementById('editCompanyName').value.trim();
        const taxCode = document.getElementById('editTaxCode').value.trim();
        const creditLimit = document.getElementById('editCreditLimit').value;

        const address = buildEditAddress();

        if (!id) {
            throw new Error('Thiếu ID khách hàng');
        }

        if (!validateRequired(email)) {
            throw new Error('Email không được để trống');
        }

        if (!validateEmail(email)) {
            throw new Error('Email không hợp lệ');
        }

        if (phone && !validatePhone(phone)) {
            throw new Error('Số điện thoại không hợp lệ');
        }

        if (!validateRequired(companyName)) {
            throw new Error('Tên công ty không được để trống');
        }

        if (!validateCreditLimit(creditLimit)) {
            throw new Error('Hạn mức tín dụng không hợp lệ');
        }

        const body = {
            email,
            full_name: fullName || null,
            phone_number: phone || null,
            gender,
            date_of_birth: dob,

            company_name: companyName,
            tax_code: taxCode || null,
            credit_limit: Number(creditLimit),

            address: address || null
        };

        await updateCustomer(id, body);

        showToast('Cập nhật khách hàng thành công!', 'success');

        editModal?.classList.remove('active');

        await fetchCustomers();

    } catch (err) {
        console.error('Update customer error:', err);
        showToast(err.message || 'Có lỗi xảy ra khi cập nhật khách hàng', 'error');
    }
});

/* =====================================================
   RESET ADDRESS
===================================================== */
function resetCreateAddress() {
    if (provinceEl) {
        provinceEl.value = '';
    }

    if (districtEl) {
        districtEl.innerHTML = `<option value="">Chọn quận / huyện</option>`;
        districtEl.disabled = true;
    }

    if (wardEl) {
        wardEl.innerHTML = `<option value="">Chọn phường / xã</option>`;
        wardEl.disabled = true;
    }

    if (streetEl) {
        streetEl.value = '';
    }
}

function resetEditAddress() {
    if (editProvinceEl) {
        editProvinceEl.innerHTML = `<option value="">Chọn tỉnh / thành phố</option>`;
        editProvinceEl.value = '';
    }

    if (editDistrictEl) {
        editDistrictEl.innerHTML = `<option value="">Chọn quận / huyện</option>`;
        editDistrictEl.disabled = true;
    }

    if (editWardEl) {
        editWardEl.innerHTML = `<option value="">Chọn phường / xã</option>`;
        editWardEl.disabled = true;
    }

    if (editStreetEl) {
        editStreetEl.value = '';
    }
}

/* =====================================================
   HELPERS
===================================================== */
function formatCurrency(value) {
    return Number(value || 0).toLocaleString('vi-VN', {
        style: 'currency',
        currency: 'VND'
    });
}

function formatDateForInput(value) {
    if (!value) return '';

    const date = new Date(value);

    if (Number.isNaN(date.getTime())) {
        return String(value).slice(0, 10);
    }

    return date.toISOString().slice(0, 10);
}

function escapeHTML(value) {
    return String(value)
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#039;');
}

function showToast(message, type = 'success') {
    const toast = document.createElement('div');

    toast.className = `toast ${type}`;
    toast.textContent = message;

    document.body.appendChild(toast);

    setTimeout(() => {
        toast.classList.add('show');
    }, 10);

    setTimeout(() => {
        toast.classList.remove('show');

        setTimeout(() => {
            toast.remove();
        }, 300);
    }, 3000);
}

/* =====================================================
   INIT
===================================================== */
document.addEventListener('DOMContentLoaded', async () => {
    await fetchCustomers();
    await loadProvinces();
});