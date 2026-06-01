/* =========================================================
   QR SERVICE

   Với tài khoản SePay của bạn:
   - QR do SePay tạo mới làm SePay gọi webhook ổn định.
   - QR tự build từ code có thể chuyển khoản được nhưng SePay không gọi webhook.

   File này vẫn trả qr_image_url tham khảo để không vỡ frontend.
   Nhưng khi demo thật:
   - Tạo đợt thanh toán trong backend trước.
   - Dùng QR SePay có cùng tài khoản + cùng số tiền.
   - Webhook sẽ match bằng accountNumber + amount nếu content không có AGRO.
========================================================= */

function normalizeText(value) {
  return String(value || '')
    .trim()
    .replace(/\s+/g, ' ');
}

function validateQrInput({
  bank_code,
  bank_bin,
  account_no,
  amount,
  transfer_content
}) {
  const realBankCode = String(bank_code || bank_bin || '').trim();
  const realAccountNo = String(account_no || '').trim();
  const realTransferContent = normalizeText(transfer_content);
  const realAmount = Number(amount);

  if (!realBankCode) {
    throw new Error('Thiếu bank_code hoặc bank_bin để tạo QR');
  }

  if (!realAccountNo) {
    throw new Error('Thiếu account_no để tạo QR');
  }

  if (!Number.isFinite(realAmount) || realAmount <= 0) {
    throw new Error('Số tiền QR không hợp lệ');
  }

  if (!realTransferContent) {
    throw new Error('Thiếu nội dung chuyển khoản');
  }

  return {
    bank_code: realBankCode,
    account_no: realAccountNo,
    amount: realAmount,
    transfer_content: realTransferContent
  };
}

function buildSepayReferenceQrUrl({
  bank_code,
  account_no,
  amount,
  transfer_content
}) {
  const params = new URLSearchParams({
    acc: account_no,
    bank: bank_code,
    amount: String(amount),
    des: transfer_content,
    template: 'compact'
  });

  return `https://qr.sepay.vn/img?${params.toString()}`;
}

async function generateQr({
  bank_code,
  bank_bin,
  account_no,
  account_name,
  amount,
  transfer_content
}) {
  const realBankCode = bank_code || bank_bin;

  const valid = validateQrInput({
    bank_code: realBankCode,
    bank_bin,
    account_no,
    amount,
    transfer_content
  });

  let sepayDescription = valid.transfer_content;

  const normalizedBank = String(valid.bank_code || '').toLowerCase();

  // VietinBank cá nhân/hộ kinh doanh yêu cầu nội dung có SEVQR
  if (
    normalizedBank.includes('vietin') ||
    normalizedBank === '970415'
  ) {
    sepayDescription = `SEVQR ${valid.transfer_content}`;
  }

  const qrImageUrl = buildSepayReferenceQrUrl({
    bank_code: valid.bank_code,
    account_no: valid.account_no,
    amount: valid.amount,
    transfer_content: sepayDescription
  });

  return {
    provider: 'SEPAY_QR',

    qr_image_url: qrImageUrl,

    raw_payload: {
      provider: 'SEPAY_QR',
      note:
        'QR SePay. Với VietinBank cá nhân/hộ kinh doanh, nội dung cần có SEVQR để SePay nhận diện giao dịch.',
      bank_code: valid.bank_code,
      bank_bin: bank_bin || valid.bank_code,
      account_no: valid.account_no,
      account_name: account_name || '',
      amount: valid.amount,
      transfer_content: valid.transfer_content,
      sepay_description: sepayDescription,
      qr_url: qrImageUrl
    }
  };
}
module.exports = {
  generateQr
};