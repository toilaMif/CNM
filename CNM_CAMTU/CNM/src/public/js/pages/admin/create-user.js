/* =========================================================
   CREATE USER PAGE SCRIPT
========================================================= */

/* =========================================================
   ELEMENTS
========================================================= */

const form = document.querySelector('#createUserForm');

const provinceSelect = document.querySelector('#province');
const districtSelect = document.querySelector('#district');
const wardSelect = document.querySelector('#ward');

const alertContainer = document.querySelector('#alertContainer');

const ADDRESS_API = '/api/address';

/* =========================================================
   TOKEN
========================================================= */

function getToken() {

    return (
        localStorage.getItem('accessToken') ||
        localStorage.getItem('accesstoken') ||
        ''
    );
}

/* =========================================================
   SAFE JSON
========================================================= */

async function safeJson(response) {

    try {

        return await response.json();

    } catch {

        return {};
    }
}

/* =========================================================
   ALERT
========================================================= */

function showAlert(message, type = 'success') {

    if (!alertContainer) {
        alert(message);
        return;
    }

    alertContainer.innerHTML = `
        <div class="alert alert-${type}">
            <span>${message}</span>
        </div>
    `;

    setTimeout(() => {
        alertContainer.innerHTML = '';
    }, 3500);
}

/* =========================================================
   SELECT HELPERS
========================================================= */

function resetDistrictSelect() {

    if (!districtSelect) return;

    districtSelect.disabled = true;

    districtSelect.innerHTML = `
        <option value="">
            -- Chọn quận / huyện --
        </option>
    `;
}

function resetWardSelect() {

    if (!wardSelect) return;

    wardSelect.disabled = true;

    wardSelect.innerHTML = `
        <option value="">
            -- Chọn phường / xã --
        </option>
    `;
}

function fillSelectOptions(
    selectElement,
    data,
    valueKey,
    textKey
) {

    if (!selectElement || !Array.isArray(data)) {
        return;
    }

    data.forEach(item => {

        const option = document.createElement('option');

        option.value = item[valueKey];
        option.dataset.name = item[textKey];
        option.textContent = item[textKey];

        selectElement.appendChild(option);
    });
}

/* =========================================================
   LOAD PROVINCES
========================================================= */

async function loadProvinces() {

    try {

        provinceSelect.innerHTML = `
            <option value="">
                Đang tải tỉnh / thành phố...
            </option>
        `;

        const response = await fetch(
            `${ADDRESS_API}/provinces`
        );

        const data = await safeJson(response);

        if (!response.ok) {

            throw new Error(
                data.message ||
                'Không thể tải tỉnh / thành phố'
            );
        }

        const provinces = data.results || [];

        provinceSelect.innerHTML = `
            <option value="">
                -- Chọn tỉnh / thành phố --
            </option>
        `;

        /* FIX FIELD */
        fillSelectOptions(
            provinceSelect,
            provinces,
            'code',
            'name'
        );

    } catch (error) {

        console.error(
            'Load provinces error:',
            error
        );

        provinceSelect.innerHTML = `
            <option value="">
                Không tải được dữ liệu
            </option>
        `;

        showAlert(
            error.message ||
            'Không thể tải danh sách tỉnh / thành phố',
            'danger'
        );
    }
}

/* =========================================================
   LOAD DISTRICTS
========================================================= */

async function loadDistricts(provinceId) {

    try {

        resetDistrictSelect();
        resetWardSelect();

        districtSelect.innerHTML = `
            <option value="">
                Đang tải quận / huyện...
            </option>
        `;

        const response = await fetch(
            `${ADDRESS_API}/districts/${provinceId}`
        );

        const data = await safeJson(response);

        if (!response.ok) {

            throw new Error(
                data.message ||
                'Không thể tải quận / huyện'
            );
        }

        const districts = data.results || [];

        districtSelect.innerHTML = `
            <option value="">
                -- Chọn quận / huyện --
            </option>
        `;

        /* FIX FIELD */
        fillSelectOptions(
            districtSelect,
            districts,
            'code',
            'name'
        );

        districtSelect.disabled = false;

    } catch (error) {

        console.error(
            'Load districts error:',
            error
        );

        districtSelect.innerHTML = `
            <option value="">
                Không tải được dữ liệu
            </option>
        `;

        showAlert(
            error.message ||
            'Không thể tải danh sách quận / huyện',
            'danger'
        );
    }
}

