const API = "/api/products";
const PROMOTION_API = "/api/payment-terms/home-promotions";

const DEFAULT_PRODUCT_IMAGE = "/images/uploads/products/default.jpg";
const DEFAULT_BANNER_IMAGE = "/images/uploads/products/default.jpg";

let state = {
  keyword: "",
  category: "",
  showAllProducts: false,
};

let promotionState = {
  items: [],
  currentIndex: 0,
};

let allProducts = [];
let currentProductResults = [];
let debounceTimer = null;
let resizeTimer = null;

document.addEventListener("DOMContentLoaded", () => {
  initSearch();
  initCategory();
  initProductReveal();
  initPromotionBanner();
  loadProducts();
  loadHomePromotions();
  initAiChat();
});

/* =========================================================
   IMAGE HELPERS
   Chuẩn hóa đường dẫn ảnh lấy từ DB:
   - /images/uploads/promotions/abc.png
   - images/uploads/promotions/abc.png
   - src/public/images/uploads/promotions/abc.png
   - abc.png
========================================================= */

function normalizePublicImageUrl(url, fallback = DEFAULT_PRODUCT_IMAGE) {
  if (!url) return fallback;

  const value = String(url).trim();

  if (!value) return fallback;

  if (value.startsWith("http://") || value.startsWith("https://")) {
    return value;
  }

  if (value.startsWith("/images/")) {
    return value;
  }

  if (value.startsWith("images/")) {
    return `/${value}`;
  }

  const normalizedPath = value.replaceAll("\\", "/");
  const publicIndex = normalizedPath.indexOf("public/images/");

  if (publicIndex >= 0) {
    return `/${normalizedPath.slice(publicIndex + "public/".length)}`;
  }

  if (!value.includes("/") && !value.includes("\\")) {
    return `/images/uploads/promotions/${value}`;
  }

  return fallback;
}

function getPromotionBannerImage(promotion) {
  return normalizePublicImageUrl(
    promotion?.banner_url || promotion?.image_url,
    DEFAULT_BANNER_IMAGE
  );
}

function getPromotionCardImage(promotion) {
  return normalizePublicImageUrl(
    promotion?.image_url || promotion?.banner_url,
    DEFAULT_BANNER_IMAGE
  );
}

function bindImageFallback(scope = document) {
  scope.querySelectorAll("img[data-fallback]").forEach((img) => {
    img.addEventListener("error", () => {
      img.src = img.dataset.fallback || DEFAULT_PRODUCT_IMAGE;
    });
  });
}

/* =========================================================
   PROMOTION BANNER + HORIZONTAL CAROUSEL
   API: GET /api/payment-terms/home-promotions
========================================================= */

function initPromotionBanner() {
  const nextHeroBtn = document.getElementById("nextPromotionBtn");
  const prevBtn = document.getElementById("promotionPrevBtn");
  const nextBtn = document.getElementById("promotionNextBtn");
  const grid = document.getElementById("promotionGrid");

  nextHeroBtn?.addEventListener("click", () => {
    if (!promotionState.items.length) return;

    promotionState.currentIndex =
      (promotionState.currentIndex + 1) % promotionState.items.length;

    renderHeroPromotion(promotionState.items[promotionState.currentIndex]);
  });

  const scrollPromotion = (direction) => {
    if (!grid) return;

    const firstCard = grid.querySelector(".promotion-card");
    const cardGap = 24;

    const cardWidth = firstCard
      ? firstCard.offsetWidth + cardGap
      : grid.clientWidth * 0.8;

    grid.scrollBy({
      left: direction * cardWidth,
      behavior: "smooth",
    });
  };

  prevBtn?.addEventListener("click", () => scrollPromotion(-1));
  nextBtn?.addEventListener("click", () => scrollPromotion(1));

  if (!grid) return;

  let isDown = false;
  let startX = 0;
  let scrollLeft = 0;

  grid.addEventListener("mousedown", (event) => {
    isDown = true;
    grid.classList.add("is-dragging");
    startX = event.pageX - grid.offsetLeft;
    scrollLeft = grid.scrollLeft;
  });

  grid.addEventListener("mouseleave", () => {
    isDown = false;
    grid.classList.remove("is-dragging");
  });

  grid.addEventListener("mouseup", () => {
    isDown = false;
    grid.classList.remove("is-dragging");
  });

  grid.addEventListener("mousemove", (event) => {
    if (!isDown) return;

    event.preventDefault();

    const x = event.pageX - grid.offsetLeft;
    const walk = (x - startX) * 1.2;

    grid.scrollLeft = scrollLeft - walk;
  });

  grid.addEventListener(
    "wheel",
    (event) => {
      if (Math.abs(event.deltaY) <= Math.abs(event.deltaX)) return;

      event.preventDefault();

      grid.scrollBy({
        left: event.deltaY,
        behavior: "auto",
      });
    },
    { passive: false }
  );
}

