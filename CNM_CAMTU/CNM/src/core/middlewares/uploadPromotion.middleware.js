const multer = require('multer');
const path = require('path');
const fs = require('fs');

const uploadDir = path.join(
  __dirname,
  '../../public/images/uploads/promotions'
);

if (!fs.existsSync(uploadDir)) {
  fs.mkdirSync(uploadDir, { recursive: true });
}

const storage = multer.diskStorage({
  destination(req, file, cb) {
    cb(null, uploadDir);
  },

  filename(req, file, cb) {
    const ext = path.extname(file.originalname);
    const baseName = path
      .basename(file.originalname, ext)
      .replace(/\s+/g, '-')
      .replace(/[^a-zA-Z0-9-_]/g, '');

    const fileName = `${Date.now()}-${baseName}${ext}`;

    cb(null, fileName);
  }
});

function fileFilter(req, file, cb) {
  const allowedTypes = [
    'image/jpeg',
    'image/png',
    'image/webp',
    'image/jpg'
  ];

  if (!allowedTypes.includes(file.mimetype)) {
    return cb(new Error('Chỉ cho phép upload ảnh JPG, PNG hoặc WEBP'));
  }

  cb(null, true);
}

const uploadPromotionImages = multer({
  storage,
  fileFilter,
  limits: {
    fileSize: 5 * 1024 * 1024
  }
});

module.exports = uploadPromotionImages;