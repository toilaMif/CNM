const express = require('express');
const router = express.Router();

const saleController = require('./sale.controller');

const {
    verifyAccessToken
} = require('../../core/middlewares/auth.middleware');

const {
    authorizeRoles
} = require('../../core/middlewares/role.middleware');


/* ======================================================
   SALE DASHBOARD
====================================================== */

router.get(
    '/dashboard',
    verifyAccessToken,
    authorizeRoles('SALE'),
    saleController.dashboard
);


/* ======================================================
   CUSTOMERS API
====================================================== */

router.get(
    '/customers',
    verifyAccessToken,
    authorizeRoles('SALE'),
    saleController.getCustomers
);

router.post(
    '/customers',
    verifyAccessToken,
    authorizeRoles('SALE'),
    saleController.createCustomer
);

router.put(
    '/customers/:id',
    verifyAccessToken,
    authorizeRoles('SALE'),
    saleController.updateCustomer
);

router.delete(
    '/customers/:id',
    verifyAccessToken,
    authorizeRoles('SALE'),
    saleController.deleteCustomerUser
);


module.exports = router;