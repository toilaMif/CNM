/**
 * Admin User Management JavaScript
 * Handles all user management operations for admin panel
 */

class AdminUserManager {
  constructor() {
    this.users = [];
    this.currentUser = null;
    this.apiBaseUrl = '/api/users';
    this.init();
  }

  async init() {
    this.setupEventListeners();
    this.loadTokenFromStorage();
  }

  setupEventListeners() {
    // Close modals on outside click
    document.querySelectorAll('.modal').forEach(modal => {
      modal.addEventListener('click', (e) => {
        if (e.target === modal) {
          this.closeModal(modal.id);
        }
      });
    });
  }

  loadTokenFromStorage() {
    const token = localStorage.getItem('access_token');
    if (!token) {
      window.location.href = '/auth/login';
    }
    this.authToken = token;
  }

  // API Methods
  async fetchUsers() {
    try {
      const response = await fetch(this.apiBaseUrl, {
        headers: {
          'Authorization': `Bearer ${this.authToken}`,
          'Content-Type': 'application/json'
        }
      });

      if (!response.ok) {
        if (response.status === 401) {
          this.logout();
          return;
        }
        throw new Error('Failed to fetch users');
      }

      this.users = await response.json();
      return this.users;
    } catch (error) {
      console.error('Error fetching users:', error);
      this.showAlert('Lỗi tải dữ liệu tài khoản', 'danger');
      return [];
    }
  }

  async createUser(userData) {
    try {
      const response = await fetch(this.apiBaseUrl, {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${this.authToken}`,
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(userData)
      });

      if (!response.ok) {
        const error = await response.json();
        throw new Error(error.message || 'Failed to create user');
      }

      this.showAlert('✅ Tạo tài khoản thành công! Mật khẩu đã được gửi đến email.', 'success');
      return await response.json();
    } catch (error) {
      console.error('Error creating user:', error);
      this.showAlert('Lỗi: ' + error.message, 'danger');
      throw error;
    }
  }

  async updateUser(userId, userData) {
    try {
      const response = await fetch(`${this.apiBaseUrl}/${userId}`, {
        method: 'PUT',
        headers: {
          'Authorization': `Bearer ${this.authToken}`,
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(userData)
      });

      if (!response.ok) {
        throw new Error('Failed to update user');
      }

      this.showAlert('✅ Cập nhật tài khoản thành công!', 'success');
      return await response.json();
    } catch (error) {
      console.error('Error updating user:', error);
      this.showAlert('Lỗi: ' + error.message, 'danger');
      throw error;
    }
  }

  async toggleLockUser(userId, shouldLock) {
    try {
      const response = await fetch(`${this.apiBaseUrl}/${userId}/lock`, {
        method: 'PATCH',
        headers: {
          'Authorization': `Bearer ${this.authToken}`,
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ lock: shouldLock })
      });

      if (!response.ok) {
        throw new Error('Failed to toggle lock');
      }

      const message = shouldLock ? '🔒 Khóa tài khoản thành công!' : '🔓 Mở khóa tài khoản thành công!';
      this.showAlert(message, 'success');
      return await response.json();
    } catch (error) {
      console.error('Error toggling lock:', error);
      this.showAlert('Lỗi: ' + error.message, 'danger');
      throw error;
    }
  }

  async updateUserRole(userId, roleId) {
    try {
      const response = await fetch(`${this.apiBaseUrl}/${userId}/role`, {
        method: 'PATCH',
        headers: {
          'Authorization': `Bearer ${this.authToken}`,
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ role: roleId })
      });

      if (!response.ok) {
        throw new Error('Failed to update role');
      }

      this.showAlert('✅ Cập nhật quyền thành công!', 'success');
      return await response.json();
    } catch (error) {
      console.error('Error updating role:', error);
      this.showAlert('Lỗi: ' + error.message, 'danger');
      throw error;
    }
  }

  // UI Methods
  openModal(modalId) {
    const modal = document.getElementById(modalId);
    if (modal) {
      modal.classList.add('active');
    }
  }

  closeModal(modalId) {
    const modal = document.getElementById(modalId);
    if (modal) {
      modal.classList.remove('active');
    }
  }

  showAlert(message, type = 'info') {
    const alertContainer = document.getElementById('alertContainer');
    if (!alertContainer) return;

    const alertDiv = document.createElement('div');
    alertDiv.className = `alert alert-${type}`;
    const icons = {
      success: '✅',
      danger: '❌',
      warning: '⚠️',
      info: 'ℹ️'
    };
    alertDiv.innerHTML = `${icons[type] || 'ℹ️'} ${message}`;
    
    alertContainer.appendChild(alertDiv);
    
    setTimeout(() => {
      alertDiv.remove();
    }, 4000);
  }

  logout() {
    localStorage.clear();
    sessionStorage.clear();
    window.location.href = '/auth/login';
  }

  // Utility Methods
  formatDate(dateString) {
    return new Date(dateString).toLocaleDateString('vi-VN');
  }

  getGenderDisplay(gender) {
    const genderMap = {
      'male': '👨 Nam',
      'female': '👩 Nữ',
      'hidden': '❓ Chưa xác định',
      'other': '❓ Khác'
    };
    return genderMap[gender] || '-';
  }

  getRoleBadge(roleId) {
    if (roleId === 1) {
      return '<span class="badge badge-info">👨‍💼 Admin</span>';
    }
    return '<span class="badge badge-success">👤 User</span>';
  }

  getStatusBadge(isLocked) {
    if (isLocked) {
      return '<span class="badge badge-danger">🔒 Bị khóa</span>';
    }
    return '<span class="badge badge-success">✅ Hoạt động</span>';
  }
}

// Initialize on DOM load
let adminManager;
document.addEventListener('DOMContentLoaded', () => {
  adminManager = new AdminUserManager();
});