async function loadHomePromotions() {
  const promotionSection = document.getElementById("promotionSection");

  try {
    const res = await fetch(PROMOTION_API, {
      credentials: "include",
    });

    const result = await res.json();

    if (!res.ok || !result.success) {
      throw new Error(result.message || "Không tải được chương trình khuyến mãi");
    }

    const promotions = Array.isArray(result.data) ? result.data : [];

    promotionState.items = promotions;
    promotionState.currentIndex = 0;

    if (!promotions.length) {
      renderHeroPromotion(null);
      renderPromotionGrid([]);

      if (promotionSection) {
        promotionSection.hidden = true;
      }

      updatePromotionNavVisibility();
      return;
    }

    if (promotionSection) {
      promotionSection.hidden = false;
    }

    renderHeroPromotion(promotions[0]);
    renderPromotionGrid(promotions);
    updatePromotionNavVisibility();
  } catch (err) {
    console.error("Load home promotions error:", err);

    renderHeroPromotion(null);
    renderPromotionGrid([]);

    if (promotionSection) {
      promotionSection.hidden = true;
    }

    updatePromotionNavVisibility();
  }
}

function updatePromotionNavVisibility() {
  const prevBtn = document.getElementById("promotionPrevBtn");
  const nextBtn = document.getElementById("promotionNextBtn");

  const shouldShow = promotionState.items.length > 1;

  if (prevBtn) prevBtn.hidden = !shouldShow;
  if (nextBtn) nextBtn.hidden = !shouldShow;
}

