const paymentService = require('./payment.service');

function isValidSepayApiKey(req) {
  const expectedApiKey = process.env.SEPAY_API_KEY;

  /*
    Nếu chưa cấu hình key thì bỏ qua check.
    Dùng để demo/test nhanh.
  */
  if (!expectedApiKey) {
    return true;
  }

  const authHeader = req.headers.authorization || '';
  const xApiKey = req.headers['x-api-key'] || '';
  const xSepayApiKey = req.headers['x-sepay-api-key'] || '';

  return (
    authHeader === expectedApiKey ||
    authHeader === `Apikey ${expectedApiKey}` ||
    authHeader === `APIKEY ${expectedApiKey}` ||
    authHeader === `Bearer ${expectedApiKey}` ||
    xApiKey === expectedApiKey ||
    xSepayApiKey === expectedApiKey
  );
}

const paymentController = {
  async createPaymentInstallment(req, res) {
    try {
      const orderId = Number(req.params.orderId);
      const amount = Number(req.body.amount);
      const createdBy = req.user?.id || req.user?.user_id || null;

      const result = await paymentService.createPaymentInstallment({
        order_id: orderId,
        amount,
        created_by: createdBy
      });

      return res.status(201).json({
        success: true,
        message: 'Tạo đợt thanh toán thành công',
        data: result
      });
    } catch (err) {
      console.error('Create payment installment error:', err);

      return res.status(400).json({
        success: false,
        message: err.message
      });
    }
  },

  async getOrderInstallments(req, res) {
    try {
      const orderId = Number(req.params.orderId);

      const installments =
        await paymentService.getOrderInstallments(orderId);

      return res.json({
        success: true,
        data: installments
      });
    } catch (err) {
      console.error('Get order installments error:', err);

      return res.status(400).json({
        success: false,
        message: err.message
      });
    }
  },

  async handlePaymentWebhook(req, res) {
    try {
      console.log('===== SEPAY WEBHOOK RECEIVED =====');
      console.log('Header authorization:', req.headers.authorization);
      console.log('Body:', req.body);
      console.log('Expected API Key exists:', Boolean(process.env.SEPAY_API_KEY));

      if (!isValidSepayApiKey(req)) {
        console.log('Sai SePay API Key');

        return res.status(401).json({
          success: false,
          message: 'SePay API Key không hợp lệ'
        });
      }

      const result = await paymentService.handlePaymentWebhook(req.body);

      console.log('Webhook xử lý xong:', result);

      /*
        SePay chỉ cần success true.
        Không cần trả data dài.
      */
      return res.status(200).json({
        success: true
      });
    } catch (err) {
      console.error('SePay webhook error:', err);

      /*
        Vẫn trả 200 để SePay không retry liên tục.
        Lỗi đã log ở terminal.
      */
      return res.status(200).json({
        success: true
      });
    }
  }
};

module.exports = paymentController;