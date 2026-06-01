/* =========================================================
   ELEMENTS
========================================================= */

const userIdEl = document.getElementById("userId");

if (!userIdEl) {
  console.error("User ID not found");
}

const userId = userIdEl?.value || null;
const API = userId ? `/api/users/${userId}` : null;

let originalUser = null;
let isLockUpdating = false;

/* =========================================================
   TOKEN
========================================================= */

function getToken() {
  return (
    localStorage.getItem("accessToken") ||
    sessionStorage.getItem("accessToken") ||
    localStorage.getItem("token") ||
    sessionStorage.getItem("token") ||
    localStorage.getItem("accesstoken")
  );
}

/* =========================================================
   SAFE JSON
========================================================= */

async function safeJson(res) {
  try {
    return await res.json();
  } catch {
    return {};
  }
}

/* =========================================================
   RESPONSE HELPER
========================================================= */

function unwrapResponse(payload) {
  if (!payload) return null;

  if (payload.data) {
    return payload.data;
  }

  return payload;
}

/* =========================================================
   ALERT
========================================================= */

function showAlert(message, type = "success") {
  const container = document.getElementById("alertContainer");

  if (!container) {
    alert(message);
    return;
  }

  const map = {
    success: "success",
    error: "danger",
    warning: "warning",
    info: "info"
  };

  container.innerHTML = `
    <div class="alert alert-${map[type] || "success"}">
      ${message}
    </div>
  `;

  setTimeout(() => {
    container.innerHTML = "";
  }, 3000);
}

/* =========================================================
   INPUT HELPERS
========================================================= */

function getValue(id) {
  const el = document.getElementById(id);

  if (!el) return "";

  return el.value.trim();
}

function setValue(id, value) {
  const el = document.getElementById(id);

  if (!el) return;

  el.value = value ?? "";
}

/* =========================================================
   USER FIELD HELPERS
========================================================= */

function getUserActiveValue(user) {
  if (!user) return 0;

  const raw =
    user.is_active ??
    user.IsActive ??
    user.active ??
    user.isActive ??
    user.status;

  if (raw === true) return 1;
  if (raw === false) return 0;

  if (typeof raw === "string") {
    const normalized = raw.trim().toLowerCase();

    if (
      normalized === "1" ||
      normalized === "active" ||
      normalized === "enabled" ||
      normalized === "unlocked"
    ) {
      return 1;
    }

    if (
      normalized === "0" ||
      normalized === "locked" ||
      normalized === "disabled" ||
      normalized === "inactive"
    ) {
      return 0;
    }
  }

  return Number(raw) === 1 ? 1 : 0;
}

function setUserActiveValue(user, value) {
  if (!user) return;

  user.is_active = Number(value);
  user.IsActive = Number(value);
}

/* =========================================================
   DATE FORMAT
========================================================= */

function formatDateInput(value) {
  if (!value) return "";

  return String(value).includes("T")
    ? String(value).split("T")[0]
    : String(value).split(" ")[0];
}

/* =========================================================
   BUILD PAYLOAD
========================================================= */

function buildPayload() {
  const payload = {
    full_name: getValue("fullName"),
    phone_number: getValue("phoneNumber"),
    gender: document.getElementById("gender")?.value || "hidden",
    address: getValue("address"),
    date_of_birth: document.getElementById("dateOfBirth")?.value || null
  };

  const phoneRegex = /^(0(3|5|7|8|9))[0-9]{8}$/;

  if (
    payload.phone_number &&
    !phoneRegex.test(payload.phone_number)
  ) {
    showAlert(
      "Số điện thoại không hợp lệ. Ví dụ: 0987654321",
      "error"
    );

    return null;
  }

  if (payload.date_of_birth) {
    const dob = new Date(payload.date_of_birth);
    const today = new Date();

    dob.setHours(0, 0, 0, 0);
    today.setHours(0, 0, 0, 0);

    if (dob > today) {
      showAlert(
        "Ngày sinh không được lớn hơn hiện tại",
        "error"
      );

      return null;
    }
  }

  Object.keys(payload).forEach((key) => {
    if (
      payload[key] === "" ||
      payload[key] === undefined
    ) {
      delete payload[key];
    }
  });

  return payload;
}

/* =========================================================
   RENDER STATUS
========================================================= */

function renderStatus(userOrActive) {
  const statusEl = document.getElementById("userStatus");
  const lockBtn = document.getElementById("lockBtn");

  if (!statusEl || !lockBtn) return;

  const active =
    typeof userOrActive === "object"
      ? getUserActiveValue(userOrActive)
      : Number(userOrActive) === 1 || userOrActive === true
        ? 1
        : 0;

  statusEl.innerHTML = active
    ? `
      <span class="badge badge-success">
        <i class="fa-solid fa-circle-check"></i>
        Active
      </span>
    `
    : `
      <span class="badge badge-danger">
        <i class="fa-solid fa-lock"></i>
        Locked
      </span>
    `;

  lockBtn.innerHTML = active
    ? `
      <i class="fa-solid fa-lock"></i>
      Lock
    `
    : `
      <i class="fa-solid fa-unlock"></i>
      Unlock
    `;

  lockBtn.className = active
    ? "btn btn-warning"
    : "btn btn-success";

  lockBtn.dataset.active = String(active);
  lockBtn.disabled = false;
}

/* =========================================================
   RENDER USER DATA
========================================================= */

