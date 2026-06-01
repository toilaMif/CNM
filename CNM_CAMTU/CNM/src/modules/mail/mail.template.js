/* =========================================================
   ACCOUNT EMAIL TEMPLATE
========================================================= */
function accountEmailTemplate({ email, password }) {
  return `
  <!DOCTYPE html>
  <html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Account Created</title>
  </head>

  <body style="margin:0;padding:0;background:#f4f6f8;font-family:Arial, sans-serif;">

    <table width="100%" cellpadding="0" cellspacing="0" style="padding:40px 0;">
      <tr>
        <td align="center">

          <table width="600" cellpadding="0" cellspacing="0" style="background:#ffffff;border-radius:10px;overflow:hidden;box-shadow:0 4px 12px rgba(0,0,0,0.1);">

            <tr>
              <td style="background:#2e7d32;padding:20px;text-align:center;color:white;">
                <h1 style="margin:0;font-size:24px;">🌿 Agro System</h1>
                <p style="margin:5px 0 0;font-size:14px;">Account Notification</p>
              </td>
            </tr>

            <tr>
              <td style="padding:30px;color:#333;">

                <h2 style="margin-top:0;">Your Account Has Been Created</h2>

                <p style="font-size:14px;color:#555;">
                  Welcome! Your account has been successfully created. 
                  Please use the credentials below to login.
                </p>

                <table width="100%" style="background:#f9fafb;border:1px solid #e0e0e0;border-radius:8px;margin:20px 0;">
                  <tr>
                    <td style="padding:15px;">
                      <p style="margin:0;"><strong>Email:</strong> ${email}</p>
                      <p style="margin:10px 0 0;"><strong>Password:</strong> ${password}</p>
                    </td>
                  </tr>
                </table>

                <p style="font-size:13px;color:#d32f2f;margin-top:10px;">
                  ⚠ You must change your password after first login.
                </p>

                <div style="text-align:center;margin:30px 0;">
                  <a href="http://localhost:5173/login"
                     style="background:#2e7d32;color:#fff;padding:12px 25px;
                     text-decoration:none;border-radius:6px;font-weight:bold;">
                     Login Now
                  </a>
                </div>

                <p style="font-size:12px;color:#999;">
                  If you did not request this account, please ignore this email.
                </p>

              </td>
            </tr>

            <tr>
              <td style="background:#f1f1f1;padding:15px;text-align:center;font-size:12px;color:#777;">
                © 2026 Agro Distribution System
              </td>
            </tr>

          </table>

        </td>
      </tr>
    </table>

  </body>
  </html>
  `;
}

