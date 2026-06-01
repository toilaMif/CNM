const OLLAMA_BASE_URL = (process.env.OLLAMA_BASE_URL || 'http://localhost:11434').replace(/\/$/, '');
const OLLAMA_EMBEDDING_MODEL = process.env.OLLAMA_EMBEDDING_MODEL || 'nomic-embed-text';

// Tú thêm: service gọi Ollama để tạo vector embedding cho câu hỏi và sản phẩm.
function normalizeVector(values) {
  if (!Array.isArray(values)) {
    return [];
  }

  return values
    .map(Number)
    .filter(Number.isFinite);
}

// Tú thêm: hỗ trợ cả response cũ /api/embeddings và mới /api/embed của Ollama.
function extractEmbedding(data) {
  if (Array.isArray(data?.embedding)) {
    return normalizeVector(data.embedding);
  }

  if (Array.isArray(data?.embeddings?.[0])) {
    return normalizeVector(data.embeddings[0]);
  }

  if (Array.isArray(data?.data?.[0]?.embedding)) {
    return normalizeVector(data.data[0].embedding);
  }

  return [];
}

async function postJson(path, body) {
  const response = await fetch(`${OLLAMA_BASE_URL}${path}`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(body)
  });

  const data = await response.json().catch(() => ({}));

  if (!response.ok) {
    const error = new Error(data.error || data.message || `Ollama request failed: ${path}`);
    error.statusCode = response.status;
    error.data = data;
    throw error;
  }

  return data;
}

// Tú thêm: tạo embedding text bằng model cấu hình trong .env.
async function embedText(text) {
  const input = String(text || '').trim();

  if (!input) {
    const error = new Error('Missing text for embedding');
    error.statusCode = 400;
    throw error;
  }

  let primaryError = null;

  try {
    const data = await postJson('/api/embeddings', {
      model: OLLAMA_EMBEDDING_MODEL,
      prompt: input
    });

    const embedding = extractEmbedding(data);

    if (embedding.length) {
      return embedding;
    }
  } catch (error) {
    primaryError = error;
  }

  try {
    const data = await postJson('/api/embed', {
      model: OLLAMA_EMBEDDING_MODEL,
      input
    });

    const embedding = extractEmbedding(data);

    if (embedding.length) {
      return embedding;
    }
  } catch (error) {
    if (primaryError) {
      error.primaryError = primaryError;
    }

    throw error;
  }

  throw new Error('Ollama did not return an embedding vector');
}

// Tú thêm: tính độ giống nhau giữa embedding câu hỏi và embedding sản phẩm.
function cosineSimilarity(left, right) {
  const a = normalizeVector(left);
  const b = normalizeVector(right);
  const length = Math.min(a.length, b.length);

  if (!length) {
    return 0;
  }

  let dot = 0;
  let normA = 0;
  let normB = 0;

  for (let index = 0; index < length; index += 1) {
    dot += a[index] * b[index];
    normA += a[index] * a[index];
    normB += b[index] * b[index];
  }

  if (!normA || !normB) {
    return 0;
  }

  return dot / (Math.sqrt(normA) * Math.sqrt(normB));
}

module.exports = {
  embedText,
  cosineSimilarity,
  getEmbeddingModel: () => OLLAMA_EMBEDDING_MODEL
};
