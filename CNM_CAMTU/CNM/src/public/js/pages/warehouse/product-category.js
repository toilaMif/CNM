const API_URL = '/api/products';

const tableBody = document.getElementById('productTableBody');
const productForm = document.getElementById('productForm');

/* =========================================================
   MODAL ELEMENTS
========================================================= */

const modal = document.getElementById('productModal');

const openModalBtn = document.getElementById('openModalBtn');

const closeModalBtn = document.getElementById('closeModalBtn');

const cancelModalBtn = document.getElementById('cancelModalBtn');

/* =========================================================
   INIT
========================================================= */
document.addEventListener('DOMContentLoaded', () => {

    loadProducts();

    loadCategories();

    loadUnits();

    setupModal();

    setupCreateProduct();
});
/* =========================================================
   LOAD PRODUCTS
========================================================= */

async function loadProducts() {

    try {

        showLoading();

        const response = await fetch(API_URL);

        let result;

        try {

            result = await response.json();

        } catch (err) {

            throw new Error('Server trả về dữ liệu không hợp lệ');
        }

        if (!response.ok || !result.success) {

            throw new Error(result.message || 'Load sản phẩm thất bại');
        }

        renderProducts(result.data);

    } catch (error) {

        console.error(error);

        renderError(error.message);
    }
}

/* =========================================================
   RENDER PRODUCTS
========================================================= */

function renderProducts(products) {

    if (!Array.isArray(products) || products.length === 0) {

        tableBody.innerHTML = `
            <tr>
                <td colspan="8" class="empty-row">
                    Chưa có sản phẩm nào
                </td>
            </tr>
        `;

        return;
    }

    tableBody.innerHTML = products.map((product, index) => `

        <tr id="row-${product.id}">

            <td>${index + 1}</td>

            <td>
                <span class="sku-badge">
                    ${product.sku || '---'}
                </span>
            </td>

            <td>${product.name}</td>

            <td>${product.category?.name || '---'}</td>

            <td>${formatCurrency(product.price)}</td>

            <td>${product.unit?.name || '---'}</td>

            <td>${product.quantity ?? 0}</td>

            <td>
                <span class="status">
                    ${product.status?.name || '---'}
                </span>
            </td>

            <td>
                <div class="actions">

                    <button class="edit-btn" data-id="${product.id}">
                        Sửa
                    </button>

                    <button class="delete-btn" data-id="${product.id}">
                        Xóa
                    </button>

                </div>
            </td>

        </tr>

    `).join('');
    
    bindDeleteButtons();
}

/* =========================================================
   LOADING
========================================================= */

function showLoading() {

    tableBody.innerHTML = `
        <tr>
            <td colspan="8" class="empty-row">
                Đang tải dữ liệu...
            </td>
        </tr>
    `;
}

/* =========================================================
   ERROR
========================================================= */

function renderError(message) {

    tableBody.innerHTML = `
        <tr>
            <td colspan="8" class="empty-row">
                ${message}
            </td>
        </tr>
    `;
}

/* =========================================================
   MODAL
========================================================= */

function setupModal() {

    if (
        !modal ||
        !openModalBtn ||
        !closeModalBtn ||
        !cancelModalBtn
    ) {

        console.warn('Modal elements missing');

        return;
    }

    /* OPEN MODAL */
    openModalBtn.addEventListener('click', () => {

        openModal();
    });

    /* CLOSE BUTTON */
    closeModalBtn.addEventListener('click', () => {

        closeModal();
    });

    /* CANCEL BUTTON */
    cancelModalBtn.addEventListener('click', () => {

        closeModal();
    });

    /* CLICK OUTSIDE */
    modal.addEventListener('click', (event) => {

        if (event.target === modal) {

            closeModal();
        }
    });

    /* ESC CLOSE */
    document.addEventListener('keydown', (event) => {

        if (event.key === 'Escape') {

            closeModal();
        }
    });
}

function openModal() {

    modal.classList.add('show');

    document.body.style.overflow = 'hidden';
}

function closeModal() {

    modal.classList.remove('show');

    document.body.style.overflow = 'auto';
}


/* =========================================================
   LOAD CATEGORIES
========================================================= */

