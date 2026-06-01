// FILE: src/core/utils/logger.js
/**
 * Simple Logger Utility
 * Provides logging methods for development and production
 * In production, consider integrating with Winston or Pino
 */

const LOG_LEVELS = {
  DEBUG: 0,
  INFO: 1,
  WARN: 2,
  ERROR: 3,
};

const CURRENT_LOG_LEVEL = LOG_LEVELS[process.env.LOG_LEVEL || 'INFO'];

const timestamp = () => new Date().toISOString();

/**
 * Format log message
 */
const metaToString = (meta) => {
  if (!meta) return '';
  if (meta instanceof Error) return meta.stack || meta.message;
  if (typeof meta === 'string') return meta;
  try {
    return JSON.stringify(meta);
  } catch {
    return String(meta);
  }
};

const format = (level, message, meta = '') => {
  const metaStr = metaToString(meta);
  return `[${timestamp()}] [${level}] ${message}${metaStr ? ` ${metaStr}` : ''}`;
};

/**
 * Log debug message
 */
const debug = (message, meta = '') => {
  if (CURRENT_LOG_LEVEL <= LOG_LEVELS.DEBUG) {
    console.debug(format('DEBUG', message, meta));
  }
};

/**
 * Log info message
 */
const info = (message, meta = '') => {
  if (CURRENT_LOG_LEVEL <= LOG_LEVELS.INFO) {
    console.log(format('INFO', message, meta));
  }
};

/**
 * Log warning message
 */
const warn = (message, meta = '') => {
  if (CURRENT_LOG_LEVEL <= LOG_LEVELS.WARN) {
    console.warn(format('WARN', message, meta));
  }
};

/**
 * Log error message
 */
const error = (message, meta = '') => {
  if (CURRENT_LOG_LEVEL <= LOG_LEVELS.ERROR) {
    console.error(format('ERROR', message, meta));
  }
};

module.exports = {
  debug,
  info,
  warn,
  error,
  // Legacy methods for backward compatibility
  logInfo: info,
  logError: error,
};