/* =========================================================
   LOAD WARDS
========================================================= */

async function loadWards(districtId) {

    try {

        resetWardSelect();

        wardSelect.innerHTML = `
            <option value="">
                Đang tải phường / xã...
            </option>
        `;

        const response = await fetch(
            `${ADDRESS_API}/wards/${districtId}`
        );

        const data = await safeJson(response);

        if (!response.ok) {

            throw new Error(
                data.message ||
                'Không thể tải phường / xã'
            );
        }

        const wards = data.results || [];

        wardSelect.innerHTML = `
            <option value="">
                -- Chọn phường / xã --
            </option>
        `;

        /* FIX FIELD */
        fillSelectOptions(
            wardSelect,
            wards,
            'code',
            'name'
        );

        wardSelect.disabled = false;

    } catch (error) {

        console.error(
            'Load wards error:',
            error
        );

        wardSelect.innerHTML = `
            <option value="">
                Không tải được dữ liệu
            </option>
        `;

        showAlert(
            error.message ||
            'Không thể tải danh sách phường / xã',
            'danger'
        );
    }
}

/* =========================================================
   GET SELECT TEXT
========================================================= */

function getSelectedText(selectElement) {

    if (!selectElement) return '';

    const selectedOption =
        selectElement.options[
            selectElement.selectedIndex
        ];

    if (!selectedOption) return '';

    return (
        selectedOption.dataset.name ||
        selectedOption.textContent.trim()
    );
}

/* =========================================================
   BUILD ADDRESS
========================================================= */

function buildAddress() {

    const houseNumber =
        document.querySelector('#houseNumber')
            ?.value
            .trim() || '';

    const province =
        provinceSelect.value
            ? getSelectedText(provinceSelect)
            : '';

    const district =
        districtSelect.value
            ? getSelectedText(districtSelect)
            : '';

    const ward =
        wardSelect.value
            ? getSelectedText(wardSelect)
            : '';

    return [
        houseNumber,
        ward,
        district,
        province
    ]
        .filter(Boolean)
        .join(', ');
}

/* =========================================================
   VALIDATE
========================================================= */

function isValidEmail(email) {

    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}

function isValidVietnamPhone(phone) {

    return /^(0(3|5|7|8|9))[0-9]{8}$/.test(phone);
}

function isFutureDate(dateValue) {

    if (!dateValue) return false;

    const selectedDate = new Date(dateValue);

    const today = new Date();

    selectedDate.setHours(0, 0, 0, 0);
    today.setHours(0, 0, 0, 0);

    return selectedDate > today;
}

/* =========================================================
   VALIDATE FORM
========================================================= */