function renderHeroPromotion(promotion) {
  const titleEl = document.querySelector("#bannerTitle");
  const subtitleEl = document.querySelector("#bannerSubtitle");
  const descriptionEl = document.querySelector("#bannerDescription");
  const imageEl = document.querySelector("#bannerImage");
  const buttonEl = document.querySelector("#bannerButton");
  const metaEl = document.querySelector("#bannerPromoMeta");

  if (!promotion) {
    if (titleEl) {
      titleEl.textContent = "Khuyến mãi đặc biệt hôm nay";
    }

    if (subtitleEl) {
      subtitleEl.textContent = "Ưu đãi dành cho đại lý AgroShop";
    }

    if (descriptionEl) {
      descriptionEl.textContent =
        "Hiện chưa có chương trình khuyến mãi mới. Vui lòng quay lại sau.";
    }

    if (imageEl) {
      imageEl.src = DEFAULT_BANNER_IMAGE;
      imageEl.alt = "Chương trình khuyến mãi AgroShop";
      imageEl.dataset.fallback = DEFAULT_BANNER_IMAGE;
    }

    if (buttonEl) {
      buttonEl.href = "#productList";
      buttonEl.innerHTML = `
        Xem sản phẩm
        <i class="fa-solid fa-arrow-right"></i>
      `;
    }

    if (metaEl) {
      metaEl.innerHTML = "";
    }

    return;
  }

  const title =
    promotion.term_name ||
    promotion.program_name ||
    "Chương trình khuyến mãi AgroShop";

  const description =
    promotion.description ||
    "Chương trình ưu đãi dành cho đại lý của AgroShop.";

  const creditDays = Number(promotion.credit_days || 0);
  const earlyRate = Number(promotion.early_commission_rate_per_day || 0);
  const lateRate = Number(promotion.late_interest_rate_per_day || 0);

  const imageUrl = getPromotionBannerImage(promotion);

  if (titleEl) {
    titleEl.textContent = title;
  }

  if (subtitleEl) {
    subtitleEl.textContent =
      creditDays > 0
        ? `Công nợ ${creditDays} ngày cho đại lý`
        : "Ưu đãi mới dành cho đại lý";
  }

  if (descriptionEl) {
    descriptionEl.textContent = description;
  }

  if (imageEl) {
    imageEl.src = imageUrl;
    imageEl.alt = title;
    imageEl.dataset.fallback = DEFAULT_BANNER_IMAGE;
  }

  if (buttonEl) {
    buttonEl.href = "#promotionSection";
    buttonEl.innerHTML = `
      Xem chương trình
      <i class="fa-solid fa-arrow-right"></i>
    `;
  }

  if (metaEl) {
    metaEl.innerHTML = `
      <span>
        <i class="fa-solid fa-calendar-days"></i>
        Công nợ ${creditDays} ngày
      </span>

      <span>
        <i class="fa-solid fa-hand-holding-dollar"></i>
        Hoa hồng trả sớm ${earlyRate}% / ngày
      </span>

      <span>
        <i class="fa-solid fa-triangle-exclamation"></i>
        Lãi trễ hạn ${lateRate}% / ngày
      </span>
    `;
  }

  bindImageFallback(document);
}

function renderPromotionGrid(promotions = []) {
  const container = document.getElementById("promotionGrid");

  if (!container) return;

  if (!promotions.length) {
    container.innerHTML = "";
    return;
  }

  container.innerHTML = promotions
    .map((promotion, index) => {
      const title =
        promotion.term_name ||
        promotion.program_name ||
        "Chương trình khuyến mãi";

      const description =
        promotion.description ||
        "Chương trình ưu đãi dành cho đại lý của AgroShop.";

      const imageUrl = getPromotionCardImage(promotion);

      const creditDays = Number(promotion.credit_days || 0);
      const earlyRate = Number(promotion.early_commission_rate_per_day || 0);
      const lateRate = Number(promotion.late_interest_rate_per_day || 0);

      return `
        <article class="promotion-card" data-index="${index}">
          <img
            class="promotion-card__image"
            src="${escapeAttr(imageUrl)}"
            alt="${escapeAttr(title)}"
            loading="lazy"
            data-fallback="${escapeAttr(DEFAULT_BANNER_IMAGE)}"
          />

          <div class="promotion-card__body">
            <span class="promotion-card__badge">
              Dành cho đại lý
            </span>

            <h3>${escapeHtml(title)}</h3>

            <p>${escapeHtml(description)}</p>

            <div class="promotion-card__info">
              <span>
                <i class="fa-solid fa-calendar-check"></i>
                Công nợ ${creditDays} ngày
              </span>

              <span>
                <i class="fa-solid fa-hand-holding-dollar"></i>
                Hoa hồng trả sớm ${earlyRate}% / ngày
              </span>

              <span>
                <i class="fa-solid fa-triangle-exclamation"></i>
                Lãi trễ hạn ${lateRate}% / ngày
              </span>
            </div>
          </div>
        </article>
      `;
    })
    .join("");

  bindImageFallback(container);

  container.querySelectorAll(".promotion-card").forEach((card) => {
    card.addEventListener("click", () => {
      const index = Number(card.dataset.index || 0);

      if (!promotionState.items[index]) return;

      promotionState.currentIndex = index;
      renderHeroPromotion(promotionState.items[index]);

      document.querySelector("#heroBanner")?.scrollIntoView({
        behavior: "smooth",
        block: "start",
      });
    });
  });
}

/* =========================================================
   PRODUCTS
========================================================= */

