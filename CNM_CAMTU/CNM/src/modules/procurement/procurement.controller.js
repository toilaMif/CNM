const procurementService = require('./procurement.service');

class ProcurementController {

    /* =========================================================
       GET /api/procurement/suppliers
    ========================================================= */
    async getSuppliers(req, res, next) {
        try {
            const suppliers = await procurementService.getSuppliers();

            return res.status(200).json({
                success: true,
                data: suppliers
            });

        } catch (err) {
            next(err);
        }
    }

    /* =========================================================
       POST /api/procurement/suppliers
    ========================================================= */
    async createSupplier(req, res, next) {
        try {
            const userId = req.user.id;

            const supplier = await procurementService.createSupplier(
                req.body,
                userId
            );

            return res.status(201).json({
                success: true,
                message: 'Tạo nhà cung cấp thành công',
                data: supplier
            });

        } catch (err) {
            next(err);
        }
    }

    /* =========================================================
       PURCHASE ORDERS
    ========================================================= */

    async getPurchaseOrders(req, res, next) {
        try {
            const purchaseOrders = await procurementService.getPurchaseOrders();

            return res.status(200).json({
                success: true,
                data: purchaseOrders
            });

        } catch (err) {
            next(err);
        }
    }

    async createPurchaseOrder(req, res, next) {
        try {
            const userId = req.user.id;

            const purchaseOrder = await procurementService.createPurchaseOrder(
                req.body,
                userId
            );

            return res.status(201).json({
                success: true,
                message: 'Tạo phiếu đặt hàng thành công',
                data: purchaseOrder
            });

        } catch (err) {
            next(err);
        }
    }

/* =========================================================
   GET /api/procurement/purchase-orders/pending-receive
========================================================= */
async getPendingReceivePurchaseOrders(req, res, next) {
    try {
        const purchaseOrders =
            await procurementService.getPendingReceivePurchaseOrders();

        return res.status(200).json({
            success: true,
            data: purchaseOrders
        });

    } catch (err) {
        next(err);
    }
}


/* =========================================================
   GET /api/procurement/purchase-orders/:id
========================================================= */
async getPurchaseOrderById(req, res, next) {
    try {
        const purchaseOrderId = Number(req.params.id);

        const purchaseOrder =
            await procurementService.getPurchaseOrderById(purchaseOrderId);

        return res.status(200).json({
            success: true,
            data: purchaseOrder
        });

    } catch (err) {
        next(err);
    }
}

}

module.exports = new ProcurementController();