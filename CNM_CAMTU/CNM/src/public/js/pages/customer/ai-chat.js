const chatMessages = document.getElementById("chatMessages");
const chatForm = document.getElementById("chatForm");
const chatInput = document.getElementById("chatInput");
const sendButton = document.getElementById("sendChat");
const attachImageBtn = document.getElementById("attachImageBtn");
const chatImageInput = document.getElementById("chatImageInput");
const composerAttachment = document.getElementById("composerAttachment");
const composerAttachmentImage = document.getElementById("composerAttachmentImage");
const composerAttachmentName = document.getElementById("composerAttachmentName");
const composerAttachmentMeta = document.getElementById("composerAttachmentMeta");
const removeAttachmentBtn = document.getElementById("removeAttachmentBtn");
const mobileMenu = document.querySelector(".mobile-menu");
const DEFAULT_PRODUCT_IMAGE = "/images/uploads/products/default.jpg";
const PRODUCT_CONTEXT_KEY = "agro_ai_product_context";
const MAX_CHAT_IMAGE_SIZE = 5 * 1024 * 1024;
const DEFAULT_CHAT_PLACEHOLDER = chatInput?.placeholder || "";
const messages = [];
let pendingImage = null;
let pendingProduct = null;

document.addEventListener("DOMContentLoaded", () => {
  bindChatEvents();
  hydrateProductContext();
});

function bindChatEvents() {
  chatForm?.addEventListener("submit", (event) => {
    event.preventDefault();
    sendMessage();
  });

  attachImageBtn?.addEventListener("click", () => {
    chatImageInput?.click();
  });

  chatImageInput?.addEventListener("change", handleImageSelected);

  removeAttachmentBtn?.addEventListener("click", () => {
    clearPendingAttachment();
    chatInput.focus();
  });

  document.querySelectorAll("[data-suggestion]").forEach((button) => {
    button.addEventListener("click", () => {
      const suggestion = button.dataset.suggestion || "";
      chatInput.value = suggestion;
      sendMessage();
    });
  });

  document.querySelector('[data-action="clear-chat"]')?.addEventListener("click", () => {
    messages.length = 0;
    resetChat();
  });

  mobileMenu?.addEventListener("click", () => {
    document.body.classList.toggle("sidebar-open");
  });

  document.addEventListener("click", (event) => {
    const sidebar = document.querySelector(".chat-sidebar");
    const clickedMenu = event.target.closest(".mobile-menu");

    if (!sidebar || clickedMenu || !document.body.classList.contains("sidebar-open")) {
      return;
    }

    if (!event.target.closest(".chat-sidebar")) {
      document.body.classList.remove("sidebar-open");
    }
  });
}

function handleImageSelected(event) {
  const file = event.target.files?.[0];

  if (!file) return;

  event.target.value = "";

  if (!file.type.startsWith("image/")) {
    addMessage("Vui lòng chọn đúng file ảnh.", "bot");
    return;
  }

  if (file.size > MAX_CHAT_IMAGE_SIZE) {
    addMessage("Ảnh hơi lớn rồi. Bạn chọn ảnh dưới 5MB giúp mình nha.", "bot");
    return;
  }

  clearPendingAttachment();

  pendingImage = {
    file,
    url: URL.createObjectURL(file),
  };

  renderPendingImage();
  chatInput.placeholder = "Mô tả thêm về ảnh để AgroBot tư vấn...";
  chatInput.focus();
}

function renderPendingImage() {
  if (
    !pendingImage ||
    !composerAttachment ||
    !composerAttachmentImage ||
    !composerAttachmentName ||
    !composerAttachmentMeta
  ) {
    return;
  }

  composerAttachment.hidden = false;
  composerAttachment.classList.remove("product-attachment");
  composerAttachmentImage.src = pendingImage.url;
  composerAttachmentName.textContent = pendingImage.file.name || "Ảnh đã chọn";
  composerAttachmentMeta.textContent = `${formatFileSize(pendingImage.file.size)} · Sẽ gửi kèm câu hỏi`;
  document.body.classList.add("has-chat-attachment");
}

