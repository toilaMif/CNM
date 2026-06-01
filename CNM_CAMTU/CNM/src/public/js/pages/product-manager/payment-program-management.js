const API_BASE = "/api/payment-terms";

const DEFAULT_IMAGE = "/images/uploads/products/default.jpg";

const state = {
  programs: [],
  editingId: null,
};

const programGrid = document.getElementById("programGrid");
const programModal = document.getElementById("programModal");
const programForm = document.getElementById("programForm");

const btnOpenCreateProgram = document.getElementById("btnOpenCreateProgram");
const btnCloseProgramModal = document.getElementById("btnCloseProgramModal");
const btnCancelProgram = document.getElementById("btnCancelProgram");

const searchProgram = document.getElementById("searchProgram");
const filterActive = document.getElementById("filterActive");
const filterHome = document.getElementById("filterHome");
const filterSale = document.getElementById("filterSale");

const imageFileInput = document.getElementById("imageFile");
const bannerFileInput = document.getElementById("bannerFile");

const imageUrlInput = document.getElementById("imageUrl");
const bannerUrlInput = document.getElementById("bannerUrl");

const imagePreview = document.getElementById("imagePreview");
const bannerPreview = document.getElementById("bannerPreview");

const imagePreviewName = document.getElementById("imagePreviewName");
const bannerPreviewName = document.getElementById("bannerPreviewName");

/* =========================================================
   TOKEN / REQUEST
========================================================= */

function getToken() {
  return localStorage.getItem("accessToken") || "";
}

async function requestJSON(url, options = {}) {
  const res = await fetch(url, {
    ...options,
    headers: {
      "Content-Type": "application/json",
      Authorization: `Bearer ${getToken()}`,
      ...(options.headers || {}),
    },
    credentials: "include",
  });

  const data = await res.json().catch(() => ({}));

  if (!res.ok || data.success === false) {
    throw new Error(data.message || "Có lỗi xảy ra");
  }

  return data;
}

async function requestFormData(url, options = {}) {
  const res = await fetch(url, {
    ...options,
    headers: {
      Authorization: `Bearer ${getToken()}`,
      ...(options.headers || {}),
    },
    credentials: "include",
  });

  const data = await res.json().catch(() => ({}));

  if (!res.ok || data.success === false) {
    throw new Error(data.message || "Có lỗi xảy ra");
  }

  return data;
}

/* =========================================================
   HELPER
========================================================= */

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

function toTinyInt(value) {
  return value ? 1 : 0;
}

function normalizeImageUrl(url) {
  if (!url) return DEFAULT_IMAGE;

  const value = String(url).trim();

  if (!value) return DEFAULT_IMAGE;

  // URL public đúng đang lưu trong DB
  if (value.startsWith("/images/")) {
    return value;
  }

  // Nếu DB lỡ lưu thiếu dấu /
  if (value.startsWith("images/")) {
    return `/${value}`;
  }

  // Nếu DB chỉ lưu tên file
  if (!value.includes("/") && !value.includes("\\")) {
    return `/images/uploads/promotions/${value}`;
  }

  // Cho phép URL online nếu có dữ liệu cũ
  if (value.startsWith("http://") || value.startsWith("https://")) {
    return value;
  }

  return DEFAULT_IMAGE;
}

function getProgramImage(program) {
  return normalizeImageUrl(program.banner_url || program.image_url);
}

function getCardImage(program) {
  return normalizeImageUrl(program.image_url || program.banner_url);
}

function getBannerImage(program) {
  return normalizeImageUrl(program.banner_url || program.image_url);
}

function getAudienceLabel(value) {
  const map = {
    DEALER: "Đại lý",
    CUSTOMER: "Khách hàng",
    ALL: "Tất cả",
  };

  return map[value] || "Đại lý";
}

function findProgramById(programId) {
  return state.programs.find(
    (item) => Number(item.payment_term_template_id) === Number(programId)
  );
}

function bindImageFallback(scope = document) {
  scope.querySelectorAll("img[data-fallback]").forEach((img) => {
    img.addEventListener("error", () => {
      img.src = img.dataset.fallback || DEFAULT_IMAGE;
    });
  });
}

/* =========================================================
   PREVIEW IMAGE
========================================================= */

function setPreview(imgEl, nameEl, src, text) {
  if (imgEl) {
    imgEl.src = normalizeImageUrl(src || DEFAULT_IMAGE);
    imgEl.dataset.fallback = DEFAULT_IMAGE;
  }

  if (nameEl) {
    nameEl.textContent = text || "Chưa chọn ảnh mới.";
  }
}