async function loadCategories() {

    try {

        const response = await fetch(
            '/api/products/categories'
        );

        const result = await response.json();

        if (!result.success) {

            throw new Error(
                'Không thể tải danh mục'
            );
        }

        const categorySelect =
            document.getElementById(
                'categorySelect'
            );

        categorySelect.innerHTML = `
            <option value="">
                Chọn danh mục
            </option>
        `;

        result.data.forEach(category => {

            categorySelect.innerHTML += `
                <option value="${category.id}">
                    ${category.name}
                </option>
            `;
        });

    } catch (error) {

        console.error(error);
    }
}
/* =========================================================
   LOAD UNITS
========================================================= */

async function loadUnits() {

    try {

        const response = await fetch(
            '/api/products/units'
        );

        const result = await response.json();

        if (!result.success) {

            throw new Error(
                'Không thể tải đơn vị'
            );
        }

        const unitSelect =
            document.getElementById(
                'unitSelect'
            );

        unitSelect.innerHTML = `
            <option value="">
                Chọn đơn vị
            </option>
        `;

        result.data.forEach(unit => {

            unitSelect.innerHTML += `
                <option value="${unit.id}">
                    ${unit.name}
                </option>
            `;
        });

    } catch (error) {

        console.error(error);
    }
}
/* =========================================================
   CREATE PRODUCT
========================================================= */

function setupCreateProduct() {

    if (!productForm) return;

    productForm.addEventListener('submit', async (event) => {

        event.preventDefault();

        const submitBtn =
            productForm.querySelector('.submit-btn');

        try {

            if (submitBtn) {

                submitBtn.disabled = true;

                submitBtn.innerText = 'Đang tạo...';
            }

            const formData = new FormData(productForm);

            const raw = Object.fromEntries(formData.entries());

            /* MAP DATA SANG BACKEND FORMAT */
            const data = {

                ProductName: raw.name,

                Price: Number(raw.price),

                CategoryID: Number(raw.categoryId),

                UnitID: Number(raw.unitId),

                StatusID: Number(raw.statusId),

                Description: raw.description
            };

            const response = await fetch(API_URL, {

                method: 'POST',

                headers: {
                    'Content-Type': 'application/json'
                },

                body: JSON.stringify(data)
            });

            let result;

            try {

                result = await response.json();

            } catch (err) {

                throw new Error(
                    'Server trả về dữ liệu không hợp lệ'
                );
            }

            if (!response.ok || !result.success) {

                throw new Error(
                    result.message ||
                    'Tạo sản phẩm thất bại'
                );
            }

            alert('Tạo sản phẩm thành công');

            productForm.reset();

            closeModal();

            loadProducts();

        } catch (error) {

            console.error(error);

            alert(error.message);

        } finally {

            if (submitBtn) {

                submitBtn.disabled = false;

                submitBtn.innerText = 'Tạo sản phẩm';
            }
        }
    });
}

/* =========================================================
   DELETE
========================================================= */
async function handleDelete(productId) {

    if (!confirm('Bạn có chắc muốn xóa sản phẩm này?')) return;

    const token = localStorage.getItem('accessToken'); // hoặc cookie

    const response = await fetch(`${API_URL}/${productId}`, {
        method: 'DELETE',
        headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${token}`
        }
    });

    const text = await response.text();

    let result;
    try {
        result = JSON.parse(text);
    } catch (err) {
        console.error('Không phải JSON:', text);
        alert('Server trả về HTML (thường là lỗi auth)');
        return;
    }

    if (!result.success) {
        alert(result.message);
        return;
    }

    const row = document.getElementById(`row-${productId}`);
    if (row) row.remove();
}

/* =========================================================
   EDIT
========================================================= */

function handleEdit(productId) {

    console.log('Edit product:', productId);
}

/* =========================================================
   FORMAT CURRENCY
========================================================= */

function formatCurrency(value) {

    if (
        value === null ||
        value === undefined ||
        value === ''
    ) {

        return '0đ';
    }

    const num = Number(value);

    if (isNaN(num)) {

        return '0đ';
    }

    return num.toLocaleString('vi-VN') + 'đ';
}

function bindDeleteButtons() {

    const buttons = document.querySelectorAll('.delete-btn');

    buttons.forEach(btn => {

        btn.addEventListener('click', (event) => {

            const id = event.target.closest('button').dataset.id;

            handleDelete(id);
        });

    });
}