function renderPendingProduct() {
  if (
    !pendingProduct ||
    !composerAttachment ||
    !composerAttachmentImage ||
    !composerAttachmentName ||
    !composerAttachmentMeta
  ) {
    return;
  }

  const category =
    pendingProduct.CategoryName ||
    pendingProduct.categoryName ||
    pendingProduct.category?.name ||
    "Sản phẩm";

  composerAttachment.hidden = false;
  composerAttachment.classList.add("product-attachment");
  composerAttachmentImage.src = resolveProductImage(pendingProduct);
  composerAttachmentImage.onerror = () => {
    composerAttachmentImage.src = DEFAULT_PRODUCT_IMAGE;
  };
  composerAttachmentName.textContent = getProductName(pendingProduct);
  composerAttachmentMeta.textContent = `${formatPrice(pendingProduct.Price || pendingProduct.price || 0)} · ${category}`;
  document.body.classList.add("has-chat-attachment");
}

function clearPendingAttachment(options = {}) {
  const { revokeUrl = true } = options;

  if (revokeUrl && pendingImage?.url) {
    URL.revokeObjectURL(pendingImage.url);
  }

  pendingImage = null;
  pendingProduct = null;

  if (composerAttachment) {
    composerAttachment.hidden = true;
    composerAttachment.classList.remove("product-attachment");
  }

  if (composerAttachmentImage) {
    composerAttachmentImage.onerror = null;
    composerAttachmentImage.removeAttribute("src");
  }

  if (composerAttachmentName) {
    composerAttachmentName.textContent = "";
  }

  if (composerAttachmentMeta) {
    composerAttachmentMeta.textContent = "";
  }

  if (chatImageInput) {
    chatImageInput.value = "";
  }

  if (chatInput) {
    chatInput.placeholder = DEFAULT_CHAT_PLACEHOLDER;
  }

  document.body.classList.remove("has-chat-attachment");
}

function hydrateProductContext() {
  if (!chatMessages || !chatInput) return;

  let product = null;

  try {
    const rawProduct = sessionStorage.getItem(PRODUCT_CONTEXT_KEY);
    if (!rawProduct) return;

    sessionStorage.removeItem(PRODUCT_CONTEXT_KEY);
    product = JSON.parse(rawProduct);
  } catch (error) {
    console.error("Read AI product context error:", error);
    return;
  }

  if (!product) return;

  const productName = getProductName(product);
  clearPendingAttachment();
  pendingProduct = product;
  renderPendingProduct();

  chatInput.value = `Tư vấn giúp tôi về ${productName}`;
  chatInput.placeholder = "Nhập câu hỏi cho sản phẩm này...";
  chatInput.focus();
}

