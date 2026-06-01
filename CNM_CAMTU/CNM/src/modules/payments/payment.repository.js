const { pool } = require('../../config/database');

function getDb(connection = null) {
  return connection || pool;
}

const paymentRepository = {
  async withTransaction(callback) {
    const conn = await pool.getConnection();

    try {
      await conn.beginTransaction();

      const result = await callback(conn);

      await conn.commit();

      return result;
    } catch (err) {
      await conn.rollback();
      throw err;
    } finally {
      conn.release();
    }
  },

  /* =========================================================
     ORDER
  ========================================================= */

  async getOrderForUpdate(orderId, connection) {
    const db = getDb(connection);

    const [[row]] = await db.execute(
      `
      SELECT *
      FROM orders
      WHERE order_id = ?
      FOR UPDATE
      `,
      [orderId]
    );

    return row || null;
  },

  async getOldestUnpaidOrderByCustomer(customerId, connection) {
    const db = getDb(connection);

    const [[row]] = await db.execute(
      `
      SELECT order_id
      FROM orders
      WHERE customer_id = ?
        AND payment_status IN ('UNPAID', 'PARTIAL', 'OVERDUE')
        AND status <> 'CANCELLED'
      ORDER BY created_at ASC, order_id ASC
      LIMIT 1
      `,
      [customerId]
    );

    return row || null;
  },

  async updateOrderPayment({
    order_id,
    paid_amount,
    remaining_amount,
    payment_status
  }, connection) {
    const db = getDb(connection);

    await db.execute(
      `
      UPDATE orders
      SET paid_amount = ?,
          remaining_amount = ?,
          payment_status = ?,
          fully_paid_at = CASE
            WHEN ? = 'PAID' AND fully_paid_at IS NULL THEN NOW()
            ELSE fully_paid_at
          END,
          updated_at = NOW()
      WHERE order_id = ?
      `,
      [
        paid_amount,
        remaining_amount,
        payment_status,
        payment_status,
        order_id
      ]
    );
  },

  async getPaymentTermByOrderId(orderId, connection) {
    const db = getDb(connection);

    const [[row]] = await db.execute(
      `
      SELECT *
      FROM order_payment_terms
      WHERE order_id = ?
      LIMIT 1
      `,
      [orderId]
    );

    return row || null;
  },

  async updateOrderEarlyPayment({
    order_id,
    early_payment_days,
    early_commission_total
  }, connection) {
    const db = getDb(connection);

    await db.execute(
      `
      UPDATE orders
      SET early_payment_days = ?,
          late_payment_days = 0,
          early_commission_total = ?,
          late_interest_total = 0,
          updated_at = NOW()
      WHERE order_id = ?
      `,
      [
        early_payment_days,
        early_commission_total,
        order_id
      ]
    );
  },

  async updateOrderLatePayment({
    order_id,
    late_payment_days,
    late_interest_total
  }, connection) {
    const db = getDb(connection);

    await db.execute(
      `
      UPDATE orders
      SET early_payment_days = 0,
          late_payment_days = ?,
          early_commission_total = 0,
          late_interest_total = ?,
          updated_at = NOW()
      WHERE order_id = ?
      `,
      [
        late_payment_days,
        late_interest_total,
        order_id
      ]
    );
  },

  async clearOrderPaymentPenalty(orderId, connection) {
    const db = getDb(connection);

    await db.execute(
      `
      UPDATE orders
      SET early_payment_days = 0,
          late_payment_days = 0,
          early_commission_total = 0,
          late_interest_total = 0,
          updated_at = NOW()
      WHERE order_id = ?
      `,
      [orderId]
    );
  },

  /* =========================================================
     CUSTOMER
  ========================================================= */

  async getCustomerForUpdate(customerId, connection) {
    const db = getDb(connection);

    const [[row]] = await db.execute(
      `
      SELECT *
      FROM customers
      WHERE customer_id = ?
      FOR UPDATE
      `,
      [customerId]
    );

    return row || null;
  },

  async updateCustomerDebt(customerId, currentDebt, connection) {
    const db = getDb(connection);

    await db.execute(
      `
      UPDATE customers
      SET current_debt = ?
      WHERE customer_id = ?
      `,
      [
        currentDebt,
        customerId
      ]
    );
  },

  /* =========================================================
     BANK ACCOUNT
  ========================================================= */

  async getDefaultBankAccount(connection) {
    const db = getDb(connection);

    const [[row]] = await db.execute(
      `
      SELECT *
      FROM company_bank_accounts
      WHERE is_default = 1
        AND is_active = 1
      LIMIT 1
      `
    );

    return row || null;
  },

  /* =========================================================
     INSTALLMENT
  ========================================================= */

  async getNextInstallmentNo(orderId, connection) {
    const db = getDb(connection);

    const [[row]] = await db.execute(
      `
      SELECT COALESCE(MAX(installment_no), 0) + 1 AS next_installment_no
      FROM payment_installments
      WHERE order_id = ?
      `,
      [orderId]
    );

    return Number(row?.next_installment_no || 1);
  },

  async createInstallmentDraft({
    order_id,
    customer_id,
    installment_no,
    amount,
    created_by
  }, connection) {
    const db = getDb(connection);

    const [result] = await db.execute(
      `
      INSERT INTO payment_installments (
        order_id,
        customer_id,
        installment_no,
        input_amount,
        qr_amount,
        paid_amount,
        status,
        created_by,
        created_at,
        updated_at
      )
      VALUES (?, ?, ?, ?, ?, 0, 'DRAFT', ?, NOW(), NOW())
      `,
      [
        order_id,
        customer_id,
        installment_no,
        amount,
        amount,
        created_by || null
      ]
    );

    return result.insertId;
  },

  async markInstallmentQrCreated(paymentInstallmentId, connection) {
    const db = getDb(connection);

    await db.execute(
      `
      UPDATE payment_installments
      SET status = 'QR_CREATED',
          updated_at = NOW()
      WHERE payment_installment_id = ?
      `,
      [paymentInstallmentId]
    );
  },

  async getInstallmentForUpdate(paymentInstallmentId, connection) {
    const db = getDb(connection);

    const [[row]] = await db.execute(
      `
      SELECT *
      FROM payment_installments
      WHERE payment_installment_id = ?
      FOR UPDATE
      `,
      [paymentInstallmentId]
    );

    return row || null;
  },

  async markInstallmentPaid({
    payment_installment_id,
    paid_amount
  }, connection) {
    const db = getDb(connection);

    await db.execute(
      `
      UPDATE payment_installments
      SET paid_amount = ?,
          payment_date = NOW(),
          status = 'PAID',
          confirmed_by = NULL,
          updated_at = NOW()
      WHERE payment_installment_id = ?
      `,
      [
        paid_amount,
        payment_installment_id
      ]
    );
  },

  async getOrderInstallments(orderId) {
    const [rows] = await pool.execute(
      `
      SELECT
        pi.*,
        pq.payment_qr_id,
        pq.transfer_content,
        pq.qr_image_url,
        pq.status AS qr_status,
        pq.expired_at
      FROM payment_installments pi
      LEFT JOIN payment_qr_codes pq
        ON pi.payment_installment_id = pq.payment_installment_id
      WHERE pi.order_id = ?
      ORDER BY pi.installment_no ASC
      `,
      [orderId]
    );

    return rows;
  },

  /* =========================================================
     QR
  ========================================================= */

  async createQrCode({
    payment_installment_id,
    order_id,
    customer_id,
    bank_account_id,
    provider,
    qr_amount,
    transfer_content,
    qr_image_url,
    qr_payload,
    created_by
  }, connection) {
    const db = getDb(connection);

    const [result] = await db.execute(
      `
      INSERT INTO payment_qr_codes (
        payment_installment_id,
        order_id,
        customer_id,
        bank_account_id,
        provider,
        qr_amount,
        transfer_content,
        qr_image_url,
        qr_payload,
        expired_at,
        status,
        created_by,
        created_at,
        updated_at
      )
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, DATE_ADD(NOW(), INTERVAL 30 MINUTE), 'CREATED', ?, NOW(), NOW())
      `,
      [
        payment_installment_id,
        order_id,
        customer_id,
        bank_account_id,
        provider,
        qr_amount,
        transfer_content,
        qr_image_url,
        JSON.stringify(qr_payload || {}),
        created_by || null
      ]
    );

    return result.insertId;
  },

  async findCreatedQrByTransferContent(transferContent, connection) {
    const db = getDb(connection);

    const [[row]] = await db.execute(
      `
      SELECT *
      FROM payment_qr_codes
      WHERE UPPER(?) LIKE CONCAT('%', UPPER(transfer_content), '%')
        AND status = 'CREATED'
      ORDER BY created_at DESC
      LIMIT 1
      FOR UPDATE
      `,
      [transferContent]
    );

    return row || null;
  },

  async findCreatedQrByAccountAndAmount({
    account_no,
    amount
  }, connection) {
    const db = getDb(connection);

    const [[row]] = await db.execute(
      `
      SELECT pq.*
      FROM payment_qr_codes pq
      INNER JOIN company_bank_accounts ba
        ON pq.bank_account_id = ba.bank_account_id
      WHERE pq.status = 'CREATED'
        AND ba.account_no = ?
        AND pq.qr_amount = ?
      ORDER BY pq.created_at DESC
      LIMIT 1
      FOR UPDATE
      `,
      [
        account_no,
        amount
      ]
    );

    return row || null;
  },

  async findCreatedQrByAccountAmountAndRecent({
    account_no,
    amount,
    minutes = 60
  }, connection) {
    const db = getDb(connection);

    const [[row]] = await db.execute(
      `
      SELECT pq.*
      FROM payment_qr_codes pq
      INNER JOIN company_bank_accounts ba
        ON pq.bank_account_id = ba.bank_account_id
      WHERE pq.status = 'CREATED'
        AND ba.account_no = ?
        AND pq.qr_amount = ?
        AND pq.created_at >= DATE_SUB(NOW(), INTERVAL ? MINUTE)
      ORDER BY pq.created_at DESC
      LIMIT 1
      FOR UPDATE
      `,
      [
        account_no,
        amount,
        minutes
      ]
    );

    return row || null;
  },

  async markQrPaid(paymentQrId, connection) {
    const db = getDb(connection);

    await db.execute(
      `
      UPDATE payment_qr_codes
      SET status = 'PAID',
          updated_at = NOW()
      WHERE payment_qr_id = ?
      `,
      [paymentQrId]
    );
  },

  /* =========================================================
     PAYMENT
  ========================================================= */

  async findPaymentByTransactionCode(transactionCode, connection) {
    const db = getDb(connection);

    const [[row]] = await db.execute(
      `
      SELECT payment_id
      FROM payments
      WHERE transaction_code = ?
      LIMIT 1
      `,
      [transactionCode]
    );

    return row || null;
  },

  async createPayment({
    customer_id,
    order_id,
    payment_installment_id,
    payment_qr_id,
    amount,
    transaction_code,
    transfer_content,
    note
  }, connection) {
    const db = getDb(connection);

    const [result] = await db.execute(
      `
      INSERT INTO payments (
        customer_id,
        order_id,
        payment_installment_id,
        payment_qr_id,
        amount,
        method,
        transaction_code,
        transfer_content,
        payment_date,
        status,
        note,
        confirmed_at
      )
      VALUES (?, ?, ?, ?, ?, 'BANK_TRANSFER', ?, ?, NOW(), 'COMPLETED', ?, NOW())
      `,
      [
        customer_id,
        order_id,
        payment_installment_id,
        payment_qr_id,
        amount,
        transaction_code,
        transfer_content,
        note || 'Thanh toán tự động qua SePay webhook'
      ]
    );

    return result.insertId;
  },

  /* =========================================================
     WEBHOOK LOG
  ========================================================= */

  async createWebhookLog({
    provider,
    raw_payload,
    transfer_content,
    transaction_code,
    amount,
    process_status = 'RECEIVED',
    error_message = null
  }, connection) {
    const db = getDb(connection);

    const [result] = await db.execute(
      `
      INSERT INTO payment_webhook_logs (
        provider,
        raw_payload,
        transfer_content,
        transaction_code,
        amount,
        process_status,
        error_message,
        received_at,
        processed_at
      )
      VALUES (?, ?, ?, ?, ?, ?, ?, NOW(), ?)
      `,
      [
        provider || 'SEPAY',
        JSON.stringify(raw_payload || {}),
        transfer_content || null,
        transaction_code || null,
        Number.isFinite(amount) ? amount : null,
        process_status,
        error_message,
        process_status === 'RECEIVED' ? null : new Date()
      ]
    );

    return result.insertId;
  },

  async markWebhookFailed({
    webhook_log_id,
    error_message,
    qr = null
  }, connection) {
    const db = getDb(connection);

    await db.execute(
      `
      UPDATE payment_webhook_logs
      SET process_status = 'FAILED',
          matched_payment_qr_id = ?,
          matched_payment_installment_id = ?,
          matched_order_id = ?,
          error_message = ?,
          processed_at = NOW()
      WHERE webhook_log_id = ?
      `,
      [
        qr?.payment_qr_id || null,
        qr?.payment_installment_id || null,
        qr?.order_id || null,
        error_message,
        webhook_log_id
      ]
    );
  },

  async markWebhookDuplicated(webhookLogId, connection) {
    const db = getDb(connection);

    await db.execute(
      `
      UPDATE payment_webhook_logs
      SET process_status = 'DUPLICATED',
          processed_at = NOW()
      WHERE webhook_log_id = ?
      `,
      [webhookLogId]
    );
  },

  async markWebhookMatched({
    webhook_log_id,
    qr
  }, connection) {
    const db = getDb(connection);

    await db.execute(
      `
      UPDATE payment_webhook_logs
      SET process_status = 'MATCHED',
          matched_payment_qr_id = ?,
          matched_payment_installment_id = ?,
          matched_order_id = ?,
          processed_at = NOW()
      WHERE webhook_log_id = ?
      `,
      [
        qr.payment_qr_id,
        qr.payment_installment_id,
        qr.order_id,
        webhook_log_id
      ]
    );
  },

  /* =========================================================
     DEBT LOG
  ========================================================= */

  async createDebtLog({
    customer_id,
    order_id,
    payment_id,
    amount,
    balance_after,
    description
  }, connection) {
    const db = getDb(connection);

    await db.execute(
      `
      INSERT INTO debt_logs (
        customer_id,
        order_id,
        payment_id,
        type,
        reason,
        amount,
        balance_after,
        description,
        created_at
      )
      VALUES (?, ?, ?, 'DECREASE', 'PAYMENT', ?, ?, ?, NOW())
      `,
      [
        customer_id,
        order_id,
        payment_id,
        amount,
        balance_after,
        description
      ]
    );
  },

  /* =========================================================
     COMMISSION
  ========================================================= */

  async upsertEarlyPaymentCommission({
    customer_id,
    order_id,
    commission_amount,
    commission_rate_per_day,
    early_payment_days,
    base_amount,
    note
  }, connection) {
    const db = getDb(connection);

    const [result] = await db.execute(
      `
      INSERT INTO dealer_commissions (
        customer_id,
        order_id,
        commission_amount,
        commission_rate_per_day,
        early_payment_days,
        base_amount,
        source_type,
        status,
        note,
        created_at,
        updated_at
      )
      VALUES (?, ?, ?, ?, ?, ?, 'EARLY_PAYMENT', 'PENDING', ?, NOW(), NOW())
      ON DUPLICATE KEY UPDATE
        commission_amount = VALUES(commission_amount),
        commission_rate_per_day = VALUES(commission_rate_per_day),
        early_payment_days = VALUES(early_payment_days),
        base_amount = VALUES(base_amount),
        updated_at = NOW()
      `,
      [
        customer_id,
        order_id,
        commission_amount,
        commission_rate_per_day,
        early_payment_days,
        base_amount,
        note
      ]
    );

    return result.insertId || null;
  },

  async createCommissionLog({
    dealer_commission_id,
    customer_id,
    amount,
    note
  }, connection) {
    const db = getDb(connection);

    await db.execute(
      `
      INSERT INTO dealer_commission_logs (
        dealer_commission_id,
        customer_id,
        action,
        amount,
        old_status,
        new_status,
        note,
        created_at
      )
      VALUES (?, ?, 'CREATED', ?, NULL, 'PENDING', ?, NOW())
      `,
      [
        dealer_commission_id,
        customer_id,
        amount,
        note
      ]
    );
  }
};

module.exports = paymentRepository;