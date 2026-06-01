const { pool } = require('../../config/database');

const paymentTermRepository = {
  /* =========================================================
     SALE GET ACTIVE TERMS
     Chỉ lấy chương trình được bật cho Sale chọn
  ========================================================= */
  async findAllActive() {
    const [rows] = await pool.execute(
      `
      SELECT 
        payment_term_template_id,
        term_name,
        description,
        image_url,
        banner_url,
        credit_days,
        early_commission_rate_per_day,
        late_interest_rate_per_day,
        is_active,
        display_on_home,
        visible_to_sale,
        display_order,
        target_audience,
        created_at,
        updated_at
      FROM payment_term_templates
      WHERE is_active = 1
        AND visible_to_sale = 1
      ORDER BY display_order ASC, credit_days ASC, payment_term_template_id DESC
      `
    );

    return rows;
  },

  /* =========================================================
     GET ALL
     Product Manager / Manager quản lý toàn bộ
  ========================================================= */
  async findAll() {
    const [rows] = await pool.execute(
      `
      SELECT 
        payment_term_template_id,
        term_name,
        description,
        image_url,
        banner_url,
        credit_days,
        early_commission_rate_per_day,
        late_interest_rate_per_day,
        is_active,
        display_on_home,
        visible_to_sale,
        display_order,
        target_audience,
        created_at,
        updated_at
      FROM payment_term_templates
      ORDER BY payment_term_template_id DESC
      `
    );

    return rows;
  },

  /* =========================================================
     HOME PROMOTIONS
     Chỉ lấy chương trình bật hiển thị trang Home
  ========================================================= */
  async findHomePromotions() {
    const [rows] = await pool.execute(
      `
      SELECT 
        payment_term_template_id,
        term_name,
        description,
        image_url,
        banner_url,
        credit_days,
        early_commission_rate_per_day,
        late_interest_rate_per_day,
        is_active,
        display_on_home,
        visible_to_sale,
        display_order,
        target_audience
      FROM payment_term_templates
      WHERE is_active = 1
        AND display_on_home = 1
        AND target_audience IN ('ALL', 'DEALER')
      ORDER BY display_order ASC, payment_term_template_id DESC
      LIMIT 8
      `
    );

    return rows;
  },

  /* =========================================================
     FIND BY ID
  ========================================================= */
  async findById(id) {
    const [rows] = await pool.execute(
      `
      SELECT 
        payment_term_template_id,
        term_name,
        description,
        image_url,
        banner_url,
        credit_days,
        early_commission_rate_per_day,
        late_interest_rate_per_day,
        is_active,
        display_on_home,
        visible_to_sale,
        display_order,
        target_audience,
        created_at,
        updated_at
      FROM payment_term_templates
      WHERE payment_term_template_id = ?
      LIMIT 1
      `,
      [id]
    );

    return rows[0] || null;
  },

  /* =========================================================
     CREATE
  ========================================================= */
  async create(payload) {
    const {
      term_name,
      description = null,
      image_url = null,
      banner_url = null,
      credit_days = 0,
      early_commission_rate_per_day = 0,
      late_interest_rate_per_day = 0,
      is_active = 1,
      display_on_home = 0,
      visible_to_sale = 1,
      display_order = 0,
      target_audience = 'DEALER'
    } = payload;

    const [result] = await pool.execute(
      `
      INSERT INTO payment_term_templates (
        term_name,
        description,
        image_url,
        banner_url,
        credit_days,
        early_commission_rate_per_day,
        late_interest_rate_per_day,
        is_active,
        display_on_home,
        visible_to_sale,
        display_order,
        target_audience,
        created_at,
        updated_at
      )
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())
      `,
      [
        term_name,
        description,
        image_url,
        banner_url,
        credit_days,
        early_commission_rate_per_day,
        late_interest_rate_per_day,
        is_active,
        display_on_home,
        visible_to_sale,
        display_order,
        target_audience
      ]
    );

    return this.findById(result.insertId);
  },

  /* =========================================================
     UPDATE
  ========================================================= */
  async update(id, payload) {
    const {
      term_name,
      description = null,
      image_url = null,
      banner_url = null,
      credit_days = 0,
      early_commission_rate_per_day = 0,
      late_interest_rate_per_day = 0,
      is_active = 1,
      display_on_home = 0,
      visible_to_sale = 1,
      display_order = 0,
      target_audience = 'DEALER'
    } = payload;

    await pool.execute(
      `
      UPDATE payment_term_templates
      SET term_name = ?,
          description = ?,
          image_url = ?,
          banner_url = ?,
          credit_days = ?,
          early_commission_rate_per_day = ?,
          late_interest_rate_per_day = ?,
          is_active = ?,
          display_on_home = ?,
          visible_to_sale = ?,
          display_order = ?,
          target_audience = ?,
          updated_at = NOW()
      WHERE payment_term_template_id = ?
      `,
      [
        term_name,
        description,
        image_url,
        banner_url,
        credit_days,
        early_commission_rate_per_day,
        late_interest_rate_per_day,
        is_active,
        display_on_home,
        visible_to_sale,
        display_order,
        target_audience,
        id
      ]
    );

    return this.findById(id);
  },

  /* =========================================================
     UPDATE STATUS ACTIVE
  ========================================================= */
  async updateStatus(id, isActive) {
    await pool.execute(
      `
      UPDATE payment_term_templates
      SET is_active = ?,
          updated_at = NOW()
      WHERE payment_term_template_id = ?
      `,
      [isActive, id]
    );

    return this.findById(id);
  },

  /* =========================================================
     UPDATE HOME DISPLAY
  ========================================================= */
  async updateHomeDisplay(id, payload) {
    const {
      display_on_home = 0,
      display_order = 0,
      target_audience = 'DEALER'
    } = payload;

    await pool.execute(
      `
      UPDATE payment_term_templates
      SET display_on_home = ?,
          display_order = ?,
          target_audience = ?,
          updated_at = NOW()
      WHERE payment_term_template_id = ?
      `,
      [
        display_on_home,
        display_order,
        target_audience,
        id
      ]
    );

    return this.findById(id);
  },

  /* =========================================================
     UPDATE SALE VISIBILITY
  ========================================================= */
  async updateSaleVisibility(id, visibleToSale) {
    await pool.execute(
      `
      UPDATE payment_term_templates
      SET visible_to_sale = ?,
          updated_at = NOW()
      WHERE payment_term_template_id = ?
      `,
      [visibleToSale, id]
    );

    return this.findById(id);
  },

  /* =========================================================
     DEACTIVATE
  ========================================================= */
  async deactivate(id) {
    await pool.execute(
      `
      UPDATE payment_term_templates
      SET is_active = 0,
          updated_at = NOW()
      WHERE payment_term_template_id = ?
      `,
      [id]
    );

    return this.findById(id);
  }
};

module.exports = paymentTermRepository;