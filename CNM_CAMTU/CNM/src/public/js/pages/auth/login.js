/**
 * LOGIN PAGE + API CLIENT (COOKIE AUTH VERSION)
 * Agro Distribution System
 */

/* =========================================================
   CONFIG
========================================================= */

const LOGIN_CONFIG = {

  API_ENDPOINT: '/api/auth/login',

  REFRESH_ENDPOINT: '/api/auth/refresh',

  STORAGE_KEYS: {

    USER_INFO: 'userInfo',

    REMEMBERED_EMAIL: 'rememberedEmail',
  },

  VALIDATION: {

    EMAIL_REGEX: /^[^\s@]+@[^\s@]+\.[^\s@]+$/,

    MIN_PASSWORD_LENGTH: 6,
  },
};

/* =========================================================
   STORAGE
========================================================= */

class Storage {

  static setUser(user) {

    localStorage.setItem(
      LOGIN_CONFIG.STORAGE_KEYS.USER_INFO,
      JSON.stringify(user)
    );
  }

  static getUser() {

    const data = localStorage.getItem(
      LOGIN_CONFIG.STORAGE_KEYS.USER_INFO
    );

    return data
      ? JSON.parse(data)
      : null;
  }

  static rememberEmail(email) {

    localStorage.setItem(
      LOGIN_CONFIG.STORAGE_KEYS.REMEMBERED_EMAIL,
      email
    );
  }

  static getRememberedEmail() {

    return localStorage.getItem(
      LOGIN_CONFIG.STORAGE_KEYS.REMEMBERED_EMAIL
    );
  }

  static clear() {

    localStorage.removeItem(
      LOGIN_CONFIG.STORAGE_KEYS.USER_INFO
    );
  }
}

/* =========================================================
   ALERT
========================================================= */

class AlertManager {

  static show(message, type = 'success') {

    const container =
      document.getElementById('toastContainer');

    if (!container) return;

    const toast =
      document.createElement('div');

    toast.className =
      `custom-toast ${type}`;

    const icon =
      type === 'success'
        ? 'bi-check-circle-fill'
        : 'bi-exclamation-circle-fill';

    const title =
      type === 'success'
        ? 'Thông báo'
        : 'Thông báo';

    toast.innerHTML = `
      <div class="toast-icon">
        <i class="bi ${icon}"></i>
      </div>

      <div class="toast-content">

        <div class="toast-title">
          ${title}
        </div>

        <div class="toast-message">
          ${message}
        </div>

      </div>

      <button class="toast-close">
        <i class="bi bi-x-lg"></i>
      </button>
    `;

    container.appendChild(toast);

    toast
      .querySelector('.toast-close')
      .addEventListener('click', () => {

        this.remove(toast);
      });

    setTimeout(() => {

      this.remove(toast);

    }, 3500);
  }

  static remove(toast) {

    if (!toast) return;

    toast.style.animation =
      'toastOut 0.3s ease forwards';

    setTimeout(() => {

      toast.remove();

    }, 280);
  }

  static clear() {
    // no-op
  }
}

/* =========================================================
   VALIDATOR
========================================================= */

class Validator {

  static email(email) {

    if (!email) {

      return {
        valid: false,
        error: 'Email không được để trống'
      };
    }

    if (
      !LOGIN_CONFIG.VALIDATION
        .EMAIL_REGEX
        .test(email)
    ) {

      return {
        valid: false,
        error: 'Email không hợp lệ'
      };
    }

    return {
      valid: true
    };
  }

  static password(password) {

    if (!password) {

      return {
        valid: false,
        error: 'Mật khẩu không được để trống'
      };
    }

    if (
      password.length <
      LOGIN_CONFIG.VALIDATION
        .MIN_PASSWORD_LENGTH
    ) {

      return {
        valid: false,
        error: 'Mật khẩu tối thiểu 6 ký tự'
      };
    }

    return {
      valid: true
    };
  }

  static validateForm(email, password) {

    const e = this.email(email);

    if (!e.valid) {
      return e;
    }

    const p = this.password(password);

    if (!p.valid) {
      return p;
    }

    return {
      valid: true
    };
  }
}

/* =========================================================
   API CLIENT
========================================================= */

// class APIClient {

//   static async request(
//     url,
//     options = {},
//     retry = true
//   ) {

//     let response = await fetch(url, {

//       ...options,

//       credentials: 'include',
//     });

//     // ACCESS TOKEN EXPIRED
//     if (
//       response.status === 401 &&
//       retry
//     ) {

