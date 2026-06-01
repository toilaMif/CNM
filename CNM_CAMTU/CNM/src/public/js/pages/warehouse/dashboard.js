document.addEventListener("DOMContentLoaded", () => {

    // SEARCH
    const searchInput = document.querySelector(".search-box input");

    if (searchInput) {
        searchInput.addEventListener("keyup", (e) => {
            console.log("Tìm kiếm:", e.target.value);
        });
    }

    // NOTIFICATION
    const notificationBtn = document.querySelector(".notification-btn");

    if (notificationBtn) {
        notificationBtn.addEventListener("click", () => {
            alert("Bạn có 3 thông báo mới!");
        });
    }

    // ===== CLICK ITEM → MỞ CHI TIẾT XỔ XUỐNG =====
    const shippingItems = document.querySelectorAll(".shipping-item");

    shippingItems.forEach(item => {
        item.addEventListener("click", (e) => {
            // Nếu click trúng nút xác nhận hoặc bảng chi tiết bên trong thì không đóng/mở dòng
            if (e.target.closest(".confirm-btn") || e.target.closest(".order-detail")) {
                return;
            }

            const orderId = item.dataset.id;
            const detailContainer = document.getElementById(`order-detail-${orderId}`);

            if (detailContainer) {
                // Nếu đang mở thì ẩn đi, nếu đang ẩn thì gọi hàm viewOrder để tải dữ liệu và mở ra
                if (detailContainer.style.display === "block") {
                    detailContainer.style.display = "none";
                } else {
                    viewOrder(orderId);
                }
            }
        });
    });

    // ===== SHIPPING BUTTONS =====
    const shippingButtons = document.querySelectorAll(".shipping-item button");

    shippingButtons.forEach(button => {
        button.addEventListener("click", async (e) => {
            e.stopPropagation();

            const item = button.closest(".shipping-item");
            const orderId = item.dataset.id;

            // 🔥 CONFIRM CUSTOM
            const confirmBox = document.createElement("div");
            confirmBox.className = "confirm-box";

            confirmBox.innerHTML = `
                <div class="confirm-content">
                    <p>Bạn chắc chắn muốn xuất kho đơn này?</p>
                    <div class="confirm-actions">
                        <button class="btn-confirm">Xuất</button>
                        <button class="btn-cancel">Huỷ</button>
                    </div>
                </div>
            `;

            document.body.appendChild(confirmBox);

            // HANDLE BUTTONS
            confirmBox.querySelector(".btn-cancel").onclick = () => {
                confirmBox.remove();
            };

            confirmBox.querySelector(".btn-confirm").onclick = async () => {
                try {
                    const res = await fetch(`/api/inventory/confirm-export/${orderId}`, {
                        method: "POST",
                        headers: {
                            "Content-Type": "application/json"
                        }
                    });

                    const result = await res.json();

                    if (result.success) {
                        // ✅ ĐỔI TRẠNG THÁI UI
                        button.innerText = "SHIPPED";
                        button.style.background = "#4caf50";
                        button.disabled = true;

                        // Cập nhật trạng thái text bên trong khung chi tiết tương ứng nếu nó đang mở
                        const detailContainer = document.getElementById(`order-detail-${orderId}`);
                        if (detailContainer) {
                            const statusEl = detailContainer.querySelector(".d-status");
                            if (statusEl) statusEl.innerText = "SHIPPED";
                        }
                    } else {
                        alert(result.message);
                    }
                } catch (err) {
                    console.error(err);
                    alert("Lỗi kết nối server");
                }

                confirmBox.remove();
            };
        });
    });

    // ===== CLOSE EVENTS FOR COLLAPSIBLE =====
    // Vì không dùng dạng Modal nữa, sự kiện click bên ngoài vùng trống để đóng sẽ quét qua tất cả các detail đang mở
    window.addEventListener("click", (e) => {
        if (!e.target.closest(".shipping-item")) {
            const allDetails = document.querySelectorAll(".order-detail");
            allDetails.forEach(detail => {
                detail.style.display = "none";
            });
        }
    });
});

// ===== FUNCTION CONFIRM (GIỮ NGUYÊN THEO CODE CŨ) =====
async function confirmOrder(orderId) {
    if (!confirm("Xác nhận xuất kho đơn này?")) return;

    try {
        const res = await fetch(`/api/orders/${orderId}/confirm`, {
            method: "POST"
        });

        const result = await res.json();

        if (result.success) {
            alert("Đã xuất kho!");
            location.reload();
        } else {
            alert(result.message);
        }
    } catch (err) {
        console.error(err);
        alert("Lỗi server");
    }
}

// ===== VIEW ORDER (ĐÃ FIX ĐỂ KHỚP VỚI KHỐI CHI TIẾT TỪNG ITEM TRONG FILE HTML) =====
async function viewOrder(orderId) {
    // Thay vì tìm modal chung, ta đi tìm chính xác khối detail nằm dưới đơn hàng được bấm
    const detailContainer = document.getElementById(`order-detail-${orderId}`);

    if (!detailContainer) {
        console.error(`Không tìm thấy khung chi tiết nào có ID order-detail-${orderId} trong HTML!`);
        return;
    }

    try {
        // Hiển thị trạng thái chờ trong khi tải dữ liệu từ API
        const tbody = detailContainer.querySelector(".d-items");
        if (tbody) tbody.innerHTML = `<tr><td colspan="4" style="text-align:center; color:#999;">Đang tải...</td></tr>`;
        detailContainer.style.display = "block";

        // Gọi API lấy dữ liệu JSON
        const res = await fetch(`/api/orders/${orderId}`);
        if (!res.ok) throw new Error("Lỗi kết nối API");
        
        const order = await res.json();

        // Điền thông tin chung vào các thẻ tương ứng của CHÍNH ĐƠN HÀNG ĐÓ
        if (detailContainer.querySelector(".d-order-id")) detailContainer.querySelector(".d-order-id").innerText = order.order_id;
        if (detailContainer.querySelector(".d-customer")) detailContainer.querySelector(".d-customer").innerText = order.company_name || order.customer_name;
        if (detailContainer.querySelector(".d-address")) detailContainer.querySelector(".d-address").innerText = order.shipping_address || "Chưa cập nhật";
        if (detailContainer.querySelector(".d-status")) detailContainer.querySelector(".d-status").innerText = order.status;

        // Điền danh sách sản phẩm vào bảng
        if (tbody) {
            tbody.innerHTML = "";
            if (order.items && order.items.length > 0) {
                order.items.forEach(item => {
                    tbody.innerHTML += `
                        <tr>
                            <td><strong>${item.product_name || item.ProductName}</strong></td>
                            <td>x${item.quantity}</td>
                            <td>${Number(item.price).toLocaleString()}đ</td>
                            <td>${Number(item.subtotal || (item.quantity * item.price)).toLocaleString()}đ</td>
                        </tr>
                    `;
                });
            } else {
                tbody.innerHTML = `<tr><td colspan="4" style="text-align:center; color:#999;">Đơn hàng trống</td></tr>`;
            }
        }

    } catch (err) {
        console.error("Lỗi khi tải chi tiết đơn hàng:", err);
        alert("Không thể tải thông tin chi tiết đơn hàng lúc này.");
        if (detailContainer) detailContainer.style.display = "none";
    }
}

// ===== CLOSE MODAL FUNCTION (GIỮ NGUYÊN THEO CODE CŨ) =====
function closeModal() {
    const allDetails = document.querySelectorAll(".order-detail");
    allDetails.forEach(detail => {
        detail.style.display = "none";
    });
}

