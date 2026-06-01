const express = require('express');

const aiAdvisorController = require('./ai-advisor.controller');

const router = express.Router();

// Tú thêm: endpoint chat AI tư vấn dựa trên dữ liệu sản phẩm thật trong database.
router.post('/chat', aiAdvisorController.chat);

// Tú thêm: endpoint đồng bộ embedding sản phẩm vào bảng product_embeddings.
router.post('/embeddings/sync', aiAdvisorController.syncEmbeddings);

// Tú thêm: endpoint kiểm tra số lượng embedding hiện có.
router.get('/embeddings/stats', aiAdvisorController.getEmbeddingStats);

module.exports = router;
