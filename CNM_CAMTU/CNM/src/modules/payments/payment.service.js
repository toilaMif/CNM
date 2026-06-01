const paymentRepository = require('./payment.repository');
const qrService = require('./qr.service');

/* =========================================================
   BASIC HELPERS
========================================================= */

function assertPositiveAmount(amount) {
  const value = Number(amount);

  if (!Number.isFinite(value) || value <= 0) {
    throw new Error('Số tiền thanh toán phải lớn hơn 0');
  }

  return value;
}

function normalizeText(value) {
  return String(value || '')
    .trim()
    .replace(/\s+/g, ' ');
}

function normalizeAmount(value) {
  if (value === null || value === undefined) {
    return 0;
  }

  if (typeof value === 'number') {
    return value;
  }

  return Number(
    String(value)
      .replace(/[^\d.-]/g, '')
  );
}

function extractAgroCode(text) {
  const value = normalizeText(text).toUpperCase();
  const match = value.match(/AGRO\d+/);

  return match ? match[0] : null;
}

/* =========================================================
   WEBHOOK NORMALIZER
   Hỗ trợ payload thực tế SePay/VietinBank/Vietcombank:
   - accountNumber
   - content
   - description
   - transferAmount
   - referenceCode
   - accumulated
   - id
========================================================= */

function pickFirstTransaction(payload) {
  if (!payload || typeof payload !== 'object') {
    return {
      provider: 'SEPAY',
      raw: {},
      transaction: {}
    };
  }

  if (Array.isArray(payload.data) && payload.data.length > 0) {
    return {
      provider: payload.provider || payload.gateway || 'CASSO',
      raw: payload,
      transaction: payload.data[0]
    };
  }

  if (Array.isArray(payload.transactions) && payload.transactions.length > 0) {
    return {
      provider: payload.provider || payload.gateway || 'BANK_API',
      raw: payload,
      transaction: payload.transactions[0]
    };
  }

  return {
    provider:
      payload.provider ||
      payload.gateway ||
      payload.source ||
      'SEPAY',
    raw: payload,
    transaction: payload
  };
}

function normalizeWebhookPayload(payload) {
  const picked = pickFirstTransaction(payload);
  const tx = picked.transaction || {};

  const contentParts = [
    tx.transfer_content,
    tx.transferContent,
    tx.content,
    tx.description,
    tx.desc,
    tx.note,
    tx.addInfo,
    tx.remark,
    tx.transaction_content,
    tx.transactionContent,
    tx.payment_content,
    tx.paymentContent,
    tx.bank_content,
    tx.bankContent,
    tx.description_origin,
    tx.descriptionOrigin,
    tx.code,
    tx.paymentCode,
    tx.payment_code,
    tx.referenceCode,
    tx.reference_code
  ]
    .filter(Boolean)
    .map(normalizeText);

  const mergedContent = [...new Set(contentParts)].join(' ');
  const agroCode = extractAgroCode(mergedContent);

  const transactionCode =
    tx.transaction_code ||
    tx.transactionCode ||
    tx.transactionId ||
    tx.transaction_id ||
    tx.referenceCode ||
    tx.reference_code ||
    tx.tid ||
    tx.id ||
    tx.refNo ||
    tx.ref_no ||
    tx.bank_transaction_id ||
    tx.bankTransactionId ||
    tx.bank_sub_acc_id ||
    tx.bankSubAccId ||
    '';

  const rawAmount =
    tx.amount ??
    tx.transferAmount ??
    tx.transfer_amount ??
    tx.creditAmount ??
    tx.credit_amount ??
    tx.credit ??
    tx.money ??
    tx.amount_in ??
    tx.amountIn ??
    tx.value ??
    tx.moneyIn ??
    tx.money_in;

  const accountNumber =
    tx.accountNumber ||
    tx.account_number ||
    tx.accountNo ||
    tx.account_no ||
    tx.bankAccount ||
    tx.bank_account ||
    tx.subAccount ||
    tx.sub_account ||
    '';

  const type =
    tx.transferType ||
    tx.transfer_type ||
    tx.type ||
    tx.transactionType ||
    tx.transaction_type ||
    tx.io ||
    tx.direction ||
    tx.transaction_direction ||
    tx.transactionDirection ||
    '';

  return {
    provider: picked.provider || 'SEPAY',
    raw_payload: picked.raw,
    transfer_content: normalizeText(mergedContent),
    match_code: agroCode || normalizeText(mergedContent),
    transaction_code: String(transactionCode || '').trim(),
    amount: normalizeAmount(rawAmount),
    account_number: String(accountNumber || '').trim(),
    type: String(type || '').trim().toUpperCase()
  };
}

