const db = require('../../config/database'); 
const orderService = require('./order.service');

// ✅ Lấy tất cả đơn hàng
async function getAll(req, res, next) {
    try {
        const orders = await orderService.findAll();
        res.json(orders);
    } catch (err) {
        next(err);
    }
}

// ✅ Lấy 1 đơn hàng theo ID
async function getById(req, res, next) {
    try {
        const order = await orderService.findById(Number(req.params.id));
        if (!order) {
            return res.status(404).json({ message: 'Order not found' });
        }
        res.json(order);
    } catch (err) {
        next(err);
    }
}

// ✅ Tạo đơn hàng mới
async function create(req, res, next) {
    try {
        // 1. Chỉ lấy những gì khách hàng/đơn hàng cần từ Body
        const { customer_id, shipping_address, payment_term_template_id, items } = req.body;

        // 2. LẤY THÔNG TIN ĐỊNH DANH TỪ TOKEN (Xử lý linh hoạt tránh bị undefined)
        const staff_id = req.user.id; // Lấy ID (số) của người đang login (Ví dụ: 2)
        
        // CƠ CHẾ LINH HOẠT: Có email dùng email, không có thì ghép SALE + ID (Ví dụ: SALE_2)
        const create_by = req.user.email || `SALE_${req.user.id}`; 

        // 3. Validation dữ liệu đầu vào
        if (!customer_id || !payment_term_template_id || !items || !Array.isArray(items) || items.length === 0) {
            return res.status(400).json({ 
                success: false,
                message: 'Thiếu customer_id, payment_term_template_id hoặc danh sách sản phẩm trống.' 
            });
        }

        // Đoạn check email cũ đã được thay thế bằng chuỗi fallback an toàn ở trên, 
        // nên không sợ bị đứng app ở đây nữa bạn nhé!
        console.log(`>>> Sales ID: ${staff_id} (${create_by}) đang lập đơn cho khách: ${customer_id}`);

        // 4. Gọi Service xử lý (Hàm này giữ nguyên vì cấu trúc nhận dữ liệu đã sạch)
        const result = await orderService.create({
            customer_id,
            staff_id,         // Gửi số 2 xuống
            create_by,        // Gửi chuỗi 'SALE_2' xuống (không còn bị undefined hay 'admin' nữa)
            shipping_address: shipping_address || 'Tại cửa hàng',
            payment_term_template_id,
            items
        });

        // 5. Trả về kết quả
        return res.status(201).json(result);

    } catch (err) {
        console.error("❌ LỖI TẠI ORDER CONTROLLER:", err.message);
        return res.status(err.status || 500).json({ 
            success: false,
            message: err.message || 'Không thể tạo đơn hàng'
        });
    }
}

// ===== UI =====

// page list
// ===== UI =====

// page list
async function viewOrders(req, res, next) {
    try {
        console.log("=== CHECK USER ID TỪ TOKEN ===", req.user.id);
        
        // 1. Lấy danh sách đơn hàng
        const orders = await orderService.findAll();

        // [CHỈ THÊM ĐOẠN NÀY]: Truy vấn danh sách khách hàng (lấy cột địa chỉ để lọc khu vực) và sản phẩm
        const [customersRows] = await db.execute(`
            SELECT id, name AS customer_name, address FROM customers ORDER BY name ASC
        `).catch(err => {
            console.error("Lưu ý: Chưa lấy được danh sách khách hàng từ DB:", err.message);
            return [[]];
        });

        const [productsRows] = await db.execute(`
            SELECT id, name AS product_name, price FROM products WHERE status = 'ACTIVE' || 1 ORDER BY name ASC
        `).catch(err => {
            console.error("Lưu ý: Chưa lấy được danh sách sản phẩm từ DB:", err.message);
            return [[]];
        });

        // 2. Truy vấn Database
        const userId = req.user.id;
        const [rows] = await db.execute(`
            SELECT 
                u.email,
                p.full_name
            FROM users u
            LEFT JOIN profiles p ON u.id = p.user_id
            WHERE u.id = ?
        `, [userId]);

        // --- ĐOẠN ĐƯỢC CẢI TIẾN ĐỂ SỬA TRIỆT ĐỂ LỖI ---
        console.log("=== KẾT QUẢ TRUY VẤN RAW (ROWS) ===", rows);

        let currentUser = {
            id: userId,
            role_name: req.user.role_name,
            email: '',
            full_name: ''
        };

        // Bóc tách mảng an toàn: kiểm tra chắc chắn rows là mảng và có phần tử
        if (Array.isArray(rows) && rows.length > 0) {
            const dbUser = rows[0];
            console.log("=== OBJECT USER ĐẦU TIÊN TÌM THẤY ===", dbUser);
            
            currentUser.email = dbUser.email || '';
            currentUser.full_name = dbUser.full_name || '';
        }

        console.log("=== DỮ LIỆU CUỐI CÙNG GỬI SANG EJS ===", currentUser);

        // 4. Render giao diện (Đã bổ sung thêm biến customers và products vào đối tượng truyền đi)
        return res.render('pages/sale/orders', {
            title: 'Quản lý đơn hàng',
            orders: orders,
            customers: customersRows || [],
            products: productsRows || [],
            currentUser: currentUser 
        });

    } catch (err) {
        next(err);
    }
}

// page detail
async function viewDetail(req, res, next) {
    try {
        const order = await orderService.findById(req.params.id);
        res.render('order-detail', { order });
    } catch (err) {
        next(err);
    }
}

// page create
async function viewCreate(req, res) {
    try {
        const userId = req.user.id;

        const [rows] = await db.execute(`
            SELECT 
                u.email,
                p.full_name
            FROM users u
            LEFT JOIN profiles p ON u.id = p.user_id
            WHERE u.id = ?
        `, [userId]);

        const user = rows[0];

        res.render('order-create', {
            currentUser: user
        });

    } catch (err) {
        console.error(err);
        res.render('order-create', {
            currentUser: null
        });
    }
}

async function getCurrentUser(req, res) {
    try {
        const userId = req.user.id;

        const [rows] = await db.execute(`
            SELECT 
                u.id,
                u.email,
                p.full_name
            FROM users u
            LEFT JOIN profiles p ON u.id = p.user_id
            WHERE u.id = ?
        `, [userId]);

        res.json({
            success: true,
            user: rows[0]
        });

    } catch (err) {
        console.error(err);
        res.status(500).json({
            success: false,
            message: "Lỗi server"
        });
    }
}

// Thay thế hàm cancel cũ trong order.controller.js bằng hàm này:
const cancel = async (req, res) => {
    try {
        const orderId = Number(req.params.id);

        // Gọi sang tầng Service xử lý logic nặng và Transaction dữ liệu
        const result = await orderService.cancel(orderId);

        return res.status(200).json(result);
        
    } catch (error) {
        console.error("❌ LỖI CONTROLLER HỦY ĐƠN:", error.message);
        return res.status(500).json({
            success: false,
            message: "Lỗi hệ thống khi hủy đơn hàng: " + error.message
        });
    }
};

module.exports = {
    getAll,
    getById,
    create,
    viewOrders,
    viewDetail,
    viewCreate,
    getCurrentUser,
    cancel
};