async function loadProducts() {
  const countText = document.getElementById("productCountText");

  try {
    const res = await fetch(`${API}?page=1&limit=1000&sort=newest`, {
      credentials: "include",
    });

    const data = await res.json();

    if (!res.ok) {
      throw new Error(data.message || "Không tải được sản phẩm");
    }

    const payload = data.data || data;

    allProducts = Array.isArray(payload)
      ? payload
      : payload.items || [];

    renderProducts(allProducts);
  } catch (err) {
    console.error("Load products error:", err);

    if (countText) {
      countText.textContent = "Không tải được sản phẩm";
    }

    const container = document.getElementById("productGrid");
    if (container) {
      container.innerHTML = `<p class="empty">Không tải được sản phẩm. Vui lòng thử lại sau.</p>`;
    }
  }
}

function initSearch() {
  const input = document.getElementById("searchInput");
  const btn = document.getElementById("searchBtn");

  const handleSearch = () => {
    state.keyword = input?.value.trim() || "";
    debounceSearch();
  };

  btn?.addEventListener("click", handleSearch);

  input?.addEventListener("keydown", (e) => {
    if (e.key === "Enter") {
      handleSearch();
    }
  });

  input?.addEventListener("input", (e) => {
    state.keyword = e.target.value.trim();
    debounceSearch();
  });
}

function initCategory() {
  document.querySelectorAll(".category-btn").forEach((btn) => {
    btn.addEventListener("click", () => {
      state.category = btn.dataset.id || "";

      document
        .querySelectorAll(".category-btn")
        .forEach((item) => item.classList.remove("active"));

      btn.classList.add("active");
      debounceSearch();
    });
  });
}

function initProductReveal() {
  const moreLink = document.querySelector(".ghost-link");

  const toggleProducts = (event) => {
    event.preventDefault();
    state.showAllProducts = !state.showAllProducts;

    renderProducts(currentProductResults);
    scrollToProductList();
  };

  moreLink?.addEventListener("click", toggleProducts);

  window.addEventListener("resize", () => {
    if (state.showAllProducts || !currentProductResults.length) return;

    clearTimeout(resizeTimer);
    resizeTimer = setTimeout(() => {
      renderProducts(currentProductResults);
    }, 120);
  });
}

function scrollToProductList() {
  document.querySelector("#productList")?.scrollIntoView({
    behavior: "smooth",
    block: "start",
  });
}

function debounceSearch(delay = 250) {
  clearTimeout(debounceTimer);
  debounceTimer = setTimeout(searchProducts, delay);
}

function searchProducts() {
  const keyword = normalizeText(state.keyword);
  const category = state.category;

  let result = [...allProducts];

  if (category) {
    result = result.filter((product) => {
      return String(getCategoryId(product)) === String(category);
    });
  }

  if (keyword) {
    result = result.filter((product) => {
      const searchable = [
        product.ProductName,
        product.name,
        product.SKU,
        product.sku,
        product.Brand,
        product.brand,
        product.Description,
        product.description,
        getCategoryName(product),
      ].join(" ");

      return normalizeText(searchable).includes(keyword);
    });
  }

  renderProducts(result);
}

function renderProducts(products = []) {
  const container = document.getElementById("productGrid");
  const countText = document.getElementById("productCountText");

  if (!container) return;

  currentProductResults = Array.isArray(products) ? products : [];

  if (!currentProductResults.length) {
    container.innerHTML = `<p class="empty">Không có sản phẩm phù hợp.</p>`;
    updateProductToggleLink(false);

    if (countText) {
      countText.textContent = "Không có sản phẩm nào";
    }

    return;
  }

  const visibleProducts = state.showAllProducts
    ? currentProductResults
    : currentProductResults.slice(0, getFirstRowProductLimit());

  if (countText) {
    countText.textContent =
      visibleProducts.length < currentProductResults.length
        ? `Đang hiển thị ${visibleProducts.length}/${currentProductResults.length} sản phẩm đầu tiên`
        : `Hiển thị ${currentProductResults.length} sản phẩm`;
  }

  container.innerHTML = visibleProducts.map(renderProductCard).join("");

  bindImageFallback(container);

  updateProductToggleLink(currentProductResults.length > getFirstRowProductLimit());
}