function previewFile(fileInput, imgEl, nameEl, fallbackUrl, emptyText) {
  const file = fileInput?.files?.[0];

  if (!file) {
    setPreview(
      imgEl,
      nameEl,
      fallbackUrl || DEFAULT_IMAGE,
      emptyText || "Chưa chọn ảnh mới."
    );
    return;
  }

  if (!file.type.startsWith("image/")) {
    alert("Vui lòng chọn đúng file ảnh.");
    fileInput.value = "";

    setPreview(
      imgEl,
      nameEl,
      fallbackUrl || DEFAULT_IMAGE,
      emptyText || "Chưa chọn ảnh mới."
    );
    return;
  }

  const previewUrl = URL.createObjectURL(file);

  if (imgEl) {
    imgEl.src = previewUrl;
    imgEl.dataset.fallback = DEFAULT_IMAGE;
  }

  if (nameEl) {
    nameEl.textContent = file.name;
  }
}

function previewSelectedImages() {
  previewFile(
    imageFileInput,
    imagePreview,
    imagePreviewName,
    imageUrlInput?.value || DEFAULT_IMAGE,
    "Chưa chọn ảnh card mới."
  );

  previewFile(
    bannerFileInput,
    bannerPreview,
    bannerPreviewName,
    bannerUrlInput?.value || DEFAULT_IMAGE,
    "Chưa chọn ảnh banner mới."
  );
}

function resetFileInputs() {
  if (imageFileInput) imageFileInput.value = "";
  if (bannerFileInput) bannerFileInput.value = "";
}

/* =========================================================
   RENDER LIST
========================================================= */

function renderPrograms() {
  const keyword = searchProgram?.value.trim().toLowerCase() || "";
  const activeValue = filterActive?.value || "";
  const homeValue = filterHome?.value || "";
  const saleValue = filterSale?.value || "";

  const filtered = state.programs.filter((program) => {
    const matchKeyword =
      !keyword ||
      String(program.term_name || "")
        .toLowerCase()
        .includes(keyword);

    const matchActive =
      activeValue === "" ||
      Number(program.is_active) === Number(activeValue);

    const matchHome =
      homeValue === "" ||
      Number(program.display_on_home) === Number(homeValue);

    const matchSale =
      saleValue === "" ||
      Number(program.visible_to_sale) === Number(saleValue);

    return matchKeyword && matchActive && matchHome && matchSale;
  });

  if (!programGrid) return;

  if (!filtered.length) {
    programGrid.innerHTML = `
      <div class="empty-state">
        <h3>Chưa có chương trình nào</h3>
        <p>Bấm "Tạo chương trình" để thêm chương trình khuyến mãi.</p>
      </div>
    `;
    return;
  }

  programGrid.innerHTML = filtered
    .map((program) => {
      const programId = Number(program.payment_term_template_id);
      const isActive = Number(program.is_active) === 1;
      const displayOnHome = Number(program.display_on_home) === 1;
      const visibleToSale = Number(program.visible_to_sale) === 1;

      return `
        <article class="program-card">
          <img
            class="program-image"
            src="${escapeAttr(getProgramImage(program))}"
            alt="${escapeAttr(program.term_name || "Chương trình khuyến mãi")}"
            data-fallback="${escapeAttr(DEFAULT_IMAGE)}"
          />

          <div class="program-body">
            <div class="program-card-header">
              <div>
                <h3>${escapeHtml(program.term_name)}</h3>
                <p>${escapeHtml(program.description || "Không có mô tả")}</p>
              </div>
            </div>

            <div class="badge-row">
              <span class="badge ${isActive ? "badge-active" : "badge-inactive"}">
                ${isActive ? "Đang hoạt động" : "Ngưng hoạt động"}
              </span>

              <span class="badge ${displayOnHome ? "badge-home" : "badge-off"}">
                ${displayOnHome ? "Hiện Home" : "Ẩn Home"}
              </span>

              <span class="badge ${visibleToSale ? "badge-sale" : "badge-off"}">
                ${visibleToSale ? "Sale thấy" : "Sale không thấy"}
              </span>
            </div>

            <div class="program-meta">
              <div class="meta-item">
                <label>Công nợ</label>
                <strong>${Number(program.credit_days || 0)} ngày</strong>
              </div>

              <div class="meta-item">
                <label>Đối tượng</label>
                <strong>${getAudienceLabel(program.target_audience)}</strong>
              </div>

              <div class="meta-item">
                <label>Trả sớm</label>
                <strong>${Number(program.early_commission_rate_per_day || 0)}% / ngày</strong>
              </div>

              <div class="meta-item">
                <label>Trễ hạn</label>
                <strong>${Number(program.late_interest_rate_per_day || 0)}% / ngày</strong>
              </div>
            </div>

            <div class="program-actions">
              <button
                class="btn-small program-action"
                type="button"
                data-action="edit"
                data-id="${programId}"
              >
                Sửa
              </button>

              <button
                class="btn-small program-action"
                type="button"
                data-action="toggle-home"
                data-id="${programId}"
              >
                ${displayOnHome ? "Ẩn Home" : "Hiện Home"}
              </button>

              <button
                class="btn-small program-action"
                type="button"
                data-action="toggle-sale"
                data-id="${programId}"
              >
                ${visibleToSale ? "Ẩn Sale" : "Hiện Sale"}
              </button>

              <button
                class="btn-danger program-action"
                type="button"
                data-action="toggle-active"
                data-id="${programId}"
              >
                ${isActive ? "Ngưng" : "Bật"}
              </button>
            </div>
          </div>
        </article>
      `;
    })
    .join("");

  bindImageFallback(programGrid);
}