function isIncomingTransaction(normalized) {
  if (!normalized.type) {
    return true;
  }

  const incomingTypes = [
    'IN',
    'CREDIT',
    'DEPOSIT',
    'RECEIVE',
    'RECEIVED',
    'MONEY_IN',
    'INCOME'
  ];

  const outgoingTypes = [
    'OUT',
    'DEBIT',
    'WITHDRAW',
    'TRANSFER_OUT',
    'MONEY_OUT',
    'EXPENSE'
  ];

  if (outgoingTypes.includes(normalized.type)) {
    return false;
  }

  if (incomingTypes.includes(normalized.type)) {
    return true;
  }

  return true;
}

/* =========================================================
   ORDER FULLY PAID
========================================================= */

async function handleOrderFullyPaid({
  connection,
  order_id,
  customer_id
}) {
  const order = await paymentRepository.getOrderForUpdate(
    order_id,
    connection
  );

  const term = await paymentRepository.getPaymentTermByOrderId(
    order_id,
    connection
  );

  if (!order || !term || !order.fully_paid_at) {
    return;
  }

  const fullyPaidDate = new Date(order.fully_paid_at);
  const dueDate = new Date(term.due_date);

  fullyPaidDate.setHours(0, 0, 0, 0);
  dueDate.setHours(0, 0, 0, 0);

  const diffDays = Math.round(
    (fullyPaidDate.getTime() - dueDate.getTime()) /
      (1000 * 60 * 60 * 24)
  );

  if (diffDays < 0) {
    const earlyDays = Math.abs(diffDays);

    const commissionAmount =
      Number(order.total_amount) *
      Number(term.early_commission_rate_per_day || 0) *
      earlyDays;

    await paymentRepository.updateOrderEarlyPayment(
      {
        order_id,
        early_payment_days: earlyDays,
        early_commission_total: commissionAmount
      },
      connection
    );

    if (commissionAmount > 0) {
      const commissionId =
        await paymentRepository.upsertEarlyPaymentCommission(
          {
            customer_id,
            order_id,
            commission_amount: commissionAmount,
            commission_rate_per_day: term.early_commission_rate_per_day,
            early_payment_days: earlyDays,
            base_amount: order.total_amount,
            note: `Hoa hồng trả sớm ${earlyDays} ngày cho đơn hàng #${order_id}`
          },
          connection
        );

      if (commissionId) {
        await paymentRepository.createCommissionLog(
          {
            dealer_commission_id: commissionId,
            customer_id,
            amount: commissionAmount,
            note: `Tạo hoa hồng trả sớm cho đơn hàng #${order_id}`
          },
          connection
        );
      }
    }

    return;
  }

  if (diffDays > 0) {
    const lateDays = diffDays;

    const lateInterest =
      Number(order.total_amount) *
      Number(term.late_interest_rate_per_day || 0) *
      lateDays;

    await paymentRepository.updateOrderLatePayment(
      {
        order_id,
        late_payment_days: lateDays,
        late_interest_total: lateInterest
      },
      connection
    );

    return;
  }

  await paymentRepository.clearOrderPaymentPenalty(
    order_id,
    connection
  );
}

/* =========================================================
   CREATE INSTALLMENT
========================================================= */

