const aiAdvisorService = require('./ai-advisor.service');

// Tú thêm: controller nhận request AI advisor và trả JSON cho frontend chat.
function resolveStatusCode(error) {
  if (error.statusCode === 400) {
    return 400;
  }

  if (error.statusCode && error.statusCode >= 400 && error.statusCode < 500) {
    return error.statusCode;
  }

  return 503;
}

const aiAdvisorController = {
  // Tú thêm: xử lý câu hỏi khách hàng theo pipeline làm rõ -> tìm dữ liệu -> trả lời.
  async chat(req, res) {
    try {
      const data = await aiAdvisorService.chat(req.body || {});

      return res.json({
        success: true,
        message: 'AI phản hồi thành công',
        data
      });
    } catch (error) {
      console.error('AI advisor error:', error.message);

      return res.status(resolveStatusCode(error)).json({
        success: false,
        message: error.message || 'AI hiện chưa sẵn sàng'
      });
    }
  },

  // Tú thêm: tạo/cập nhật embedding cho sản phẩm trong MySQL.
  async syncEmbeddings(req, res) {
    try {
      const data = await aiAdvisorService.syncProductEmbeddings({
        productId: req.body?.productId || req.query?.productId,
        limit: req.body?.limit || req.query?.limit
      });

      return res.json({
        success: true,
        message: 'Đồng bộ embedding sản phẩm thành công',
        data
      });
    } catch (error) {
      console.error('AI embedding sync error:', error.message);

      return res.status(resolveStatusCode(error)).json({
        success: false,
        message: error.message || 'Không đồng bộ được embedding'
      });
    }
  },

  // Tú thêm: xem nhanh trạng thái bảng product_embeddings.
  async getEmbeddingStats(req, res) {
    try {
      const data = await aiAdvisorService.getEmbeddingStats();

      return res.json({
        success: true,
        message: 'Lấy thống kê embedding thành công',
        data
      });
    } catch (error) {
      console.error('AI embedding stats error:', error.message);

      return res.status(resolveStatusCode(error)).json({
        success: false,
        message: error.message || 'Không lấy được thống kê embedding'
      });
    }
  }
};

module.exports = aiAdvisorController;