/* =========================================================
   PURCHASE ORDER EMAIL TEMPLATE
   Gửi thông tin phiếu đặt hàng cho nhà cung cấp
========================================================= */
function purchaseOrderEmailTemplate({ supplier, purchaseOrder, items }) {
  const supplierName = supplier?.supplier_name || 'Quý nhà cung cấp';

  const poCode = purchaseOrder?.po_code || '---';

  const expectedDate = purchaseOrder?.expected_delivery_date
    ? new Date(purchaseOrder.expected_delivery_date).toLocaleDateString('vi-VN')
    : 'Chưa xác định';

  const totalAmount = Number(purchaseOrder?.total_amount || 0)
    .toLocaleString('vi-VN', {
      style: 'currency',
      currency: 'VND'
    });

  const note = purchaseOrder?.note || '';

  const itemRows = (items || []).map((item, index) => {
    const productName =
      item.ProductName ||
      item.product_name ||
      item.productName ||
      'Sản phẩm';

    const sku = item.SKU || item.sku || '-';

    const orderedQuantity = Number(item.ordered_quantity || 0);
    const unitPrice = Number(item.unit_price || 0);
    const lineTotal = orderedQuantity * unitPrice;

    return `
      <tr>
        <td style="padding:10px;border:1px solid #e0e0e0;text-align:center;">
          ${index + 1}
        </td>

        <td style="padding:10px;border:1px solid #e0e0e0;">
          <strong>${productName}</strong>
          <br>
          <span style="font-size:12px;color:#777;">SKU: ${sku}</span>
        </td>

        <td style="padding:10px;border:1px solid #e0e0e0;text-align:right;">
          ${orderedQuantity.toLocaleString('vi-VN')}
        </td>

        <td style="padding:10px;border:1px solid #e0e0e0;text-align:right;">
          ${unitPrice.toLocaleString('vi-VN')} đ
        </td>

        <td style="padding:10px;border:1px solid #e0e0e0;text-align:right;">
          ${lineTotal.toLocaleString('vi-VN')} đ
        </td>
      </tr>
    `;
  }).join('');

  return `
  <!DOCTYPE html>
  <html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Purchase Order</title>
  </head>

  <body style="margin:0;padding:0;background:#f4f6f8;font-family:Arial, sans-serif;">

    <table width="100%" cellpadding="0" cellspacing="0" style="padding:40px 0;">
      <tr>
        <td align="center">

          <table width="720" cellpadding="0" cellspacing="0" style="background:#ffffff;border-radius:10px;overflow:hidden;box-shadow:0 4px 12px rgba(0,0,0,0.1);">

            <tr>
              <td style="background:#2e7d32;padding:22px;text-align:center;color:white;">
                <h1 style="margin:0;font-size:24px;">🌿 Agro System</h1>
                <p style="margin:5px 0 0;font-size:14px;">Purchase Order Notification</p>
              </td>
            </tr>

            <tr>
              <td style="padding:30px;color:#333;">

                <h2 style="margin-top:0;color:#2e7d32;">Thông báo phiếu đặt hàng</h2>

                <p style="font-size:14px;color:#555;">
                  Kính gửi <strong>${supplierName}</strong>,
                </p>

                <p style="font-size:14px;color:#555;">
                  Hệ thống Agro xin gửi đến Quý nhà cung cấp thông tin phiếu đặt hàng mới như sau:
                </p>

                <table width="100%" cellpadding="0" cellspacing="0" style="background:#f9fafb;border:1px solid #e0e0e0;border-radius:8px;margin:20px 0;">
                  <tr>
                    <td style="padding:15px;">
                      <p style="margin:0 0 8px;">
                        <strong>Mã phiếu đặt hàng:</strong> ${poCode}
                      </p>

                      <p style="margin:0 0 8px;">
                        <strong>Ngày giao dự kiến:</strong> ${expectedDate}
                      </p>

                      <p style="margin:0;">
                        <strong>Tổng giá trị dự kiến:</strong> ${totalAmount}
                      </p>
                    </td>
                  </tr>
                </table>

                ${
                  note
                    ? `
                      <p style="font-size:14px;color:#555;">
                        <strong>Ghi chú:</strong> ${note}
                      </p>
                    `
                    : ''
                }

                <h3 style="margin-top:25px;color:#2e7d32;">Danh sách sản phẩm đặt hàng</h3>

                <table width="100%" cellpadding="0" cellspacing="0" style="border-collapse:collapse;margin-top:10px;">
                  <thead>
                    <tr style="background:#e8f5e9;">
                      <th style="padding:10px;border:1px solid #e0e0e0;text-align:center;">STT</th>
                      <th style="padding:10px;border:1px solid #e0e0e0;text-align:left;">Sản phẩm</th>
                      <th style="padding:10px;border:1px solid #e0e0e0;text-align:right;">Số lượng</th>
                      <th style="padding:10px;border:1px solid #e0e0e0;text-align:right;">Đơn giá</th>
                      <th style="padding:10px;border:1px solid #e0e0e0;text-align:right;">Thành tiền</th>
                    </tr>
                  </thead>

                  <tbody>
                    ${
                      itemRows ||
                      `
                        <tr>
                          <td colspan="5" style="padding:15px;border:1px solid #e0e0e0;text-align:center;color:#777;">
                            Không có sản phẩm
                          </td>
                        </tr>
                      `
                    }
                  </tbody>
                </table>

                <p style="font-size:14px;color:#555;margin-top:25px;">
                  Quý nhà cung cấp vui lòng kiểm tra thông tin và phản hồi lại để xác nhận khả năng giao hàng.
                </p>

                <p style="font-size:14px;color:#555;">
                  Trân trọng,<br>
                  <strong>Agro System</strong>
                </p>

              </td>
            </tr>

            <tr>
              <td style="background:#f1f1f1;padding:15px;text-align:center;font-size:12px;color:#777;">
                © 2026 Agro Distribution System
              </td>
            </tr>

          </table>

        </td>
      </tr>
    </table>

  </body>
  </html>
  `;
}