async function sendMessage() {
  if (!chatMessages || !chatInput || !sendButton) {
    console.error("Missing chat DOM nodes");
    return;
  }

  const text = chatInput.value.trim();

  const hasPendingAttachment = pendingImage || pendingProduct;

  if (!text) {
    if (hasPendingAttachment) {
      chatForm.classList.add("needs-message");
      setTimeout(() => chatForm.classList.remove("needs-message"), 420);
      chatInput.placeholder = "Nhập câu hỏi cho đính kèm này trước khi gửi...";
      chatInput.focus();
    }

    return;
  }

  const attachedImage = pendingImage;
  const attachedProduct = pendingProduct;
  const messageText = attachedProduct
    ? `${buildProductContextPrompt(attachedProduct)}\n\nCâu hỏi của khách: ${text}`
    : attachedImage
    ? `${text}\n\n[Người dùng đã đính kèm ảnh: ${attachedImage.file.name}. Hiện hệ thống chưa phân tích ảnh trực tiếp; hãy tư vấn dựa trên câu hỏi và yêu cầu người dùng mô tả thêm nếu cần.]`
    : text;

  if (attachedProduct) {
    addProductMessage(attachedProduct, text);
    clearPendingAttachment();
  } else if (attachedImage) {
    addImageMessage(attachedImage.file, attachedImage.url, text);
    clearPendingAttachment({ revokeUrl: false });
  } else {
    addMessage(text, "user");
  }

  messages.push({
    role: "user",
    content: messageText,
  });

  chatInput.value = "";
  setSending(true);

  const loadingEl = addLoadingMessage();

  try {
    const response = await fetch("/api/ai-advisor/chat", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ messages }),
    });

    const data = await response.json().catch(() => ({}));

    if (!response.ok || !data.success) {
      throw new Error(data.message || "Không gọi được Agro AI");
    }

    const reply = data.data?.reply || "Agro AI chưa có phản hồi.";
    loadingEl.remove();

    addMessage(reply, "bot", data.data?.sources || []);
    messages.push({
      role: "assistant",
      content: reply,
    });
  } catch (error) {
    loadingEl.remove();
    console.error("Agro AI chat error:", error);
    addMessage(error.message || "AgroBot hiện chưa thể phản hồi. Vui lòng thử lại sau.", "bot");
    return;
    addMessage(
      "Chưa kết nối được Agro AI. Vui lòng kiểm tra Ollama hoặc thử lại sau.",
      "bot"
    );
  } finally {
    setSending(false);
    chatInput.focus();
  }
}

function addMessage(text, type, sources = []) {
  const row = document.createElement("div");
  row.className = `message-row ${type}`;

  if (type === "user") {
    row.innerHTML = `
      <div class="message-bubble user"></div>
      <div class="message-avatar user">
        <i class="fa-regular fa-user"></i>
      </div>
    `;

    row.querySelector(".message-bubble").textContent = text;
  } else {
    row.innerHTML = `
      <div class="message-avatar bot">
        <i class="fa-solid fa-robot"></i>
      </div>
      <div class="message-stack">
        <div class="message-bubble bot"></div>
      </div>
    `;

    renderBotReply(row.querySelector(".message-bubble"), text);

    const sourceCards = buildSourceCards(sources);
    if (sourceCards) {
      row.querySelector(".message-stack").insertAdjacentHTML("beforeend", sourceCards);
    }
  }

  chatMessages.appendChild(row);
  scrollToBottom();
}

function addImageMessage(file, imageUrl, text = "") {
  const row = document.createElement("div");
  row.className = "message-row user";

  const bubble = document.createElement("div");
  bubble.className = "message-bubble user image-message";

  const image = document.createElement("img");
  image.src = imageUrl;
  image.alt = file.name || "Anh da chon";
  image.addEventListener("load", () => URL.revokeObjectURL(imageUrl), { once: true });

  const caption = document.createElement("span");
  caption.textContent = `${file.name || "Ảnh đã chọn"} · ${formatFileSize(file.size)}`;

  const question = document.createElement("p");
  question.className = "image-message__text";
  question.textContent = text;

  const avatar = document.createElement("div");
  avatar.className = "message-avatar user";
  avatar.innerHTML = '<i class="fa-regular fa-user"></i>';

  bubble.append(image);
  if (text) {
    bubble.append(question);
  }
  bubble.append(caption);
  row.append(bubble, avatar);
  chatMessages.appendChild(row);
  scrollToBottom();
}

function addProductMessage(product, text = "") {
  const row = document.createElement("div");
  row.className = "message-row user";

  const bubble = document.createElement("div");
  bubble.className = "message-bubble user product-message";

  const card = document.createElement("article");
  card.className = "product-message-card";

  const image = document.createElement("img");
  image.src = resolveProductImage(product);
  image.alt = getProductName(product);
  image.onerror = () => {
    image.src = DEFAULT_PRODUCT_IMAGE;
  };

  const content = document.createElement("div");
  content.className = "product-message-card__content";

  const label = document.createElement("span");
  label.className = "product-message-card__label";
  label.textContent = "Sản phẩm cần tư vấn";

  const title = document.createElement("strong");
  title.textContent = getProductName(product);

  const meta = document.createElement("small");
  meta.textContent = buildProductMessageMeta(product);

  content.append(label, title, meta);
  card.append(image, content);

  const question = document.createElement("p");
  question.className = "image-message__text";
  question.textContent = text;

  bubble.append(card, question);

  const avatar = document.createElement("div");
  avatar.className = "message-avatar user";
  avatar.innerHTML = '<i class="fa-regular fa-user"></i>';

  row.append(bubble, avatar);
  chatMessages.appendChild(row);
  scrollToBottom();
}

