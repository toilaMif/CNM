class SaleDashboard {
    constructor() {
        this.data = window.dashboardData || {};
        this.summary = this.data.summary || {};
        this.logs = this.data.logs || [];
        this.lowStock = this.data.lowStock || [];
        this.topProducts = this.data.topProducts || [];

        this.init();
    }

    init() {
        console.log('Sale Dashboard Data:', this.data);

        this.renderSummaryCards();
        this.renderDynamicIfContainersExist();
        this.bindEvents();
    }

    /* =====================================================
       SUMMARY CARDS
       Khớp với HTML:
       - totalRevenue
       - totalCustomers
       - pendingOrders
    ===================================================== */

    renderSummaryCards() {
        const totalRevenue = this.pickValue(
            this.summary.totalRevenue,
            this.summary.revenue,
            this.summary.total_revenue,
            0
        );

        const totalCustomers = this.pickValue(
            this.summary.totalAgents,
            this.summary.totalCustomers,
            this.summary.customers,
            this.summary.total_customers,
            0
        );

        const pendingOrders = this.pickValue(
            this.summary.pendingOrders,
            this.summary.pending_orders,
            this.summary.pending,
            0
        );

        this.setText('totalRevenue', this.formatCurrency(totalRevenue));
        this.setText('totalCustomers', this.formatNumber(totalCustomers));
        this.setText('pendingOrders', this.formatNumber(pendingOrders));
    }

    /* =====================================================
       OPTIONAL DYNAMIC RENDER
       Nếu sau này bạn thêm id vào HTML thì JS tự render.
       Hiện HTML của bạn đang render bằng EJS nên phần này không bắt buộc.
    ===================================================== */

    renderDynamicIfContainersExist() {
        this.renderLogsIfContainerExists();
        this.renderLowStockIfContainerExists();
        this.renderTopProductIfContainerExists();
    }

    renderLogsIfContainerExists() {
        const container = document.getElementById('logsContainer');

        if (!container) return;

        if (!this.logs.length) {
            container.innerHTML = `
                <div class="activity-item">
                    <div class="activity-icon">
                        <i class="fa-solid fa-circle-info"></i>
                    </div>

                    <div class="activity-info">
                        <h4>Chưa có hoạt động nào</h4>
                        <p>Hệ thống chưa ghi nhận dữ liệu.</p>
                    </div>
                </div>
            `;
            return;
        }

        container.innerHTML = this.logs.map(log => {
            const orderId = log.order_id || log.orderId || '---';
            const companyName = log.company_name || log.companyName || 'Khách hàng';
            const status = log.status || 'PENDING';

            return `
                <div class="activity-item">
                    <div class="activity-icon">
                        <i class="fa-solid fa-box"></i>
                    </div>

                    <div class="activity-info">
                        <h4>Đơn hàng #${this.escapeHTML(orderId)}</h4>
                        <p>${this.escapeHTML(companyName)}</p>
                        <small>${this.escapeHTML(this.getStatusText(status))}</small>
                    </div>
                </div>
            `;
        }).join('');
    }

    renderLowStockIfContainerExists() {
        const container = document.getElementById('lowStockContainer');

        if (!container) return;

        if (!this.lowStock.length) {
            container.innerHTML = `
                <div class="stock-item">
                    <div class="stock-top">
                        <span>Không có sản phẩm sắp hết hàng</span>
                    </div>
                </div>
            `;
            return;
        }

        container.innerHTML = this.lowStock.map(item => {
            const productName = item.ProductName || item.product_name || item.name || 'Sản phẩm';
            const quantity = Number(item.Quantity ?? item.quantity ?? 0);
            const minStock = Number(item.MinStockLevel ?? item.min_stock_level ?? 0);

            const percent = this.calculateStockPercent(quantity, minStock);

            return `
                <div class="stock-item">
                    <div class="stock-top">
                        <span>${this.escapeHTML(productName)}</span>
                        <strong>Còn ${this.formatNumber(quantity)}</strong>
                    </div>

                    <div class="stock-progress">
                        <div 
                            class="stock-bar"
                            style="width: ${percent}%;"
                        ></div>
                    </div>
                </div>
            `;
        }).join('');
    }

    renderTopProductIfContainerExists() {
        const container = document.getElementById('topProductContainer');

        if (!container) return;

        if (!this.topProducts.length) {
            container.innerHTML = `
                <span>Bán chạy nhất</span>
                <h3>Chưa có dữ liệu</h3>
                <button>Chi tiết sản phẩm</button>
            `;
            return;
        }

        const top = this.topProducts[0];

        const productName = top.ProductName || top.product_name || top.name || 'Sản phẩm';
        const totalSold = top.totalSold || top.total_sold || top.quantity || 0;

        container.innerHTML = `
            <span>Bán chạy nhất</span>

            <h3>${this.escapeHTML(productName)}</h3>

            <p>
                Đã bán:
                ${this.formatNumber(totalSold)}
                sản phẩm
            </p>

            <button>Chi tiết sản phẩm</button>
        `;
    }

    /* =====================================================
       EVENTS
    ===================================================== */

    bindEvents() {
        const detailButtons = document.querySelectorAll('.promo-card button');

        detailButtons.forEach(button => {
            button.addEventListener('click', () => {
                const topProduct = this.topProducts[0];

                if (!topProduct) {
                    alert('Chưa có dữ liệu sản phẩm bán chạy');
                    return;
                }

                const productId =
                    topProduct.ProductID ||
                    topProduct.product_id ||
                    topProduct.id;

                if (productId) {
                    window.location.href = `/product-manager/products`;
                } else {
                    alert('Không tìm thấy ID sản phẩm');
                }
            });
        });
    }

    /* =====================================================
       HELPERS
    ===================================================== */

    setText(id, value) {
        const el = document.getElementById(id);

        if (el) {
            el.textContent = value;
        }
    }

    pickValue(...values) {
        for (const value of values) {
            if (value !== undefined && value !== null && value !== '') {
                return value;
            }
        }

        return 0;
    }

    formatCurrency(value) {
        if (typeof value === 'string' && value.includes('đ')) {
            return value;
        }

        return Number(value || 0).toLocaleString('vi-VN') + ' đ';
    }

    formatNumber(value) {
        return Number(value || 0).toLocaleString('vi-VN');
    }

    calculateStockPercent(quantity, minStock) {
        if (!minStock || minStock <= 0) {
            return quantity > 0 ? 100 : 0;
        }

        const percent = Math.round((quantity / minStock) * 100);

        if (percent < 5) return 5;
        if (percent > 100) return 100;

        return percent;
    }

    getStatusText(status) {
        const statusMap = {
            PENDING: 'Chờ xử lý',
            CONFIRMED: 'Đã xác nhận',
            PROCESSING: 'Đang xử lý',
            SHIPPING: 'Đang giao',
            COMPLETED: 'Hoàn thành',
            CANCELLED: 'Đã hủy'
        };

        return statusMap[status] || status || 'Không rõ';
    }

    escapeHTML(value) {
        return String(value ?? '')
            .replaceAll('&', '&amp;')
            .replaceAll('<', '&lt;')
            .replaceAll('>', '&gt;')
            .replaceAll('"', '&quot;')
            .replaceAll("'", '&#039;');
    }
}

document.addEventListener('DOMContentLoaded', () => {
    new SaleDashboard();
});