/* =========================================================
   GOODS RECEIPT ISSUE EMAIL TEMPLATE
   Product Manager gửi thông báo hàng lỗi cho nhà cung cấp

   Dùng cho:
   - Phiếu nhận hàng có hàng lỗi
   - Email đính kèm ảnh lỗi bằng Nodemailer attachments
========================================================= */
function goodsReceiptIssueEmailTemplate({ receipt, items }) {
  const supplierName = receipt?.supplier_name || 'Quý nhà cung cấp';

  const receiptCode = receipt?.receipt_code || '---';
  const poCode = receipt?.po_code || '---';

  const receivedDate = receipt?.received_date || receipt?.created_at
    ? new Date(receipt.received_date || receipt.created_at).toLocaleDateString('vi-VN')
    : 'Chưa xác định';

  const note = receipt?.note || '';

  const totalRejected = (items || []).reduce((sum, item) => {
    return sum + Number(item.rejected_quantity || 0);
  }, 0);

  const itemRows = (items || []).map((item, index) => {
    const productName =
      item.ProductName ||
      item.product_name ||
      item.productName ||
      'Sản phẩm';

    const sku = item.SKU || item.sku || '-';

    const receivedQuantity = Number(item.received_quantity || 0);
    const acceptedQuantity = Number(item.accepted_quantity || 0);
    const rejectedQuantity = Number(item.rejected_quantity || 0);

    const rejectReason = item.reject_reason || item.note || '-';
    const batchNumber = item.batch_number || '-';
    const manufacturerBatch = item.manufacturer_batch || '-';

    const expiryDate = item.expiry_date
      ? new Date(item.expiry_date).toLocaleDateString('vi-VN')
      : '-';

    const imageCount = Array.isArray(item.fault_images)
      ? item.fault_images.length
      : 0;

    return `
      <tr>
        <td style="padding:10px;border:1px solid #e0e0e0;text-align:center;">
          ${index + 1}
        </td>

        <td style="padding:10px;border:1px solid #e0e0e0;">
          <strong>${productName}</strong>
          <br>
          <span style="font-size:12px;color:#777;">SKU: ${sku}</span>
        </td>

        <td style="padding:10px;border:1px solid #e0e0e0;text-align:right;">
          ${receivedQuantity.toLocaleString('vi-VN')}
        </td>

        <td style="padding:10px;border:1px solid #e0e0e0;text-align:right;">
          ${acceptedQuantity.toLocaleString('vi-VN')}
        </td>

        <td style="padding:10px;border:1px solid #e0e0e0;text-align:right;color:#b91c1c;font-weight:bold;">
          ${rejectedQuantity.toLocaleString('vi-VN')}
        </td>

        <td style="padding:10px;border:1px solid #e0e0e0;">
          ${rejectReason}
        </td>

        <td style="padding:10px;border:1px solid #e0e0e0;">
          ${batchNumber}
        </td>

        <td style="padding:10px;border:1px solid #e0e0e0;">
          ${manufacturerBatch}
        </td>

        <td style="padding:10px;border:1px solid #e0e0e0;text-align:center;">
          ${expiryDate}
        </td>

        <td style="padding:10px;border:1px solid #e0e0e0;text-align:center;">
          ${imageCount > 0 ? `${imageCount} ảnh đính kèm` : 'Không có'}
        </td>
      </tr>
    `;
  }).join('');

  return `
  <!DOCTYPE html>
  <html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Goods Receipt Issue</title>
  </head>

  <body style="margin:0;padding:0;background:#f4f6f8;font-family:Arial, sans-serif;">

    <table width="100%" cellpadding="0" cellspacing="0" style="padding:40px 0;">
      <tr>
        <td align="center">

          <table width="820" cellpadding="0" cellspacing="0" style="background:#ffffff;border-radius:10px;overflow:hidden;box-shadow:0 4px 12px rgba(0,0,0,0.1);">

            <tr>
              <td style="background:#b91c1c;padding:22px;text-align:center;color:white;">
                <h1 style="margin:0;font-size:24px;">⚠️ Agro System</h1>
                <p style="margin:5px 0 0;font-size:14px;">Goods Issue Notification</p>
              </td>
            </tr>

            <tr>
              <td style="padding:30px;color:#333;">

                <h2 style="margin-top:0;color:#b91c1c;">Thông báo hàng lỗi trong phiếu nhận hàng</h2>

                <p style="font-size:14px;color:#555;">
                  Kính gửi <strong>${supplierName}</strong>,
                </p>

                <p style="font-size:14px;color:#555;line-height:1.6;">
                  Trong quá trình tiếp nhận hàng hóa từ Quý nhà cung cấp, hệ thống Agro ghi nhận
                  một số sản phẩm có phát sinh lỗi. Vui lòng kiểm tra thông tin bên dưới và phản hồi
                  phương án xử lý phù hợp.
                </p>

                <table width="100%" cellpadding="0" cellspacing="0" style="background:#fff7f7;border:1px solid #fecaca;border-radius:8px;margin:20px 0;">
                  <tr>
                    <td style="padding:15px;">
                      <p style="margin:0 0 8px;">
                        <strong>Mã phiếu nhận hàng:</strong> ${receiptCode}
                      </p>

                      <p style="margin:0 0 8px;">
                        <strong>Mã phiếu đặt hàng:</strong> ${poCode}
                      </p>

                      <p style="margin:0 0 8px;">
                        <strong>Ngày nhận hàng:</strong> ${receivedDate}
                      </p>

                      <p style="margin:0;">
                        <strong>Tổng số lượng lỗi:</strong>
                        <span style="color:#b91c1c;font-weight:bold;">
                          ${Number(totalRejected).toLocaleString('vi-VN')}
                        </span>
                      </p>
                    </td>
                  </tr>
                </table>

                ${
                  note
                    ? `
                      <p style="font-size:14px;color:#555;">
                        <strong>Ghi chú phiếu nhập:</strong> ${note}
                      </p>
                    `
                    : ''
                }

                <h3 style="margin-top:25px;color:#b91c1c;">Danh sách sản phẩm lỗi</h3>

                <table width="100%" cellpadding="0" cellspacing="0" style="border-collapse:collapse;margin-top:10px;font-size:13px;">
                  <thead>
                    <tr style="background:#fee2e2;">
                      <th style="padding:10px;border:1px solid #e0e0e0;text-align:center;">STT</th>
                      <th style="padding:10px;border:1px solid #e0e0e0;text-align:left;">Sản phẩm</th>
                      <th style="padding:10px;border:1px solid #e0e0e0;text-align:right;">SL nhận</th>
                      <th style="padding:10px;border:1px solid #e0e0e0;text-align:right;">SL đạt</th>
                      <th style="padding:10px;border:1px solid #e0e0e0;text-align:right;">SL lỗi</th>
                      <th style="padding:10px;border:1px solid #e0e0e0;text-align:left;">Lý do lỗi</th>
                      <th style="padding:10px;border:1px solid #e0e0e0;text-align:left;">Batch nội bộ</th>
                      <th style="padding:10px;border:1px solid #e0e0e0;text-align:left;">Số lô NSX</th>
                      <th style="padding:10px;border:1px solid #e0e0e0;text-align:center;">HSD</th>
                      <th style="padding:10px;border:1px solid #e0e0e0;text-align:center;">Ảnh</th>
                    </tr>
                  </thead>

                  <tbody>
                    ${
                      itemRows ||
                      `
                        <tr>
                          <td colspan="10" style="padding:15px;border:1px solid #e0e0e0;text-align:center;color:#777;">
                            Không có sản phẩm lỗi
                          </td>
                        </tr>
                      `
                    }
                  </tbody>
                </table>

                <p style="font-size:14px;color:#555;margin-top:25px;line-height:1.6;">
                  Các hình ảnh minh chứng hàng lỗi được đính kèm trong email này nếu có.
                  Quý nhà cung cấp vui lòng phản hồi phương án xử lý như:
                  gửi bù hàng, đổi trả hàng, hoàn tiền hoặc phương án phù hợp khác.
                </p>

                <p style="font-size:14px;color:#555;">
                  Trân trọng,<br>
                  <strong>Agro System</strong>
                </p>

              </td>
            </tr>

            <tr>
              <td style="background:#f1f1f1;padding:15px;text-align:center;font-size:12px;color:#777;">
                © 2026 Agro Distribution System
              </td>
            </tr>

          </table>

        </td>
      </tr>
    </table>

  </body>
  </html>
  `;
}

module.exports = {
  accountEmailTemplate,
  purchaseOrderEmailTemplate,
  goodsReceiptIssueEmailTemplate
};