function addLoadingMessage() {
  const row = document.createElement("div");
  row.className = "message-row bot";
  row.innerHTML = `
    <div class="message-avatar bot">
      <i class="fa-solid fa-robot"></i>
    </div>
    <div class="message-stack">
      <div class="message-bubble bot loading">
        <span></span><span></span><span></span>
      </div>
    </div>
  `;

  chatMessages.appendChild(row);
  scrollToBottom();
  return row;
}

function buildProductContextPrompt(product) {
  const price = product.Price ?? product.price;
  const stock =
    product.AvailableQuantity ??
    product.availableQuantity ??
    product.Quantity ??
    product.quantity;
  const unit = product.UnitName || product.unitName || product.unit?.name;

  const lines = [
    `Tôi muốn hỏi về sản phẩm: ${getProductName(product)}.`,
    product.ProductID || product.id ? `Mã sản phẩm: ${product.ProductID || product.id}.` : "",
    product.SKU || product.sku ? `SKU: ${product.SKU || product.sku}.` : "",
    hasValue(price) ? `Giá: ${formatPrice(price)}.` : "",
    product.CategoryName || product.categoryName || product.category?.name
      ? `Danh mục: ${product.CategoryName || product.categoryName || product.category?.name}.`
      : "",
    product.Brand || product.brand ? `Thương hiệu: ${product.Brand || product.brand}.` : "",
    hasValue(stock)
      ? `Tồn kho: ${stock}${unit ? ` ${unit}` : ""}.`
      : "",
    product.Description || product.description
      ? `Mô tả: ${compactText(product.Description || product.description)}`
      : "",
    product.TechnicalContent || product.technicalContent
      ? `Thông tin kỹ thuật: ${compactText(product.TechnicalContent || product.technicalContent)}`
      : "",
    product.UsageInstructions || product.usageInstructions
      ? `Hướng dẫn sử dụng: ${compactText(product.UsageInstructions || product.usageInstructions)}`
      : "",
    "Hãy tư vấn dựa trên thông tin sản phẩm này và dữ liệu thật của shop.",
  ].filter(Boolean);

  return lines.join("\n");
}

function buildProductMessageMeta(product) {
  const category =
    product.CategoryName ||
    product.categoryName ||
    product.category?.name ||
    "Sản phẩm";
  const stock =
    product.AvailableQuantity ??
    product.availableQuantity ??
    product.Quantity ??
    product.quantity;
  const stockText = hasValue(stock) ? ` · Tồn: ${stock}` : "";

  return `${formatPrice(product.Price || product.price || 0)} · ${category}${stockText}`;
}

function getProductName(product) {
  return product.ProductName || product.name || "Sản phẩm AgroShop";
}

function resolveProductImage(product) {
  const rawImage =
    product?.ImageURL ||
    product?.imageUrl ||
    product?.ImageUrl ||
    product?.image ||
    product?.Image;

  if (typeof rawImage === "string" && rawImage.trim()) {
    return rawImage;
  }

  return rawImage?.url || rawImage?.path || rawImage?.URL || DEFAULT_PRODUCT_IMAGE;
}

function hasValue(value) {
  return value !== undefined && value !== null && value !== "";
}

function compactText(value, maxLength = 240) {
  const text = String(value ?? "").replace(/\s+/g, " ").trim();

  if (text.length <= maxLength) {
    return text;
  }

  return `${text.slice(0, maxLength)}...`;
}

