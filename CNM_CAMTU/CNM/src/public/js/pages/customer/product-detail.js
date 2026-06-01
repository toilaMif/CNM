const API_PRODUCTS = "/api/products";
const DEFAULT_PRODUCT_IMAGE = "/images/uploads/products/default.jpg";

let currentProduct = null;

document.addEventListener("DOMContentLoaded", () => {
  bindEvents();
  loadProductDetail();
});

function getProductIdFromUrl() {
  const parts = window.location.pathname.split("/").filter(Boolean);
  return parts[parts.length - 1];
}

async function fetchJSON(url) {
  const response = await fetch(url, {
    method: "GET",
    credentials: "include",
    headers: {
      "Content-Type": "application/json",
    },
  });

  const data = await response.json().catch(() => null);

  if (!response.ok) {
    throw new Error(data?.message || "Không tải được dữ liệu");
  }

  return data;
}

async function loadProductDetail() {
  const productId = getProductIdFromUrl();

  if (!productId) {
    showError();
    return;
  }

  try {
    const result = await fetchJSON(`${API_PRODUCTS}/${productId}`);
    const product = result.data || result;

    renderProduct(product);
  } catch (error) {
    console.error("Load product detail error:", error);
    showError();
  }
}

function renderProduct(product) {
  if (!product) {
    showError();
    return;
  }

  currentProduct = product;

  const productName = product.ProductName || product.name || "Không có tên sản phẩm";
  const imageUrl = resolveProductImage(product);
  const weight = product.Weight || product.weight;
  const availableQuantity =
    product.AvailableQuantity ??
    product.availableQuantity ??
    product.Quantity ??
    product.quantity;

  setImage("#productImage", imageUrl, productName);
  setText("#productName", productName);
  setText("#skuText", `SKU: ${product.SKU || product.sku || "Đang cập nhật"}`);
  setText("#productPrice", formatPrice(product.Price || product.price || 0));
  setText("#categoryName", product.CategoryName || product.category?.name || "Chưa phân loại");
  setText("#statusName", product.StatusName || product.status?.name || "Đang cập nhật");
  setText("#availableQuantity", formatQuantity(availableQuantity));
  setText("#unitName", product.UnitName || product.unit?.name || "Đang cập nhật");
  setText("#brandName", product.Brand || product.brand || "Đang cập nhật");
  setText("#originCountry", product.OriginCountry || product.originCountry || "Đang cập nhật");
  setText("#weightText", weight ? `${weight}` : "Đang cập nhật");
  renderInfoSection(
    "#descriptionText",
    product.Description || product.description || "Chưa có mô tả sản phẩm.",
    [
      "Công dụng",
      "Triệu chứng phù hợp",
      "Nguyên nhân thường gặp",
      "Đối tượng cây trồng",
      "Thời điểm xử lý",
      "Quy cách",
      "Giá tham khảo"
    ]
  );
  renderInfoSection(
    "#technicalContentText",
    product.TechnicalContent ||
      product.technicalContent ||
      "Chưa có thông tin kỹ thuật.",
    [
      "Thành phần",
      "Loại sản phẩm",
      "Quy cách"
    ]
  );
  renderInfoSection(
    "#usageInstructionsText",
    product.UsageInstructions ||
      product.usageInstructions ||
      "Chưa có hướng dẫn sử dụng.",
    [
      "Hướng dẫn sử dụng",
      "An toàn sử dụng"
    ]
  );

  hide("#loadingBox");
  hide("#errorBox");
  show("#productDetail");
  show("#productContent");
}

function resolveProductImage(product) {
  const rawImage =
    product.ImageURL ||
    product.imageUrl ||
    product.ImageUrl ||
    product.image ||
    product.Image;

  if (typeof rawImage === "string" && rawImage.trim()) {
    return rawImage;
  }

  return rawImage?.url || rawImage?.path || rawImage?.URL || DEFAULT_PRODUCT_IMAGE;
}

function setText(selector, value) {
  const el = document.querySelector(selector);
  if (el) el.textContent = value;
}

