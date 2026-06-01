const { pool } = require('../../config/database');

class SaleRepository {


/* =====================================================
   DASHBOARD - REVENUE ALL
   Lấy tổng doanh thu toàn hệ thống, không lọc theo SALE
===================================================== */

async getTotalRevenue() {
    const [rows] = await pool.query(`
        SELECT 
            IFNULL(SUM(o.total_amount), 0) AS totalRevenue
        FROM orders o

        INNER JOIN customers c
            ON o.customer_id = c.customer_id

        INNER JOIN users u
            ON c.user_id = u.id

        WHERE o.status IN ('COMPLETED', 'SHIPPING')
          AND u.is_active = 1
    `);

    return rows[0];
}

async getTotalOrders() {
    const [rows] = await pool.query(`
        SELECT 
            COUNT(*) AS totalOrders
        FROM orders o

        INNER JOIN customers c
            ON o.customer_id = c.customer_id

        INNER JOIN users u
            ON c.user_id = u.id

        WHERE u.is_active = 1
    `);

    return rows[0];
}

async getPendingOrders() {
    const [rows] = await pool.query(`
        SELECT 
            COUNT(*) AS pendingOrders
        FROM orders o

        INNER JOIN customers c
            ON o.customer_id = c.customer_id

        INNER JOIN users u
            ON c.user_id = u.id

        WHERE o.status = 'PENDING'
          AND u.is_active = 1
    `);

    return rows[0];
}

async getTotalCustomers() {
    const [rows] = await pool.query(`
        SELECT 
            COUNT(*) AS totalCustomers
        FROM customers c

        INNER JOIN users u
            ON c.user_id = u.id

        WHERE u.is_active = 1
    `);

    return rows[0];
}

async getTotalDebt() {
    const [rows] = await pool.query(`
        SELECT 
            IFNULL(SUM(c.current_debt), 0) AS totalDebt
        FROM customers c

        INNER JOIN users u
            ON c.user_id = u.id

        WHERE u.is_active = 1
    `);

    return rows[0];
}

/* =====================================================
   DASHBOARD - LIST DATA ALL
   Lấy dữ liệu danh sách toàn hệ thống
===================================================== */

async getRecentOrders(limit = 5) {
    const [rows] = await pool.query(`
        SELECT 
            o.order_id,
            o.total_amount,
            o.status,
            o.created_at,
            c.company_name,

            u.created_by,
            creator.email AS sale_email

        FROM orders o

        INNER JOIN customers c
            ON o.customer_id = c.customer_id

        INNER JOIN users u
            ON c.user_id = u.id

        LEFT JOIN users creator
            ON u.created_by = creator.id

        WHERE u.is_active = 1

        ORDER BY o.created_at DESC

        LIMIT ?
    `, [Number(limit)]);

    return rows;
}

async getTopSellingProducts(limit = 5) {
    const [rows] = await pool.query(`
        SELECT 
            p.ProductID,
            p.ProductName,
            SUM(od.quantity) AS totalSold
        FROM order_details od

        INNER JOIN orders o
            ON od.order_id = o.order_id

        INNER JOIN customers c
            ON o.customer_id = c.customer_id

        INNER JOIN users u
            ON c.user_id = u.id

        INNER JOIN products p
            ON od.product_id = p.ProductID

        WHERE u.is_active = 1

        GROUP BY p.ProductID, p.ProductName

        ORDER BY totalSold DESC

        LIMIT ?
    `, [Number(limit)]);

    return rows;
}

/* =====================================================
   DASHBOARD - LOW STOCK
   Kho là dữ liệu chung
===================================================== */

async getLowStockProducts(limit = 5) {
    const [rows] = await pool.query(`
        SELECT
            p.ProductID,
            p.ProductName,
            i.Quantity,
            i.MinStockLevel,
            i.AvailableQuantity
        FROM inventory i

        INNER JOIN products p
            ON i.ProductID = p.ProductID

        WHERE i.Quantity <= i.MinStockLevel

        ORDER BY i.Quantity ASC

        LIMIT ?
    `, [Number(limit)]);

    return rows;
}

 async getAllCustomers() {
    const [rows] = await pool.query(`
        SELECT 
            c.customer_id,
            c.company_name,
            c.address AS company_address,
            c.credit_limit,
            c.current_debt,
            c.tax_code,

            u.id AS user_id,
            u.email,
            u.is_active,
            u.created_at,
            u.created_by,

            creator.email AS created_by_email,

            p.full_name,
            p.phone_number,
            p.gender,
            DATE_FORMAT(p.date_of_birth, '%Y-%m-%d') AS date_of_birth,
            p.address AS profile_address

        FROM customers c

        INNER JOIN users u
            ON c.user_id = u.id

        LEFT JOIN users creator
            ON u.created_by = creator.id

        LEFT JOIN profiles p
            ON p.user_id = u.id

        WHERE u.is_active = 1

        ORDER BY c.customer_id DESC
    `);

    return rows;
}