function buildSourceCards(sources = []) {
  if (!Array.isArray(sources) || !sources.length) {
    return "";
  }

  return sources.slice(0, 3).map((source) => {
    const productId = source.ProductID || source.id;
    const name = source.ProductName || source.name || "Sản phẩm AgroShop";
    const category = source.CategoryName || source.categoryName || "Sản phẩm";
    const price = formatPrice(source.Price || source.price || 0);
    const stock = source.AvailableQuantity ?? source.availableQuantity;
    const imageUrl = resolveProductImage(source);

    return `
      <article class="source-card">
        <img src="${escapeAttr(imageUrl)}" alt="${escapeAttr(name)}" onerror="this.src='${DEFAULT_PRODUCT_IMAGE}'">
        <div>
          <h3>${escapeHtml(name)}</h3>
          <strong>${price}</strong>
          <p>
            <span>${escapeHtml(category)}</span>
            ${stock !== undefined && stock !== null ? `<span>Tồn: ${escapeHtml(stock)}</span>` : ""}
          </p>
        </div>
        ${productId ? `<a href="/product-detail/${escapeAttr(productId)}">Xem chi tiết</a>` : ""}
      </article>
    `;
  }).join("");
}

function resetChat() {
  chatMessages.innerHTML = `
    <div class="message-row bot">
      <div class="message-avatar bot">
        <i class="fa-solid fa-robot"></i>
      </div>
      <div class="message-stack">
        <div class="message-bubble bot">
          Xin chào. Tôi là Agro AI Assistant. Bạn muốn tìm sản phẩm, phân bón, thuốc BVTV hay chẩn đoán triệu chứng cây trồng?
        </div>
      </div>
    </div>
  `;
  clearPendingAttachment();
  chatInput.focus();
}

function setSending(isSending) {
  chatInput.disabled = isSending;
  sendButton.disabled = isSending;
  if (attachImageBtn) {
    attachImageBtn.disabled = isSending;
  }
}

function scrollToBottom() {
  chatMessages.scrollTop = chatMessages.scrollHeight;
}

function renderBotReply(container, text) {
  if (!container) return;

  container.innerHTML = formatBotReply(text);
}

function formatBotReply(text) {
  const lines = String(text || "")
    .replace(/\r\n/g, "\n")
    .replace(/\s+#{1,6}\s*(?=\d+[.)])/g, "\n")
    .split("\n")
    .map((line) => line.trim())
    .filter(Boolean);

  if (!lines.length) {
    return "";
  }

  let listItems = [];
  const chunks = [];

  const flushList = () => {
    if (!listItems.length) return;
    chunks.push(`<ul>${listItems.map((item) => `<li>${item}</li>`).join("")}</ul>`);
    listItems = [];
  };

  lines.forEach((line) => {
    const cleanLine = line.replace(/^#{1,6}\s*/, "").trim();
    const listMatch = cleanLine.match(/^(?:[-*]\s+|\d+[.)]\s+)(.+)$/);

    if (listMatch) {
      listItems.push(formatInlineBotText(listMatch[1]));
      return;
    }

    flushList();
    chunks.push(`<p>${formatInlineBotText(cleanLine)}</p>`);
  });

  flushList();
  return chunks.join("");
}

function formatInlineBotText(text) {
  return escapeHtml(text)
    .replace(/\*\*([^*]+)\*\*/g, "<strong>$1</strong>")
    .replace(/\s+\*\s*/g, " ");
}

function formatPrice(price) {
  return new Intl.NumberFormat("vi-VN").format(Number(price || 0)) + "đ";
}

function formatFileSize(size) {
  if (!Number.isFinite(size)) {
    return "";
  }

  if (size < 1024 * 1024) {
    return `${Math.max(1, Math.round(size / 1024))}KB`;
  }

  return `${(size / (1024 * 1024)).toFixed(1)}MB`;
}

function escapeHtml(value) {
  return String(value ?? "")
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&#039;");
}

function escapeAttr(value) {
  return escapeHtml(value);
}