async function createPaymentInstallment({
  order_id,
  amount,
  created_by
}) {
  return paymentRepository.withTransaction(async (connection) => {
    const paymentAmount = assertPositiveAmount(amount);

    const order = await paymentRepository.getOrderForUpdate(
      order_id,
      connection
    );

    if (!order) {
      throw new Error('Không tìm thấy đơn hàng');
    }

    if (
      order.status === 'CANCELLED' ||
      order.payment_status === 'CANCELLED'
    ) {
      throw new Error('Không thể thanh toán đơn hàng đã hủy');
    }

    if (
      order.payment_status === 'PAID' ||
      Number(order.remaining_amount || 0) <= 0
    ) {
      throw new Error('Đơn hàng đã thanh toán đủ');
    }

    const oldestUnpaidOrder =
      await paymentRepository.getOldestUnpaidOrderByCustomer(
        order.customer_id,
        connection
      );

    if (
      oldestUnpaidOrder &&
      Number(oldestUnpaidOrder.order_id) !== Number(order_id)
    ) {
      throw new Error(
        `Vui lòng thanh toán đơn hàng #${oldestUnpaidOrder.order_id} trước`
      );
    }

    if (paymentAmount > Number(order.remaining_amount)) {
      throw new Error(
        `Số tiền thanh toán không được vượt quá số tiền còn lại: ${Number(
          order.remaining_amount
        ).toLocaleString()}đ`
      );
    }

    const installmentNo =
      await paymentRepository.getNextInstallmentNo(
        order_id,
        connection
      );

    const paymentInstallmentId =
      await paymentRepository.createInstallmentDraft(
        {
          order_id,
          customer_id: order.customer_id,
          installment_no: installmentNo,
          amount: paymentAmount,
          created_by
        },
        connection
      );

    const bankAccount =
      await paymentRepository.getDefaultBankAccount(connection);

    if (!bankAccount) {
      throw new Error(
        'Chưa cấu hình tài khoản ngân hàng nhận tiền trong company_bank_accounts'
      );
    }

    const transferContent =
      `AGRO${String(order_id).padStart(5, '0')}${String(installmentNo).padStart(2, '0')}`;

    const qrResult = await qrService.generateQr({
      bank_code:
        bankAccount.sepay_bank_code ||
        bankAccount.bank_code ||
        bankAccount.bank_bin,
      bank_bin: bankAccount.bank_bin,
      account_no: bankAccount.account_no,
      account_name: bankAccount.account_name,
      amount: paymentAmount,
      transfer_content: transferContent
    });

    const paymentQrId =
      await paymentRepository.createQrCode(
        {
          payment_installment_id: paymentInstallmentId,
          order_id,
          customer_id: order.customer_id,
          bank_account_id: bankAccount.bank_account_id,
          provider: qrResult.provider,
          qr_amount: paymentAmount,
          transfer_content: transferContent,
          qr_image_url: qrResult.qr_image_url,
          qr_payload: qrResult.raw_payload,
          created_by
        },
        connection
      );

    await paymentRepository.markInstallmentQrCreated(
      paymentInstallmentId,
      connection
    );

    return {
      payment_installment_id: paymentInstallmentId,
      payment_qr_id: paymentQrId,
      order_id,
      installment_no: installmentNo,
      amount: paymentAmount,
      transfer_content: transferContent,
      qr_image_url: qrResult.qr_image_url,
      provider: qrResult.provider,
      match_note:
        'Nếu webhook SePay không chứa AGRO, hệ thống sẽ fallback match bằng accountNumber + amount.',
      expired_in_minutes: 30
    };
  });
}

/* =========================================================
   FIND QR FOR WEBHOOK
========================================================= */

async function findQrForWebhook({
  normalized,
  connection
}) {
  const transferContent = normalized.transfer_content;
  const matchCode = normalized.match_code;
  const amount = normalized.amount;
  const accountNumber = normalized.account_number;

  /*
    1. Ưu tiên match theo AGRO hoặc nội dung.
  */
  if (matchCode) {
    const qrByContent =
      await paymentRepository.findCreatedQrByTransferContent(
        matchCode,
        connection
      );

    if (qrByContent) {
      return {
        qr: qrByContent,
        match_method: 'TRANSFER_CONTENT'
      };
    }
  }

  if (transferContent && transferContent !== matchCode) {
    const qrByFullContent =
      await paymentRepository.findCreatedQrByTransferContent(
        transferContent,
        connection
      );

    if (qrByFullContent) {
      return {
        qr: qrByFullContent,
        match_method: 'FULL_CONTENT'
      };
    }
  }

  /*
    2. Fallback quan trọng cho QR SePay:
       webhook không có AGRO, chỉ có accountNumber + amount.
  */
  if (accountNumber && Number.isFinite(amount) && amount > 0) {
    const qrByAccountAndAmount =
      await paymentRepository.findCreatedQrByAccountAmountAndRecent(
        {
          account_no: accountNumber,
          amount,
          minutes: 120
        },
        connection
      );

    if (qrByAccountAndAmount) {
      return {
        qr: qrByAccountAndAmount,
        match_method: 'ACCOUNT_AMOUNT_RECENT'
      };
    }

    const qrByAccountAndAmountAnyTime =
      await paymentRepository.findCreatedQrByAccountAndAmount(
        {
          account_no: accountNumber,
          amount
        },
        connection
      );

    if (qrByAccountAndAmountAnyTime) {
      return {
        qr: qrByAccountAndAmountAnyTime,
        match_method: 'ACCOUNT_AMOUNT'
      };
    }
  }

  return {
    qr: null,
    match_method: null
  };
}