function renderInfoSection(selector, value, labels = []) {
  const el = document.querySelector(selector);

  if (!el) return;

  const items = parseLabeledText(value, labels);

  el.innerHTML = items.map((item) => `
    <div class="detail-item">
      <span>${escapeHtml(item.label)}</span>
      <p>${escapeHtml(item.value)}</p>
    </div>
  `).join("");
}

function parseLabeledText(value, labels = []) {
  const source = String(value || "").replace(/\s+/g, " ").trim();

  if (!source) {
    return [{ label: "Thông tin", value: "Đang cập nhật" }];
  }

  if (!labels.length) {
    return [{ label: "Thông tin", value: source }];
  }

  const pattern = new RegExp(`(^|\\s)(${labels.map(escapeRegExp).join("|")}):`, "gi");
  const matches = [];
  let match;

  while ((match = pattern.exec(source)) !== null) {
    const labelStart = match.index + match[1].length;

    matches.push({
      label: match[2],
      labelStart,
      valueStart: labelStart + match[2].length + 1,
    });
  }

  if (!matches.length) {
    return [{ label: "Thông tin", value: source }];
  }

  return matches.map((item, index) => {
    const next = matches[index + 1];
    const valueEnd = next ? next.labelStart : source.length;
    const itemValue = source.slice(item.valueStart, valueEnd).trim();

    return {
      label: item.label,
      value: itemValue || "Đang cập nhật",
    };
  });
}

function escapeRegExp(value) {
  return String(value).replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
}

function escapeHtml(value) {
  return String(value ?? "")
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&#039;");
}

function setImage(selector, src, alt) {
  const img = document.querySelector(selector);

  if (!img) return;

  img.src = src;
  img.alt = alt;
  img.onerror = () => {
    img.src = DEFAULT_PRODUCT_IMAGE;
  };
}

function formatPrice(price) {
  return new Intl.NumberFormat("vi-VN").format(Number(price || 0)) + "đ";
}

function formatQuantity(quantity) {
  if (quantity === undefined || quantity === null || quantity === "") {
    return "Đang cập nhật";
  }

  return `${new Intl.NumberFormat("vi-VN").format(Number(quantity || 0))}`;
}

function show(selector) {
  const el = document.querySelector(selector);
  if (el) el.classList.remove("hidden");
}

function hide(selector) {
  const el = document.querySelector(selector);
  if (el) el.classList.add("hidden");
}

function showError() {
  hide("#loadingBox");
  hide("#productDetail");
  hide("#productContent");
  show("#errorBox");
}

function buildAiProductContext(product) {
  return {
    ProductID: product.ProductID || product.id || getProductIdFromUrl(),
    ProductName: product.ProductName || product.name || "Sản phẩm AgroShop",
    SKU: product.SKU || product.sku || "",
    Price: product.Price || product.price || 0,
    CategoryName: product.CategoryName || product.category?.name || product.categoryName || "",
    StatusName: product.StatusName || product.status?.name || "",
    Brand: product.Brand || product.brand || "",
    OriginCountry: product.OriginCountry || product.originCountry || "",
    AvailableQuantity:
      product.AvailableQuantity ??
      product.availableQuantity ??
      product.Quantity ??
      product.quantity ??
      null,
    UnitName: product.UnitName || product.unit?.name || "",
    Weight: product.Weight || product.weight || "",
    Description: product.Description || product.description || "",
    TechnicalContent: product.TechnicalContent || product.technicalContent || "",
    UsageInstructions: product.UsageInstructions || product.usageInstructions || "",
    ImageURL: resolveProductImage(product),
  };
}

function bindEvents() {
  const backBtn = document.querySelector("#backBtn");
  const askAiBtn = document.querySelector("#askAiBtn");

  backBtn?.addEventListener("click", () => {
    if (document.referrer) {
      window.history.back();
    } else {
      window.location.href = "/";
    }
  });

  askAiBtn?.addEventListener("click", () => {
    if (!currentProduct) return;

    try {
      sessionStorage.setItem(
        "agro_ai_product_context",
        JSON.stringify(buildAiProductContext(currentProduct))
      );
    } catch (error) {
      console.error("Store AI product context error:", error);
    }
  });
}
