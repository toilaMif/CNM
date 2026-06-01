// Payment model for database field mapping
// Dùng cho bảng payments mới:
// payment_id, customer_id, order_id, payment_installment_id,
// payment_qr_id, amount, method, transaction_code,
// transfer_content, payment_date, status, note, confirmed_by, confirmed_at

const fields = {
  paymentId: 'payment_id',
  customerId: 'customer_id',
  orderId: 'order_id',
  paymentInstallmentId: 'payment_installment_id',
  paymentQrId: 'payment_qr_id',
  amount: 'amount',
  method: 'method',
  transactionCode: 'transaction_code',
  transferContent: 'transfer_content',
  paymentDate: 'payment_date',
  status: 'status',
  note: 'note',
  confirmedBy: 'confirmed_by',
  confirmedAt: 'confirmed_at',
  createdAt: 'created_at'
};

function toResponse(row) {
  if (!row) return null;

  return {
    paymentId: row.payment_id,
    customerId: row.customer_id,
    orderId: row.order_id,
    paymentInstallmentId: row.payment_installment_id,
    paymentQrId: row.payment_qr_id,

    amount: row.amount,
    method: row.method,

    transactionCode: row.transaction_code,
    transferContent: row.transfer_content,

    paymentDate: row.payment_date,
    status: row.status,
    note: row.note,

    confirmedBy: row.confirmed_by,
    confirmedAt: row.confirmed_at,
    createdAt: row.created_at,

    // Các field join thêm nếu repository có SELECT kèm
    customerName: row.customer_name,
    orderTotalAmount: row.order_total_amount,
    installmentNo: row.installment_no,
    qrTransferContent: row.qr_transfer_content,
    qrImageUrl: row.qr_image_url
  };
}

function toDatabase(payload) {
  return {
    customer_id: payload.customerId || payload.customer_id,
    order_id: payload.orderId || payload.order_id,

    payment_installment_id:
      payload.paymentInstallmentId || payload.payment_installment_id || null,

    payment_qr_id:
      payload.paymentQrId || payload.payment_qr_id || null,

    amount: payload.amount,

    method: payload.method || 'BANK_TRANSFER',

    transaction_code:
      payload.transactionCode || payload.transaction_code || null,

    transfer_content:
      payload.transferContent || payload.transfer_content || null,

    payment_date:
      payload.paymentDate || payload.payment_date || null,

    status: payload.status || 'COMPLETED',

    note: payload.note || null,

    confirmed_by:
      payload.confirmedBy || payload.confirmed_by || null,

    confirmed_at:
      payload.confirmedAt || payload.confirmed_at || null
  };
}

module.exports = {
  fields,
  toResponse,
  toDatabase
};