/* =========================================================
   HANDLE WEBHOOK
========================================================= */

async function handlePaymentWebhook(payload) {
  const normalized = normalizeWebhookPayload(payload);

  console.log('===== NORMALIZED SEPAY WEBHOOK =====');
  console.log(normalized);

  const transferContent = normalized.transfer_content;
  const transactionCode = normalized.transaction_code;
  const amount = normalized.amount;

  /*
    Ghi log TRƯỚC, KHÔNG nằm trong transaction.
    Như vậy nếu xử lý payment lỗi thì webhook_logs vẫn còn.
  */
  const webhookLogId = await paymentRepository.createWebhookLog({
    provider: normalized.provider,
    raw_payload: normalized.raw_payload,
    transfer_content: transferContent,
    transaction_code: transactionCode || null,
    amount: Number.isFinite(amount) ? amount : null,
    process_status: 'RECEIVED'
  });

  try {
    return await paymentRepository.withTransaction(async (connection) => {
      if (!isIncomingTransaction(normalized)) {
        await paymentRepository.markWebhookFailed(
          {
            webhook_log_id: webhookLogId,
            error_message: 'Không phải giao dịch tiền vào'
          },
          connection
        );

        return {
          success: false,
          ignored: true,
          reason: 'Không phải giao dịch tiền vào',
          webhook_log_id: webhookLogId
        };
      }

      if (
        !transactionCode ||
        !Number.isFinite(amount) ||
        amount <= 0
      ) {
        await paymentRepository.markWebhookFailed(
          {
            webhook_log_id: webhookLogId,
            error_message: 'Webhook thiếu transaction_code hoặc amount'
          },
          connection
        );

        return {
          success: false,
          reason: 'Webhook thiếu transaction_code hoặc amount',
          webhook_log_id: webhookLogId,
          normalized
        };
      }

      const existingPayment =
        await paymentRepository.findPaymentByTransactionCode(
          transactionCode,
          connection
        );

      if (existingPayment) {
        await paymentRepository.markWebhookDuplicated(
          webhookLogId,
          connection
        );

        return {
          success: true,
          duplicated: true,
          payment_id: existingPayment.payment_id,
          webhook_log_id: webhookLogId
        };
      }

      const { qr, match_method } = await findQrForWebhook({
        normalized,
        connection
      });

      if (!qr) {
        await paymentRepository.markWebhookFailed(
          {
            webhook_log_id: webhookLogId,
            error_message:
              'Không tìm thấy QR theo AGRO hoặc accountNumber + amount'
          },
          connection
        );

        return {
          success: false,
          matched: false,
          reason:
            'Không tìm thấy QR tương ứng theo AGRO hoặc accountNumber + amount',
          webhook_log_id: webhookLogId,
          transfer_content: transferContent,
          match_code: normalized.match_code,
          account_number: normalized.account_number,
          transaction_code: transactionCode,
          amount
        };
      }

      if (amount < Number(qr.qr_amount)) {
        await paymentRepository.markWebhookFailed(
          {
            webhook_log_id: webhookLogId,
            error_message: 'Số tiền thanh toán nhỏ hơn số tiền QR',
            qr
          },
          connection
        );

        return {
          success: false,
          matched: true,
          reason: 'Số tiền thanh toán nhỏ hơn số tiền QR',
          webhook_log_id: webhookLogId,
          expected_amount: Number(qr.qr_amount),
          received_amount: amount,
          payment_qr_id: qr.payment_qr_id,
          payment_installment_id: qr.payment_installment_id,
          order_id: qr.order_id
        };
      }

      const installment =
        await paymentRepository.getInstallmentForUpdate(
          qr.payment_installment_id,
          connection
        );

      const order =
        await paymentRepository.getOrderForUpdate(
          qr.order_id,
          connection
        );

      if (!installment || !order) {
        throw new Error('Không tìm thấy đợt thanh toán hoặc đơn hàng');
      }

      if (
        order.payment_status === 'PAID' ||
        Number(order.remaining_amount || 0) <= 0
      ) {
        await paymentRepository.markWebhookFailed(
          {
            webhook_log_id: webhookLogId,
            error_message: 'Đơn hàng đã thanh toán đủ',
            qr
          },
          connection
        );

        return {
          success: false,
          reason: 'Đơn hàng đã thanh toán đủ',
          webhook_log_id: webhookLogId,
          order_id: order.order_id
        };
      }

      const amountToApply = Math.min(
        amount,
        Number(order.remaining_amount)
      );

      const paymentNote =
        amount > amountToApply
          ? `Thanh toán tự động qua SePay. Khách chuyển dư ${amount - amountToApply}. Match bằng ${match_method}`
          : `Thanh toán tự động qua SePay. Match bằng ${match_method}`;

          const paymentId =
            await paymentRepository.createPayment(
              {
                customer_id: qr.customer_id,
                order_id: qr.order_id,
                payment_installment_id: qr.payment_installment_id,
                payment_qr_id: qr.payment_qr_id,
                amount: amountToApply,
                transaction_code: transactionCode,

                // Lưu mã QR ngắn trong hệ thống, ví dụ AGRO0001417
                transfer_content: qr.transfer_content,

                // Nội dung ngân hàng dài đưa vào note
                note: `${paymentNote}. Nội dung NH: ${transferContent}`
              },
              connection
            );

      await paymentRepository.markInstallmentPaid(
        {
          payment_installment_id: qr.payment_installment_id,
          paid_amount: amountToApply
        },
        connection
      );

      await paymentRepository.markQrPaid(
        qr.payment_qr_id,
        connection
      );

      const newPaidAmount =
        Number(order.paid_amount || 0) + amountToApply;

      const newRemainingAmount = Math.max(
        Number(order.total_amount) - newPaidAmount,
        0
      );

      const newPaymentStatus =
        newRemainingAmount <= 0 ? 'PAID' : 'PARTIAL';

      await paymentRepository.updateOrderPayment(
        {
          order_id: order.order_id,
          paid_amount: newPaidAmount,
          remaining_amount: newRemainingAmount,
          payment_status: newPaymentStatus
        },
        connection
      );

      const customer =
        await paymentRepository.getCustomerForUpdate(
          order.customer_id,
          connection
        );

      if (!customer) {
        throw new Error('Không tìm thấy khách hàng');
      }

      const newCustomerDebt = Math.max(
        Number(customer.current_debt || 0) - amountToApply,
        0
      );

      await paymentRepository.updateCustomerDebt(
        order.customer_id,
        newCustomerDebt,
        connection
      );

      await paymentRepository.createDebtLog(
        {
          customer_id: order.customer_id,
          order_id: order.order_id,
          payment_id: paymentId,
          amount: amountToApply,
          balance_after: newCustomerDebt,
          description: `Thanh toán đơn hàng #${order.order_id} qua SePay`
        },
        connection
      );

      if (newPaymentStatus === 'PAID') {
        await handleOrderFullyPaid({
          connection,
          order_id: order.order_id,
          customer_id: order.customer_id
        });
      }

      await paymentRepository.markWebhookMatched(
        {
          webhook_log_id: webhookLogId,
          qr
        },
        connection
      );

      return {
        success: true,
        payment_id: paymentId,
        order_id: order.order_id,
        payment_status: newPaymentStatus,
        paid_amount: newPaidAmount,
        remaining_amount: newRemainingAmount,
        amount_received: amount,
        amount_applied: amountToApply,
        match_method,
        webhook_log_id: webhookLogId
      };
    });
  } catch (err) {
    /*
      Nếu xử lý payment lỗi, vẫn cập nhật webhook log thành FAILED.
      Vì webhookLogId đã được tạo ngoài transaction nên không bị mất.
    */
    await paymentRepository.markWebhookFailed({
      webhook_log_id: webhookLogId,
      error_message: err.message || 'Lỗi xử lý webhook'
    });

    throw err;
  }
}

async function getOrderInstallments(orderId) {
  return paymentRepository.getOrderInstallments(orderId);
}

module.exports = {
  createPaymentInstallment,
  handlePaymentWebhook,
  getOrderInstallments,
  handleOrderFullyPaid
};