function renderUserData(user) {
  if (!user) return;

  originalUser = user;

  setValue("email", user.email || user.Email);

  setValue("fullName", user.full_name || user.FullName || user.fullName);

  setValue("phoneNumber", user.phone_number || user.PhoneNumber || user.phoneNumber);

  setValue("gender", user.gender || user.Gender || "hidden");

  setValue("address", user.address || user.Address);

  setValue("roleId", user.role_id || user.RoleID || user.roleId);

  const dobEl = document.getElementById("dateOfBirth");

  if (dobEl) {
    dobEl.value = formatDateInput(
      user.date_of_birth || user.DateOfBirth || user.dateOfBirth
    );
  }

  renderStatus(user);
}

/* =========================================================
   LOAD USER
========================================================= */

async function loadUser() {
  if (!API) {
    console.error("API not found");
    return;
  }

  try {
    const token = getToken();

    const res = await fetch(API, {
      method: "GET",
      headers: {
        Authorization: `Bearer ${token}`,
        "Content-Type": "application/json"
      }
    });

    if (!res.ok) {
      if (res.status === 401) {
        window.location.href = "/auth/login";
        return;
      }

      const errorPayload = await safeJson(res);

      throw new Error(
        errorPayload.message || "Cannot load user"
      );
    }

    const payload = await safeJson(res);
    const user = unwrapResponse(payload);

    renderUserData(user);

  } catch (err) {
    console.error(err);

    showAlert(
      err.message || "Load user failed",
      "error"
    );
  }
}

/* =========================================================
   UPDATE PROFILE
========================================================= */

const editUserForm = document.getElementById("editUserForm");

if (editUserForm) {
  editUserForm.addEventListener("submit", async (e) => {
    e.preventDefault();

    try {
      const token = getToken();
      const payload = buildPayload();

      if (!payload) return;

      if (Object.keys(payload).length === 0) {
        showAlert(
          "Không có thay đổi nào",
          "warning"
        );

        return;
      }

      const res = await fetch(API, {
        method: "PATCH",
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "application/json"
        },
        body: JSON.stringify(payload)
      });

      if (!res.ok) {
        if (res.status === 401) {
          window.location.href = "/auth/login";
          return;
        }

        const data = await safeJson(res);

        throw new Error(
          data.message || "Update failed"
        );
      }

      showAlert(
        "Đã cập nhật thông tin thành công",
        "success"
      );

      await loadUser();

    } catch (err) {
      console.error(err);

      showAlert(
        err.message || "Update failed",
        "error"
      );
    }
  });
}

/* =========================================================
   UPDATE ROLE
========================================================= */

const roleSelect = document.getElementById("roleId");

if (roleSelect) {
  roleSelect.addEventListener("change", async (e) => {
    try {
      const token = getToken();
      const role_id = Number(e.target.value);

      if (!role_id) {
        showAlert(
          "Vai trò không hợp lệ",
          "error"
        );

        return;
      }

      const res = await fetch(`${API}/role`, {
        method: "PATCH",
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "application/json"
        },
        body: JSON.stringify({
          role_id
        })
      });

      if (!res.ok) {
        if (res.status === 401) {
          window.location.href = "/auth/login";
          return;
        }

        const data = await safeJson(res);

        throw new Error(
          data.message || "Role update failed"
        );
      }

      const data = await safeJson(res);

      showAlert(
        data.message || "Cập nhật vai trò thành công",
        "success"
      );

      await loadUser();

    } catch (err) {
      console.error(err);

      showAlert(
        err.message || "Role update failed",
        "error"
      );

      await loadUser();
    }
  });
}

/* =========================================================
   LOCK / UNLOCK USER
========================================================= */

const lockBtn = document.getElementById("lockBtn");

if (lockBtn) {
  lockBtn.addEventListener("click", async () => {
    if (isLockUpdating) return;

    try {
      const token = getToken();

      if (!originalUser) {
        showAlert(
          "Không tìm thấy dữ liệu người dùng",
          "error"
        );

        return;
      }

      const currentStatus = getUserActiveValue(originalUser);
      const newStatus = currentStatus === 1 ? 0 : 1;

      const confirmMessage =
        newStatus === 0
          ? "Bạn có chắc muốn khóa tài khoản này không?"
          : "Bạn có chắc muốn mở khóa tài khoản này không?";

      const confirmed = confirm(confirmMessage);

      if (!confirmed) return;

      isLockUpdating = true;
      lockBtn.disabled = true;
      lockBtn.innerHTML = `
        <i class="fa-solid fa-spinner fa-spin"></i>
        Đang xử lý...
      `;

      const res = await fetch(`${API}/lock`, {
        method: "PATCH",
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "application/json"
        },
        body: JSON.stringify({
          is_active: newStatus
        })
      });

      if (!res.ok) {
        if (res.status === 401) {
          window.location.href = "/auth/login";
          return;
        }

        const data = await safeJson(res);

        throw new Error(
          data.message || "Cập nhật trạng thái thất bại"
        );
      }

      const payload = await safeJson(res);
      const updatedUser = unwrapResponse(payload);

      if (updatedUser && typeof updatedUser === "object") {
        originalUser = {
          ...originalUser,
          ...updatedUser
        };
      } else {
        setUserActiveValue(originalUser, newStatus);
      }

      renderStatus(originalUser);

      showAlert(
        newStatus === 0
          ? "Đã khóa tài khoản"
          : "Đã mở khóa tài khoản",
        "success"
      );

      await loadUser();

    } catch (err) {
      console.error(err);

      showAlert(
        err.message || "Cập nhật trạng thái thất bại",
        "error"
      );

      renderStatus(originalUser);

    } finally {
      isLockUpdating = false;

      if (lockBtn) {
        lockBtn.disabled = false;
      }
    }
  });
}

/* =========================================================
   INIT
========================================================= */

document.addEventListener("DOMContentLoaded", () => {
  loadUser();
});