/* =========================================================
   LOAD DATA
========================================================= */

async function loadPrograms() {
  try {
    const data = await requestJSON(`${API_BASE}/all`);
    state.programs = data.data || [];
    renderPrograms();
  } catch (err) {
    console.error("Load payment terms error:", err);
    alert(err.message);
  }
}

/* =========================================================
   MODAL
========================================================= */

function openCreateProgram() {
  state.editingId = null;

  document.getElementById("modalTitle").innerText = "Tạo chương trình";

  programForm.reset();
  resetFileInputs();

  imageUrlInput.value = "";
  bannerUrlInput.value = "";

  document.getElementById("isActive").checked = true;
  document.getElementById("displayOnHome").checked = false;
  document.getElementById("visibleToSale").checked = true;
  document.getElementById("targetAudience").value = "DEALER";

  setPreview(
    imagePreview,
    imagePreviewName,
    DEFAULT_IMAGE,
    "Chưa chọn ảnh card mới."
  );

  setPreview(
    bannerPreview,
    bannerPreviewName,
    DEFAULT_IMAGE,
    "Chưa chọn ảnh banner mới."
  );

  bindImageFallback(programModal);
  programModal.classList.remove("hidden");
}

function closeProgramModal() {
  programModal.classList.add("hidden");
}

function fillProgramForm(program) {
  document.getElementById("paymentTermTemplateId").value =
    program.payment_term_template_id;

  document.getElementById("termName").value = program.term_name || "";
  document.getElementById("description").value = program.description || "";

  imageUrlInput.value = program.image_url || "";
  bannerUrlInput.value = program.banner_url || "";

  document.getElementById("creditDays").value = program.credit_days || 0;
  document.getElementById("earlyCommissionRate").value =
    program.early_commission_rate_per_day || 0;
  document.getElementById("lateInterestRate").value =
    program.late_interest_rate_per_day || 0;
  document.getElementById("displayOrder").value = program.display_order || 0;
  document.getElementById("targetAudience").value =
    program.target_audience || "DEALER";

  document.getElementById("isActive").checked =
    Number(program.is_active) === 1;
  document.getElementById("displayOnHome").checked =
    Number(program.display_on_home) === 1;
  document.getElementById("visibleToSale").checked =
    Number(program.visible_to_sale) === 1;

  resetFileInputs();

  setPreview(
    imagePreview,
    imagePreviewName,
    getCardImage(program),
    program.image_url ? "Ảnh card hiện tại." : "Chưa có ảnh card."
  );

  setPreview(
    bannerPreview,
    bannerPreviewName,
    getBannerImage(program),
    program.banner_url ? "Ảnh banner hiện tại." : "Chưa có ảnh banner."
  );

  bindImageFallback(programModal);
}

function openEditProgram(programId) {
  const program = findProgramById(programId);

  if (!program) {
    alert("Không tìm thấy chương trình");
    return;
  }

  state.editingId = programId;

  document.getElementById("modalTitle").innerText = "Cập nhật chương trình";
  fillProgramForm(program);

  programModal.classList.remove("hidden");
}

/* =========================================================
   FORM DATA
========================================================= */

function collectFormData() {
  const formData = new FormData();

  formData.append(
    "term_name",
    document.getElementById("termName").value.trim()
  );

  formData.append(
    "description",
    document.getElementById("description").value.trim()
  );

  // Hidden input giữ đường dẫn ảnh cũ trong DB khi sửa
  formData.append("image_url", imageUrlInput.value || "");
  formData.append("banner_url", bannerUrlInput.value || "");

  formData.append(
    "credit_days",
    Number(document.getElementById("creditDays").value || 0)
  );

  formData.append(
    "early_commission_rate_per_day",
    Number(document.getElementById("earlyCommissionRate").value || 0)
  );

  formData.append(
    "late_interest_rate_per_day",
    Number(document.getElementById("lateInterestRate").value || 0)
  );

  formData.append(
    "is_active",
    toTinyInt(document.getElementById("isActive").checked)
  );

  formData.append(
    "display_on_home",
    toTinyInt(document.getElementById("displayOnHome").checked)
  );

  formData.append(
    "visible_to_sale",
    toTinyInt(document.getElementById("visibleToSale").checked)
  );

  formData.append(
    "display_order",
    Number(document.getElementById("displayOrder").value || 0)
  );

  formData.append(
    "target_audience",
    document.getElementById("targetAudience").value || "DEALER"
  );

  const imageFile = imageFileInput?.files?.[0];
  const bannerFile = bannerFileInput?.files?.[0];

  if (imageFile) {
    formData.append("image_file", imageFile);
  }

  if (bannerFile) {
    formData.append("banner_file", bannerFile);
  }

  return formData;
}