    /* ================= USERS ================= */

    async createUser(conn, data) {

        const [result] = await conn.query(`
            INSERT INTO users (
                email,
                password,
                role_id,
                created_by
            )
            VALUES (?, ?, ?, ?)
        `, [
            data.email,
            data.password,
            data.role_id,
            data.created_by || null
        ]);

        return result.insertId;
    }
    

    /* ================= CUSTOMER ================= */

    async createCustomer(conn, data) {
        const [result] = await conn.query(`
            INSERT INTO customers (
                user_id,
                company_name,
                address,
                credit_limit,
                current_debt,
                tax_code
            )
            VALUES (?, ?, ?, ?, 0,?)
        `, [
            data.user_id,
            data.company_name,
            data.address,
            data.credit_limit,
            data.tax_code
        ]);

        return result.insertId;
    }
    /* ================= Profile ================= */
    async createProfile(conn, data) {
        const [result] = await conn.query(`
            INSERT INTO profiles (
                user_id,
                full_name,
                phone_number,
                gender,
                avatar_url,
                address,
                date_of_birth
            )
            VALUES (?, ?, ?, ?, ?, ?, ?)
        `, [
            data.user_id,
            data.full_name,
            data.phone_number,
            data.gender,
            data.avatar_url,
            data.address,
            data.date_of_birth
        ]);

        return result.insertId;
    }


    async findCustomerById(customerId) {
        const [rows] = await pool.query(`
            SELECT 
                c.customer_id,
                c.user_id,
                c.company_name,
                c.address,
                c.credit_limit,
                c.current_debt,
                u.email,
                u.is_active
            FROM customers c
            INNER JOIN users u
                ON c.user_id = u.id
            WHERE c.customer_id = ?
            LIMIT 1
        `, [customerId]);

        return rows[0] || null;
    }

    async findUserByEmail(email) {
        const [rows] = await pool.query(`
            SELECT id, email
            FROM users
            WHERE email = ?
            LIMIT 1
        `, [email]);

        return rows[0] || null;
    }

    async updateCustomerFull(customerId, data) {
        const conn = await pool.getConnection();

        try {
            await conn.beginTransaction();

            await conn.query(`
                UPDATE users
                SET email = ?
                WHERE id = ?
            `, [
                data.email,
                data.user_id
            ]);

            const [profileRows] = await conn.query(`
                SELECT id
                FROM profiles
                WHERE user_id = ?
                LIMIT 1
            `, [data.user_id]);

            if (profileRows.length === 0) {
                await conn.query(`
                    INSERT INTO profiles (
                        user_id,
                        full_name,
                        phone_number,
                        gender,
                        avatar_url,
                        address,
                        date_of_birth
                    )
                    VALUES (?, ?, ?, ?, ?, ?, ?)
                `, [
                    data.user_id,
                    data.full_name,
                    data.phone_number,
                    data.gender,
                    'default-avatar.png',
                    data.address,
                    data.date_of_birth
                ]);
            } else {
                await conn.query(`
                    UPDATE profiles
                    SET 
                        full_name = ?,
                        phone_number = ?,
                        gender = ?,
                        address = ?,
                        date_of_birth = ?
                    WHERE user_id = ?
                `, [
                    data.full_name,
                    data.phone_number,
                    data.gender,
                    data.address,
                    data.date_of_birth,
                    data.user_id
                ]);
            }

            await conn.query(`
                UPDATE customers
                SET 
                    company_name = ?,
                    address = ?,
                    credit_limit = ?
                WHERE customer_id = ?
            `, [
                data.company_name,
                data.address,
                data.credit_limit,
                customerId
            ]);

            await conn.commit();

            return true;

        } catch (err) {
            await conn.rollback();
            throw err;
        } finally {
            conn.release();
        }
    }


/* =====================================================
   SOFT DELETE CUSTOMER
   Xóa mềm khách hàng bằng cách khóa user account
===================================================== */
    async softDeleteCustomer(userId) {
        const [result] = await pool.query(`
            UPDATE users
            SET 
                is_active = 0

            WHERE id = ?
        `, [userId]);

        return result.affectedRows > 0;
    }

}

module.exports = new SaleRepository();