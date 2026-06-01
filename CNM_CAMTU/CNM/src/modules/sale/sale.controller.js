const saleService = require('./sale.service');
const userService = require('../users/user.service');

class SaleController {

    async dashboard(req, res) {

        try {
            const saleUserId = req.user.id;

            const data = await saleService.getDashboardData(saleUserId);

            const stats = data?.stats || {};

            return res.render('sale/dashboard', {

                title: 'Sale Dashboard',
                user: req.user,
                activeMenu: 'dashboard',

                summary: {
                    totalRevenue: stats.totalRevenue || stats.revenue || 0,
                    totalAgents: stats.totalAgents || stats.totalCustomers || 0,
                    totalCustomers: stats.totalCustomers || stats.totalAgents || 0,
                    totalOrders: stats.totalOrders || 0,
                    pendingOrders: stats.pendingOrders || 0,
                    totalDebt: stats.totalDebt || 0
                },

                logs: data.logs || data.recentOrders || [],
                lowStock: data.lowStock || [],
                topProducts: data.topProducts || []
            });

        } catch (error) {

            console.error('SALE DASHBOARD ERROR:', error);

            return res.status(500).json({
                success: false,
                message: error.message
            });
        }
    }

    // async getCustomers(req, res, next) {
    //     try {
    //         const saleUserId = req.user.id;

    //         const customers = await saleService.getCustomers(saleUserId);

    //         return res.status(200).json({
    //             success: true,
    //             customers
    //         });

    //     } catch (err) {
    //         next(err);
    //     }
    // }

    async getCustomers(req, res, next) {
        try {
            const customers = await saleService.getAllCustomers();

            return res.status(200).json({
                success: true,
                customers
            });

        } catch (err) {
            next(err);
        }
    }




    async createCustomer(req, res, next) {

        try {

            const result = await saleService.createCustomer({
                ...req.body,
                created_by: req.user.id
            });

            res.status(201).json({
                success: true,
                message: "Customer created successfully",
                data: result
            });

        } catch (err) {

            next(err);

        }
    }



/* ================= DELETE CUSTOMER USER ================= */
    async deleteCustomerUser(req, res, next) {

        try {

            const result = await saleService.deleteCustomerUser(
                req.params.id
            );

            return res.status(200).json(result);

        } catch (error) {
            next(error);
        }
    }
/* ================= Update CUSTOMER USER ================= */
    async updateCustomer(req, res, next) {
        try {
            const customerId = Number(req.params.id);

            if (!customerId || Number.isNaN(customerId)) {
                return res.status(400).json({
                    success: false,
                    message: 'ID khách hàng không hợp lệ'
                });
            }

            const result = await saleService.updateCustomer(customerId, req.body);

            return res.status(200).json({
                success: true,
                message: 'Cập nhật khách hàng thành công',
                data: result
            });

        } catch (err) {
            next(err);
        }
    }


}


module.exports = new SaleController();