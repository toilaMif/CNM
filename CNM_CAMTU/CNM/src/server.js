require('dotenv').config();

const app = require('./app');
const logger = require('./core/utils/logger');
const aiAdvisorService = require('./modules/ai-advisor/ai-advisor.service');

const BASE_PORT = Number(process.env.PORT) || 3000;
const IS_PROD = process.env.NODE_ENV === 'production';
const AUTO_SYNC_EMBEDDINGS = process.env.AI_AUTO_SYNC_EMBEDDINGS !== 'false';

/* ================= START SERVER ================= */
let server;

function startServer(port, remainingRetries = 5) {
  server = app.listen(port, () => {
    logger.info(`🚀 Server running on port ${port}`);
    runAutoEmbeddingSync();
  });

  server.on('error', (err) => {
    if (err?.code === 'EADDRINUSE' && remainingRetries > 0) {
      const nextPort = port + 1;
      logger.warn(`Port ${port} is in use. Retrying on port ${nextPort}...`);
      startServer(nextPort, remainingRetries - 1);
      return;
    }

    logger.error('Server listen error:', err);

    if (IS_PROD) {
      process.exit(1);
    }
  });
}

function runAutoEmbeddingSync() {
  if (!AUTO_SYNC_EMBEDDINGS) {
    logger.info('AI embedding auto sync is disabled');
    return;
  }

  setTimeout(async () => {
    try {
      logger.info('Checking AI product embeddings...');
      const result = await aiAdvisorService.ensureProductEmbeddings();

      if (result.skipped) {
        logger.info(`AI embeddings ready (${result.total}/${result.productTotal})`);
        return;
      }

      logger.info(`AI embeddings synced: ${result.synced}/${result.total}, failed: ${result.failed}`);
    } catch (error) {
      logger.error('AI embedding auto sync failed:', error);
    }
  }, 3000);
}

startServer(BASE_PORT);

/* ================= HANDLE UNHANDLED ERRORS ================= */
process.on('unhandledRejection', (err) => {
  logger.error('Unhandled Rejection:', err);

  // In production, crash fast to avoid unknown state.
  // In development, keep the server alive so the stack trace is visible
  // and you can continue debugging.
  if (IS_PROD) {
    server.close(() => process.exit(1));
  }
});

process.on('uncaughtException', (err) => {
  logger.error('Uncaught Exception:', err);
  if (IS_PROD) {
    process.exit(1);
  }
});