function validateCreateUserForm() {

    const email =
        document.querySelector('#email')
            ?.value
            .trim();

    const fullName =
        document.querySelector('#fullName')
            ?.value
            .trim();

    const phoneNumber =
        document.querySelector('#phoneNumber')
            ?.value
            .trim();

    const roleId =
        document.querySelector('#roleId')
            ?.value;

    const dateOfBirth =
        document.querySelector('#dateOfBirth')
            ?.value;

    const houseNumber =
        document.querySelector('#houseNumber')
            ?.value
            .trim();

    if (!email) {

        showAlert(
            'Vui lòng nhập email',
            'danger'
        );

        return false;
    }

    if (!isValidEmail(email)) {

        showAlert(
            'Email không hợp lệ',
            'danger'
        );

        return false;
    }

    if (!fullName || fullName.length < 2) {

        showAlert(
            'Họ tên phải có ít nhất 2 ký tự',
            'danger'
        );

        return false;
    }

    if (!phoneNumber) {

        showAlert(
            'Vui lòng nhập số điện thoại',
            'danger'
        );

        return false;
    }

    if (!isValidVietnamPhone(phoneNumber)) {

        showAlert(
            'Số điện thoại không hợp lệ',
            'danger'
        );

        return false;
    }

    if (!roleId) {

        showAlert(
            'Vui lòng chọn vai trò',
            'danger'
        );

        return false;
    }

    if (!houseNumber) {

        showAlert(
            'Vui lòng nhập địa chỉ',
            'danger'
        );

        return false;
    }

    if (!provinceSelect.value) {

        showAlert(
            'Vui lòng chọn tỉnh / thành phố',
            'danger'
        );

        return false;
    }

    if (!districtSelect.value) {

        showAlert(
            'Vui lòng chọn quận / huyện',
            'danger'
        );

        return false;
    }

    if (!wardSelect.value) {

        showAlert(
            'Vui lòng chọn phường / xã',
            'danger'
        );

        return false;
    }

    if (
        dateOfBirth &&
        isFutureDate(dateOfBirth)
    ) {

        showAlert(
            'Ngày sinh không hợp lệ',
            'danger'
        );

        return false;
    }

    return true;
}

/* =========================================================
   SUBMIT FORM
========================================================= */

async function handleCreateUser(event) {

    event.preventDefault();

    if (!validateCreateUserForm()) {
        return;
    }

    const submitButton =
        form.querySelector(
            'button[type="submit"]'
        );

    try {

        submitButton.disabled = true;

        submitButton.innerHTML = `
            Đang tạo tài khoản...
        `;

        const payload = {

            email:
                document.querySelector('#email')
                    .value
                    .trim(),

            role_id: parseInt(
                document.querySelector('#roleId').value,
                10
            ),

            full_name:
                document.querySelector('#fullName')
                    .value
                    .trim(),

            phone_number:
                document.querySelector('#phoneNumber')
                    .value
                    .trim(),

            gender:
                document.querySelector('#gender')
                    .value,

            address: buildAddress(),

            date_of_birth:
                document.querySelector('#dateOfBirth')
                    .value || null
        };

        const response = await fetch(
            '/api/users',
            {
                method: 'POST',

                credentials: 'include',

                headers: {
                    'Content-Type': 'application/json',
                    Authorization:
                        `Bearer ${getToken()}`
                },

                body: JSON.stringify(payload)
            }
        );

        const data = await safeJson(response);

        if (!response.ok) {

            if (response.status === 401) {

                window.location.href =
                    '/auth/login';

                return;
            }

            throw new Error(
                data.message ||
                'Không thể tạo tài khoản'
            );
        }

        showAlert(
            '✅ Tạo tài khoản thành công',
            'success'
        );

        form.reset();

        resetDistrictSelect();
        resetWardSelect();

        setTimeout(() => {

            window.location.href =
                '/admin/dashboard';

        }, 1800);

    } catch (error) {

        console.error(
            'Create user error:',
            error
        );

        showAlert(
            error.message ||
            'Có lỗi xảy ra',
            'danger'
        );

    } finally {

        submitButton.disabled = false;

        submitButton.innerHTML = `
            + Tạo tài khoản
        `;
    }
}

/* =========================================================
   EVENTS
========================================================= */

provinceSelect?.addEventListener(
    'change',
    event => {

        const provinceId =
            event.target.value;

        resetDistrictSelect();
        resetWardSelect();

        if (!provinceId) return;

        loadDistricts(provinceId);
    }
);

districtSelect?.addEventListener(
    'change',
    event => {

        const districtId =
            event.target.value;

        resetWardSelect();

        if (!districtId) return;

        loadWards(districtId);
    }
);

form?.addEventListener(
    'submit',
    handleCreateUser
);

/* =========================================================
   INIT
========================================================= */

document.addEventListener(
    'DOMContentLoaded',
    () => {

        if (!form) {

            console.error(
                'Create user form not found'
            );

            return;
        }

        resetDistrictSelect();
        resetWardSelect();

        loadProvinces();
    }
);