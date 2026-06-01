const transporter = require('../../config/mailer');

const {
  accountEmailTemplate,
  purchaseOrderEmailTemplate,
  goodsReceiptIssueEmailTemplate
} = require('./mail.template');

const mailService = {

  /* =========================================================
     SEND ACCOUNT EMAIL
     Gửi email tài khoản cho user mới
  ========================================================= */
  async sendAccountEmail(email, password) {
    const html = accountEmailTemplate({ email, password });

    await transporter.sendMail({
      from: `"Agro System" <${process.env.EMAIL_USER}>`,
      to: email,
      subject: '🌿 Your Account Has Been Created',
      html,
    });
  },

  /* =========================================================
     SEND PURCHASE ORDER EMAIL
     Product Manager gửi đơn đặt hàng cho nhà cung cấp
  ========================================================= */
  async sendPurchaseOrderEmail({ supplier, purchaseOrder, items }) {
    if (!supplier?.email) {
      throw new Error('Nhà cung cấp chưa có email');
    }

    const html = purchaseOrderEmailTemplate({
      supplier,
      purchaseOrder,
      items
    });

    await transporter.sendMail({
      from: `"Agro System" <${process.env.EMAIL_USER}>`,
      to: supplier.email,
      subject: `🌿 Đơn đặt hàng ${purchaseOrder.po_code} từ Agro System`,
      html,
    });
  },

  /* =========================================================
     SEND GOODS RECEIPT ISSUE EMAIL
     Product Manager gửi email báo hàng lỗi cho nhà cung cấp

     Dùng cho:
     - Phiếu nhập kho có hàng lỗi
     - Gửi kèm ảnh lỗi trong attachments
  ========================================================= */
  async sendGoodsReceiptIssueEmail(to, receipt, items, attachments = []) {
    if (!to) {
      throw new Error('Nhà cung cấp chưa có email');
    }

    if (!receipt) {
      throw new Error('Thiếu thông tin phiếu nhận hàng');
    }

    if (!Array.isArray(items) || items.length === 0) {
      throw new Error('Không có sản phẩm lỗi để gửi email');
    }

    if (typeof goodsReceiptIssueEmailTemplate !== 'function') {
      throw new Error('goodsReceiptIssueEmailTemplate chưa được định nghĩa trong mail.template.js');
    }

    const html = goodsReceiptIssueEmailTemplate({
      receipt,
      items
    });

    await transporter.sendMail({
      from: `"Agro System" <${process.env.EMAIL_USER}>`,
      to,
      subject: `⚠️ Thông báo hàng lỗi - Phiếu ${receipt.receipt_code}`,
      html,
      attachments
    });
  }

};

module.exports = mailService;