async function handleSubmitProgram(event) {
  event.preventDefault();

  try {
    const termName = document.getElementById("termName").value.trim();

    if (!termName) {
      alert("Vui lòng nhập tên chương trình");
      return;
    }

    const payload = collectFormData();

    if (state.editingId) {
      await requestFormData(`${API_BASE}/${state.editingId}`, {
        method: "PUT",
        body: payload,
      });
    } else {
      await requestFormData(API_BASE, {
        method: "POST",
        body: payload,
      });
    }

    closeProgramModal();
    await loadPrograms();

    alert("Lưu chương trình thành công");
  } catch (err) {
    console.error("Save payment term error:", err);
    alert(err.message);
  }
}

/* =========================================================
   TOGGLE ACTIONS
========================================================= */

async function toggleActiveStatus(programId) {
  const program = findProgramById(programId);

  if (!program) return;

  const nextValue = Number(program.is_active) === 1 ? 0 : 1;

  try {
    await requestJSON(`${API_BASE}/${programId}/status`, {
      method: "PATCH",
      body: JSON.stringify({
        is_active: nextValue,
      }),
    });

    await loadPrograms();
  } catch (err) {
    console.error("Toggle active error:", err);
    alert(err.message);
  }
}

async function toggleHomeDisplay(programId) {
  const program = findProgramById(programId);

  if (!program) return;

  const nextValue = Number(program.display_on_home) === 1 ? 0 : 1;

  try {
    await requestJSON(`${API_BASE}/${programId}/home-display`, {
      method: "PATCH",
      body: JSON.stringify({
        display_on_home: nextValue,
        display_order: Number(program.display_order || 0),
        target_audience: program.target_audience || "DEALER",
      }),
    });

    await loadPrograms();
  } catch (err) {
    console.error("Toggle home display error:", err);
    alert(err.message);
  }
}

async function toggleSaleVisibility(programId) {
  const program = findProgramById(programId);

  if (!program) return;

  const nextValue = Number(program.visible_to_sale) === 1 ? 0 : 1;

  try {
    await requestJSON(`${API_BASE}/${programId}/sale-visibility`, {
      method: "PATCH",
      body: JSON.stringify({
        visible_to_sale: nextValue,
      }),
    });

    await loadPrograms();
  } catch (err) {
    console.error("Toggle sale visibility error:", err);
    alert(err.message);
  }
}

/* =========================================================
   EVENTS
========================================================= */

function initProgramActions() {
  if (!programGrid) return;

  programGrid.addEventListener("click", async (event) => {
    const button = event.target.closest(".program-action");

    if (!button) return;

    const action = button.dataset.action;
    const programId = Number(button.dataset.id);

    if (!programId) {
      alert("ID chương trình không hợp lệ");
      return;
    }

    if (action === "edit") {
      openEditProgram(programId);
      return;
    }

    if (action === "toggle-home") {
      await toggleHomeDisplay(programId);
      return;
    }

    if (action === "toggle-sale") {
      await toggleSaleVisibility(programId);
      return;
    }

    if (action === "toggle-active") {
      await toggleActiveStatus(programId);
    }
  });
}

function initPageEvents() {
  btnOpenCreateProgram?.addEventListener("click", openCreateProgram);
  btnCloseProgramModal?.addEventListener("click", closeProgramModal);
  btnCancelProgram?.addEventListener("click", closeProgramModal);

  programForm?.addEventListener("submit", handleSubmitProgram);

  searchProgram?.addEventListener("input", renderPrograms);
  filterActive?.addEventListener("change", renderPrograms);
  filterHome?.addEventListener("change", renderPrograms);
  filterSale?.addEventListener("change", renderPrograms);

  imageFileInput?.addEventListener("change", previewSelectedImages);
  bannerFileInput?.addEventListener("change", previewSelectedImages);

  programModal?.addEventListener("click", (event) => {
    if (event.target === programModal) {
      closeProgramModal();
    }
  });

  bindImageFallback(document);
}

initPageEvents();
initProgramActions();
loadPrograms();