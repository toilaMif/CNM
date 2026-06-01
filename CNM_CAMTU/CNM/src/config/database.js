const mysql = require('mysql2/promise');

const pool = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  port: process.env.DB_PORT,

  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
});

const connectDB = async (retry = 10) => {
  while (retry) {
    try {
      const conn = await pool.getConnection();
      console.log('✅ Connected to MySQL database');
      conn.release();
      return;
    } catch (err) {
      console.log(`❌ DB not ready. Retrying... (${retry})`);
      retry--;

      await new Promise(res => setTimeout(res, 3000));
    }
  }

  console.error('❌ DB connection failed after retries');
  process.exit(1);
};

module.exports = { pool, connectDB };