//       const refreshed =
//         await this.refreshToken();

//       // REFRESH SUCCESS
//       if (refreshed) {

//         response = await fetch(url, {

//           ...options,

//           credentials: 'include',
//         });

//       } else {

//         Storage.clear();

//         window.location.href =
//           '/auth/login';
//       }
//     }

//     return response;
//   }

//   static async refreshToken() {

//     try {

//       const response = await fetch(

//         LOGIN_CONFIG.REFRESH_ENDPOINT,

//         {
//           method: 'POST',

//           credentials: 'include',
//         }
//       );

//       if (!response.ok) {

//         Storage.clear();

//         return false;
//       }

//       return true;

//     } catch (err) {

//       console.error(
//         'Refresh token failed:',
//         err
//       );

//       Storage.clear();

//       return false;
//     }
//   }
// }

/* =========================================================
   AUTH API
========================================================= */

class AuthAPI {

  static async login(email, password) {

    const response = await fetch(

      LOGIN_CONFIG.API_ENDPOINT,

      {
        method: 'POST',

        headers: {
          'Content-Type': 'application/json'
        },

        credentials: 'include',

        body: JSON.stringify({
          email,
          password
        }),
      }
    );

    const data =
      await response.json();

    if (!response.ok) {

      throw new Error(
        data.message ||
        'Đăng nhập thất bại'
      );
    }

    return data;
  }
}

/* =========================================================
   REDIRECT
========================================================= */

class Redirect {

  static go(role) {

    const normalizedRole =
      String(role || '')
        .trim()
        .toUpperCase();

    const map = {

      ADMIN:
        '/admin/dashboard',

      MANAGER:
        '/manager/dashboard',
        
      PRODUCT_MANAGER:
        '/product-manager/dashboard',

      WAREHOUSE_EMPLOYEE:
        '/warehouse/dashboard',

      SALE:
        '/sale/order-manager',

      CUSTOMER:
        '/home',
    };

    const target =
      map[normalizedRole];

    if (target) {

      window.location.href =
        target;

    } else {

      console.error(
        'Không tìm thấy đường dẫn cho quyền:',
        normalizedRole
      );

      window.location.href =
        '/dashboard';
    }
  }
}

/* =========================================================
   LOGIN FORM
========================================================= */

class LoginForm {

  constructor() {

    this.form =
      document.getElementById(
        'loginForm'
      );

    this.email =
      document.getElementById(
        'email'
      );

    this.password =
      document.getElementById(
        'password'
      );

    this.remember =
      document.getElementById(
        'rememberMe'
      );

    this.button =
      document.querySelector(
        '.login-btn'
      );

    this.init();
  }

  init() {

    if (!this.form) return;

    this.form.addEventListener(
      'submit',
      (e) => this.handleSubmit(e)
    );

    this.restoreEmail();
  }

  restoreEmail() {

    const email =
      Storage.getRememberedEmail();

    if (email && this.email) {

      this.email.value = email;

      if (this.remember) {

        this.remember.checked = true;
      }
    }
  }

  setLoading(state) {

    if (!this.button) return;

    this.button.disabled = state;

    this.button.innerHTML = state
      ? 'Đang đăng nhập...'
      : 'Đăng nhập';
  }

  async handleSubmit(e) {

    e.preventDefault();

    AlertManager.clear();

    const email =
      this.email.value.trim();

    const password =
      this.password.value;

    const valid =
      Validator.validateForm(
        email,
        password
      );

    if (!valid.valid) {

      AlertManager.show(valid.error);

      return;
    }

    this.setLoading(true);

    try {

      const data =
        await AuthAPI.login(
          email,
          password
        );

      Storage.setUser(data.user);

      if (this.remember?.checked) {

        Storage.rememberEmail(
          email
        );

      } else {

        localStorage.removeItem(
          'rememberedEmail'
        );
      }

      AlertManager.show(
        'Đăng nhập thành công',
        'success'
      );

      setTimeout(() => {

        if (
          data.requireChangePassword
        ) {

          window.location.href =
            '/change-password';

          return;
        }

        Redirect.go(

          data.user?.role_name ||

          data.user?.role
        );

      }, 800);

    } catch (err) {

      AlertManager.show(

        err.message ||

        'Lỗi hệ thống'
      );

    } finally {

      this.setLoading(false);
    }
  }
}

/* =========================================================
   INIT
========================================================= */

document.addEventListener(
  'DOMContentLoaded',
  () => {

    new LoginForm();
  }
);