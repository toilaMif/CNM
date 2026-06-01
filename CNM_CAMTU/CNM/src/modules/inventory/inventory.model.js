const { DataTypes } = require('sequelize');
const sequelize = require('../../config/database');

const Inventory = sequelize.define('inventory', {
    InventoryID: { 
        type: DataTypes.INTEGER, 
        primaryKey: true, // Lưu ý: primaryKey (K viết hoa)
        autoIncrement: true 
    },
    ProductID: { 
        type: DataTypes.INTEGER, 
        allowNull: false 
    },
    Quantity: { 
        type: DataTypes.INTEGER, 
        defaultValue: 0,
        validate: { min: 0 } 
    },
    AllocatedQuantity: { // Cột mới để treo hàng
        type: DataTypes.INTEGER, 
        defaultValue: 0,
        validate: { min: 0 }
    },
    BatchNumber: { // Cột quan trọng cho FEFO
        type: DataTypes.STRING(255),
        allowNull: false
    },
    ExpiryDate: { // Cột quan trọng cho FEFO
        type: DataTypes.DATEONLY, // Chỉ lấy ngày YYYY-MM-DD
        allowNull: true
    },
    LocationRack: { 
        type: DataTypes.STRING(100),
        allowNull: true
    }
}, {
    tableName: 'inventory',
    timestamps: true,
    // Đảm bảo tên cột trong code map đúng với snake_case trong DB nếu bạn dùng underscore
    underscored: true 
});

// Định nghĩa hằng số cho Log
Inventory.LOG_TYPES = {
    IMPORT: 'IMPORT',
    EXPORT: 'EXPORT'
};

module.exports = Inventory;