function updateProductToggleLink(canToggle) {
  const toggleLink = document.querySelector(".ghost-link");

  if (!toggleLink) return;

  toggleLink.hidden = !canToggle;

  if (!canToggle) return;

  toggleLink.innerHTML = state.showAllProducts
    ? 'Ẩn bớt <i class="fa-solid fa-chevron-up"></i>'
    : 'Xem thêm <i class="fa-solid fa-chevron-right"></i>';

  toggleLink.setAttribute(
    "aria-label",
    state.showAllProducts ? "Ẩn bớt sản phẩm" : "Xem thêm sản phẩm"
  );
}

function getFirstRowProductLimit() {
  if (window.matchMedia("(max-width: 540px)").matches) {
    return 1;
  }

  if (window.matchMedia("(max-width: 820px)").matches) {
    return 2;
  }

  if (window.matchMedia("(max-width: 1100px)").matches) {
    return 3;
  }

  return 4;
}

function renderProductCard(product) {
  const productId = product.ProductID || product.id;
  const productName = product.ProductName || product.name || "Sản phẩm AgroShop";
  const productPrice = product.Price || product.price || 0;
  const description =
    product.Description ||
    product.description ||
    product.TechnicalContent ||
    product.technicalContent ||
    "Sản phẩm nông nghiệp chất lượng cao, phù hợp cho mùa vụ của bạn.";
  const categoryName = getCategoryName(product);
  const imageSrc = resolveProductImage(product);

  return `
    <article class="product-card">
      <div class="product-card__media">
        <img
          src="${escapeAttr(imageSrc)}"
          alt="${escapeAttr(productName)}"
          loading="lazy"
          data-fallback="${escapeAttr(DEFAULT_PRODUCT_IMAGE)}"
        />
      </div>
      <div class="product-card__body">
        <span class="product-card__category">${escapeHtml(categoryName)}</span>
        <h3>${escapeHtml(productName)}</h3>
        <p class="product-card__price">${formatPrice(productPrice)}</p>
        <p class="product-card__description">${escapeHtml(description)}</p>
        <button class="product-card__button btn-detail" type="button" data-id="${escapeAttr(productId)}">
          <i class="fa-solid fa-basket-shopping"></i>
          Xem chi tiết
        </button>
      </div>
    </article>
  `;
}

function resolveProductImage(product) {
  const rawImage =
    product.ImageURL ||
    product.imageUrl ||
    product.ImageUrl ||
    product.image ||
    product.Image;

  if (typeof rawImage === "string" && rawImage.trim()) {
    return normalizePublicImageUrl(rawImage, DEFAULT_PRODUCT_IMAGE);
  }

  const objectImage =
    rawImage?.url ||
    rawImage?.path ||
    rawImage?.URL ||
    rawImage?.ImageURL;

  return normalizePublicImageUrl(objectImage, DEFAULT_PRODUCT_IMAGE);
}

function getCategoryName(product) {
  return (
    product.CategoryName ||
    product.category?.name ||
    product.categoryName ||
    "Sản phẩm nông nghiệp"
  );
}

function getCategoryId(product) {
  return product.CategoryID || product.category?.id || product.categoryId || "";
}

function viewProductDetail(id) {
  window.location.href = `/product-detail/${id}`;
}

function formatPrice(price) {
  return new Intl.NumberFormat("vi-VN").format(Number(price || 0)) + "đ";
}

