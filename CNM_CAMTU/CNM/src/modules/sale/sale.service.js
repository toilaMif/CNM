const saleRepository = require('./sale.repository');
const authRepo = require('../auth/auth.repository');
const userRepository = require('../users/user.repository');
const bcrypt = require('bcryptjs');
const { pool } = require('../../config/database');
const mailService = require('../mail/mail.service');

class SaleService {

    async getDashboardData() {

        const [
            revenue,
            orders,
            pending,
            customers,
            recentOrders,
            topProducts,
            lowStock,
            debt
        ] = await Promise.all([

            saleRepository.getTotalRevenue(),
            saleRepository.getTotalOrders(),
            saleRepository.getPendingOrders(),
            saleRepository.getTotalCustomers(),

            saleRepository.getRecentOrders(5),
            saleRepository.getTopSellingProducts(5),

            // Tồn kho là dữ liệu chung toàn hệ thống
            saleRepository.getLowStockProducts(5),

            saleRepository.getTotalDebt()
        ]);

        return {
            stats: {
                revenue: revenue?.totalRevenue || 0,
                totalRevenue: revenue?.totalRevenue || 0,

                totalOrders: orders?.totalOrders || 0,
                pendingOrders: pending?.pendingOrders || 0,

                totalCustomers: customers?.totalCustomers || 0,

                // HTML cũ của bạn có dùng totalAgents
                totalAgents: customers?.totalCustomers || 0,

                totalDebt: debt?.totalDebt || 0
            },

            // JS cũ có thể dùng recentOrders
            recentOrders: recentOrders || [],

            // HTML dashboard của bạn đang dùng logs
            logs: recentOrders || [],

            topProducts: topProducts || [],
            lowStock: lowStock || []
        };
    }

    // async getCustomers(saleUserId) {
    //     return await saleRepository.getCustomersBySaleId(saleUserId);
    // }

    async getAllCustomers() {
        return await saleRepository.getAllCustomers();
    }

// =========================
// CREATE CUSTOMER (WITH PROFILE)
// =========================
    async createCustomer(data) {

        const conn = await pool.getConnection();

        try {
            await conn.beginTransaction();

            const {
                email,
                company_name,
                address,
                credit_limit,
                full_name,
                phone_number,
                gender,
                date_of_birth,
                tax_code,
                created_by // ADD
            } = data;

            if (!email || !company_name) {
                throw new Error("Missing required fields");
            }

            // CHECK EMAIL
            const exist = await authRepo.findByEmail(email);

            if (exist) {
                throw new Error("Email already exists");
            }

            // GENERATE PASSWORD
            const rawPassword = this.generatePassword();

            const hashedPassword = await bcrypt.hash(rawPassword, 10);

            // 1. CREATE USER
            const userId = await saleRepository.createUser(conn, {
                email,
                password: hashedPassword,
                role_id: 2,
                created_by: created_by || null // ADD
            });

            // 2. CREATE CUSTOMER
            const customerId = await saleRepository.createCustomer(conn, {
                user_id: userId,
                company_name,
                address: address || null,
                credit_limit: credit_limit || 10000000,
                tax_code: tax_code || null,
                
            });

            // 3. CREATE PROFILE
            await saleRepository.createProfile(conn, {
                user_id: userId,
                full_name: full_name || company_name,
                phone_number: phone_number || null,
                gender: gender || 'hidden',
                avatar_url: 'default-avatar.png',
                address: address || null,
                date_of_birth: date_of_birth || null
            });

            await conn.commit();

            // SEND MAIL
            try {
                await mailService.sendAccountEmail(email, rawPassword);
            } catch (err) {
                console.error("Mail error:", err.message);
            }

            return { userId, customerId };

        } catch (err) {

            await conn.rollback();

            throw err;

        } finally {

            conn.release();
        }
    }

    // helper
    generatePassword() {
        return Math.random().toString(36).slice(-8);
    }


    /* ================= DELETE CUSTOMER USER ================= */
    async deleteCustomerUser(userId) {

        const id = Number(userId);

        if (!id || Number.isNaN(id)) {
            throw new Error('ID không hợp lệ');
        }

        const result = await saleRepository.softDeleteCustomer(id, 0);

        if (!result || result.affectedRows === 0) {
            throw new Error('Không tìm thấy user');
        }

        return {
            success: true,
            message: 'Xóa tài khoản khách hàng thành công',
            userId: id
        };
    }


    async updateCustomer(customerId, data) {
        const {
            email,
            full_name,
            phone_number,
            gender,
            date_of_birth,
            company_name,
            tax_code,
            credit_limit,
            address
        } = data;

        if (!company_name || company_name.trim() === '') {
            throw new Error('Tên công ty / đại lý không được để trống');
        }

        if (!email || email.trim() === '') {
            throw new Error('Email không được để trống');
        }

        const customer = await saleRepository.findCustomerById(customerId);

        if (!customer) {
            throw new Error('Không tìm thấy khách hàng');
        }

        const emailOwner = await saleRepository.findUserByEmail(email);

        if (emailOwner && Number(emailOwner.id) !== Number(customer.user_id)) {
            throw new Error('Email đã được sử dụng bởi tài khoản khác');
        }

        await saleRepository.updateCustomerFull(customerId, {
            user_id: customer.user_id,
            email: email.trim(),
            full_name: full_name || company_name,
            phone_number: phone_number || null,
            gender: gender || 'hidden',
            date_of_birth: date_of_birth || null,
            company_name: company_name.trim(),
            tax_code: tax_code || null,
            credit_limit: credit_limit || 10000000,
            address: address || null
        });

        return {
            customerId,
            userId: customer.user_id
        };
    }


}

module.exports = new SaleService();