const multer = require('multer');
const path = require('path');
const fs = require('fs');

/* =========================================================
   UPLOAD GOODS RECEIPT IMAGES
   Upload ảnh minh chứng hàng lỗi khi Warehouse tạo phiếu nhập

   File sẽ lưu vào:
   public/uploads/goods-receipts

   URL lưu DB sẽ là:
   /uploads/goods-receipts/<filename>
========================================================= */

const uploadDir = path.join(
    __dirname,
    '../../public/images/uploads/good-receips'
);

if (!fs.existsSync(uploadDir)) {
    fs.mkdirSync(uploadDir, { recursive: true });
}

/* =========================================================
   STORAGE CONFIG
========================================================= */
const storage = multer.diskStorage({
    destination(req, file, cb) {
        cb(null, uploadDir);
    },

    filename(req, file, cb) {
        const ext = path.extname(file.originalname);

        const filename = `${Date.now()}-${Math.round(Math.random() * 1e9)}${ext}`;

        cb(null, filename);
    }
});

/* =========================================================
   FILE FILTER
   Chỉ cho upload ảnh
========================================================= */
function fileFilter(req, file, cb) {
    const allowedTypes = [
        'image/jpeg',
        'image/png',
        'image/webp'
    ];

    if (!allowedTypes.includes(file.mimetype)) {
        return cb(
            new Error('Chỉ cho phép upload ảnh JPG, PNG hoặc WEBP'),
            false
        );
    }

    cb(null, true);
}

/* =========================================================
   MULTER INSTANCE
========================================================= */
const uploadGoodsReceiptImages = multer({
    storage,
    fileFilter,
    limits: {
        fileSize: 5 * 1024 * 1024,
        files: 10
    }
});

module.exports = {
    uploadGoodsReceiptImages
};