function normalizeText(str) {
  return String(str || "")
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .toLowerCase()
    .trim();
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

document.addEventListener("click", (e) => {
  const btn = e.target.closest(".btn-detail");
  if (!btn) return;

  const id = btn.dataset.id;
  if (!id) return;

  viewProductDetail(id);
});

/* =========================================================
   AI CHAT
========================================================= */

function initAiChat() {
  const chatBox = document.getElementById("aiChatBox");
  const openBtn = document.getElementById("openChatBtn");
  const closeBtn = document.getElementById("closeChat");
  const input = document.getElementById("chatInput");
  const sendBtn = document.getElementById("sendChat");
  const chatBody = document.getElementById("chatBody");
  const attachBtn = document.getElementById("miniChatAttachBtn");
  const imageInput = document.getElementById("miniChatImageInput");
  const attachment = document.getElementById("miniChatAttachment");
  const attachmentImage = document.getElementById("miniChatAttachmentImage");
  const attachmentName = document.getElementById("miniChatAttachmentName");
  const attachmentMeta = document.getElementById("miniChatAttachmentMeta");
  const removeImageBtn = document.getElementById("miniChatRemoveImage");
  const suggestionButtons = document.querySelectorAll("[data-chat-suggestion]");
  const messages = [];
  let isSending = false;
  let pendingImage = null;
  const defaultSendHtml = sendBtn?.innerHTML || '<i class="fa-solid fa-paper-plane"></i>';
  const defaultPlaceholder = input?.placeholder || "";
  const maxImageSize = 5 * 1024 * 1024;

  if (!chatBox || !openBtn || !closeBtn || !input || !sendBtn || !chatBody) {
    return;
  }

  const openChat = () => {
    chatBox.classList.add("active");
    input.focus();
  };

  const closeChat = () => {
    chatBox.classList.remove("active");
  };

  const addMessage = (text, type) => {
    const msg = document.createElement("div");

    if (type === "bot") {
      msg.className = "chat-welcome chat-reply";
      msg.innerHTML = `
        <span class="chat-welcome__icon">
          <i class="fa-solid fa-robot"></i>
        </span>
        <div>
          <strong>AgroBot trả lời</strong>
          <p></p>
        </div>
      `;
      msg.querySelector("p").textContent = text;
    } else {
      msg.className = `msg ${type}`;
      msg.textContent = text;
    }

    chatBody.appendChild(msg);
    chatBody.scrollTop = chatBody.scrollHeight;
  };

  const formatFileSize = (size) => {
    if (!Number.isFinite(size)) return "";
    if (size < 1024 * 1024) return `${Math.max(1, Math.round(size / 1024))}KB`;
    return `${(size / (1024 * 1024)).toFixed(1)}MB`;
  };

  const clearPendingImage = (options = {}) => {
    const { revokeUrl = true } = options;

    if (revokeUrl && pendingImage?.url) {
      URL.revokeObjectURL(pendingImage.url);
    }

    pendingImage = null;

    if (attachment) attachment.hidden = true;
    if (attachmentImage) attachmentImage.removeAttribute("src");
    if (attachmentName) attachmentName.textContent = "";
    if (attachmentMeta) attachmentMeta.textContent = "";
    if (imageInput) imageInput.value = "";
    input.placeholder = defaultPlaceholder;
  };

  const renderPendingImage = () => {
    if (!pendingImage || !attachment || !attachmentImage || !attachmentName || !attachmentMeta) {
      return;
    }

    attachment.hidden = false;
    attachmentImage.src = pendingImage.url;
    attachmentName.textContent = pendingImage.file.name || "Ảnh đã chọn";
    attachmentMeta.textContent = `${formatFileSize(pendingImage.file.size)} · Sẽ gửi kèm tin nhắn`;
  };

  const addImageMessage = (file, imageUrl, text) => {
    const msg = document.createElement("div");
    msg.className = "msg user image-msg";

    const image = document.createElement("img");
    image.src = imageUrl;
    image.alt = file.name || "Anh da chon";
    image.addEventListener("load", () => URL.revokeObjectURL(imageUrl), { once: true });

    const question = document.createElement("p");
    question.textContent = text;

    const caption = document.createElement("span");
    caption.textContent = `${file.name || "Ảnh đã chọn"} · ${formatFileSize(file.size)}`;

    msg.append(image, question, caption);
    chatBody.appendChild(msg);
    chatBody.scrollTop = chatBody.scrollHeight;
  };

  const handleImageSelected = (event) => {
    const file = event.target.files?.[0];
    if (!file) return;

    event.target.value = "";

    if (!file.type.startsWith("image/")) {
      addMessage("Vui lòng chọn đúng file ảnh.", "bot");
      return;
    }

    if (file.size > maxImageSize) {
      addMessage("Ảnh hơi lớn rồi. Bạn chọn ảnh dưới 5MB giúp mình nha.", "bot");
      return;
    }

    clearPendingImage();
    pendingImage = {
      file,
      url: URL.createObjectURL(file),
    };

    renderPendingImage();
    input.placeholder = "Mô tả ảnh để AgroBot tư vấn...";
    input.focus();
  };

  const setSending = (sending) => {
    isSending = sending;
    input.disabled = sending;
    sendBtn.disabled = sending;
    if (attachBtn) attachBtn.disabled = sending;
    sendBtn.innerHTML = sending ? "..." : defaultSendHtml;
  };

  const askAi = async () => {
    const res = await fetch("/api/ai-advisor/chat", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ messages }),
    });

    const data = await res.json().catch(() => ({}));

    if (!res.ok || !data.success) {
      throw new Error(data.message || "Không thể gọi AI");
    }

    return data.data?.reply || "";
  };

  const sendMessage = async () => {
    if (isSending) return;

    const text = input.value.trim();
    if (!text) {
      if (pendingImage) {
        input.placeholder = "Nhập câu hỏi cho ảnh này trước khi gửi...";
        input.focus();
      }

      return;
    }

    const attachedImage = pendingImage;
    const messageText = attachedImage
      ? `${text}\n\n[Người dùng đã đính kèm ảnh: ${attachedImage.file.name}. Hiện hệ thống chưa phân tích ảnh trực tiếp; hãy tư vấn dựa trên câu hỏi và yêu cầu người dùng mô tả thêm nếu cần.]`
      : text;

    if (attachedImage) {
      addImageMessage(attachedImage.file, attachedImage.url, text);
      clearPendingImage({ revokeUrl: false });
    } else {
      addMessage(text, "user");
    }

    messages.push({
      role: "user",
      content: messageText,
    });

    input.value = "";

    try {
      setSending(true);
      const reply = await askAi();

      messages.push({
        role: "assistant",
        content: reply,
      });

      addMessage(reply || "AI chưa có phản hồi.", "bot");
    } catch (error) {
      console.error("AI chat error:", error);
      addMessage(error.message || "AgroBot hiện chưa thể phản hồi. Vui lòng thử lại sau.", "bot");
      return;
      addMessage(
        "Chưa kết nối được AgroBot. Vui lòng kiểm tra Ollama và thử lại sau.",
        "bot"
      );
    } finally {
      setSending(false);
      input.focus();
    }
  };

  openBtn.addEventListener("click", (event) => {
    event.preventDefault();

    if (chatBox.classList.contains("active")) {
      closeChat();
    } else {
      openChat();
    }
  });

  closeBtn.addEventListener("click", closeChat);
  sendBtn.addEventListener("click", sendMessage);
  attachBtn?.addEventListener("click", () => imageInput?.click());
  imageInput?.addEventListener("change", handleImageSelected);
  removeImageBtn?.addEventListener("click", () => {
    clearPendingImage();
    input.focus();
  });

  suggestionButtons.forEach((button) => {
    button.addEventListener("click", () => {
      input.value = button.dataset.chatSuggestion || "";
      sendMessage();
    });
  });

  input.addEventListener("keydown", (e) => {
    if (e.key === "Enter") {
      sendMessage();
    }
  });

  document.querySelectorAll('a[href="#aiChatBox"]').forEach((link) => {
    link.addEventListener("click", () => {
      setTimeout(openChat, 80);
    });
  });

  if (window.location.hash === "#aiChatBox") {
    setTimeout(openChat, 150);
  }
}
