const aiAdvisorRepository = require('./ai-advisor.repository');
const embeddingService = require('./embedding.service');

const OLLAMA_BASE_URL = (process.env.OLLAMA_BASE_URL || 'http://localhost:11434').replace(/\/$/, '');
const OLLAMA_MODEL = process.env.OLLAMA_MODEL || 'qwen3.5:4b';
const OLLAMA_NUM_PREDICT = Number(process.env.OLLAMA_NUM_PREDICT || 300);
const MAX_HISTORY_MESSAGES = 10;
const MAX_CONTEXT_PRODUCTS = Number(process.env.AI_ADVISOR_CONTEXT_LIMIT || 5);
const KEYWORD_SCAN_LIMIT = Number(process.env.AI_ADVISOR_KEYWORD_SCAN_LIMIT || 500);

// Tú thêm: service chính cho pipeline AI advisor.
function createHttpError(message, statusCode = 400) {
  const error = new Error(message);
  error.statusCode = statusCode;
  return error;
}

// Tú thêm: chuẩn hóa lịch sử chat trước khi xử lý AI.
function normalizeMessages(message, messages = []) {
  const cleanMessages = Array.isArray(messages)
    ? messages
        .filter((item) => {
          return (
            item &&
            ['user', 'assistant'].includes(item.role) &&
            typeof item.content === 'string' &&
            item.content.trim()
          );
        })
        .map((item) => ({
          role: item.role,
          content: item.content.trim().slice(0, 4000)
        }))
        .slice(-MAX_HISTORY_MESSAGES)
    : [];

  if (!cleanMessages.length && typeof message === 'string' && message.trim()) {
    cleanMessages.push({
      role: 'user',
      content: message.trim().slice(0, 4000)
    });
  }

  if (!cleanMessages.length) {
    throw createHttpError('Vui lòng nhập nội dung cần hỏi AI', 400);
  }

  return cleanMessages;
}

function getLatestUserMessage(messages) {
  const latest = [...messages].reverse().find((item) => item.role === 'user');
  return latest?.content || '';
}

function getFollowUpSearch(messages) {
  const latestUserIndex = messages.map((item) => item.role).lastIndexOf('user');

  if (latestUserIndex <= 1) {
    return null;
  }

  const latestUserMessage = messages[latestUserIndex]?.content || '';
  const historyBeforeLatest = messages.slice(0, latestUserIndex);
  const previousAssistantIndex = historyBeforeLatest.map((item) => item.role).lastIndexOf('assistant');
  const previousUserIndex = historyBeforeLatest.map((item) => item.role).lastIndexOf('user');

  if (previousAssistantIndex === -1 || previousUserIndex === -1 || previousAssistantIndex < previousUserIndex) {
    return null;
  }

  const previousAssistant = historyBeforeLatest[previousAssistantIndex];
  const previousUser = historyBeforeLatest[previousUserIndex];

  const assistantText = normalizeSearchText(previousAssistant.content);
  const latestText = normalizeSearchText(latestUserMessage);

  const askedClarification =
    assistantText.includes('cay') ||
    assistantText.includes('trieu chung') ||
    assistantText.includes('muc dich') ||
    assistantText.includes('nhu cau') ||
    assistantText.includes('sau benh');

  const isShortAnswer = latestText.split(' ').filter(Boolean).length <= 6;

  if (!askedClarification || !isShortAnswer) {
    return null;
  }

  const customerNeed = `${previousUser.content}. Thông tin bổ sung: ${latestUserMessage}`;

  return {
    searchQuery: customerNeed,
    customerNeed,
    needsClarification: false,
    clarificationQuestion: null
  };
}

function getSpecificQuestion(message) {
  const normalized = normalizeSearchText(message);

  if (!normalized) {
    return null;
  }

  const hasProblem = /\b(bi|tri|phong|diet|ray|rep|sau|benh|nam|vang|dom|thoi|chay|lem|he|la|qua|trai|re|than)\b/.test(normalized);
  const hasCrop = /\b(cay|lua|xoai|ot|ca chua|nho|dua|sau rieng|mang cau|rau|hoa|lan)\b/.test(normalized);

  if (!hasProblem && !hasCrop) {
    return null;
  }

  return {
    searchQuery: message,
    customerNeed: message,
    needsClarification: false,
    clarificationQuestion: null
  };
}

function getBroadShoppingClarification(message) {
  const normalized = normalizeSearchText(message);

  if (!normalized) {
    return null;
  }

  const core = normalized
    .replace(/\b(xin|chao|hello|hi|toi|tui|minh|em|anh|chi|muon|can|mua|tim|kiem|tu|van|giup|shop|ban|cho|co|khong|san|pham|loai|nao|vay|nha|a|oi)\b/g, ' ')
    .replace(/\s+/g, ' ')
    .trim();

  const tokens = core ? core.split(' ') : [];
  const broadTokens = new Set([
    'phan',
    'bon',
    'thuoc',
    'bvtv',
    'bao',
    've',
    'thuc',
    'vat',
    'sau',
    'benh',
    'nong',
    'nghiep'
  ]);

  if (!tokens.length || !tokens.every((token) => broadTokens.has(token))) {
    return null;
  }

  if (core.includes('phan') && core.includes('bon')) {
    return 'Bạn muốn mua phân bón cho cây gì và mục đích nào: ra rễ, ra hoa, nuôi trái, bổ sung vi lượng hay cải tạo đất? Cho mình thêm 1-2 ý để gợi ý đúng sản phẩm hơn nha.';
  }

  if (core.includes('thuoc') || core.includes('bvtv')) {
    return 'Bạn cần thuốc BVTV cho cây gì và đang gặp sâu, bệnh hay triệu chứng nào? Nói thêm cây trồng và vấn đề đang gặp để mình lọc sản phẩm phù hợp hơn nha.';
  }

  return 'Bạn muốn tìm sản phẩm cho cây gì, mục đích sử dụng nào và khoảng giá ra sao? Mình cần thêm chút thông tin để gợi ý đúng hơn.';
}

// Tú thêm: gọi Ollama chat dùng chung cho bước làm rõ và bước trả lời.
async function callOllamaChat(messages, options = {}) {
  const response = await fetch(`${OLLAMA_BASE_URL}/api/chat`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      model: OLLAMA_MODEL,
      stream: false,
      think: false,
      messages,
      options: {
        temperature: options.temperature ?? 0.2,
        num_predict: options.numPredict || OLLAMA_NUM_PREDICT
      }
    })
  });

  const data = await response.json().catch(() => ({}));

  if (!response.ok) {
    const message = data.error || data.message || 'Không gọi được Ollama';
    throw createHttpError(message, response.status);
  }

  const reply = data?.message?.content?.trim();

  if (!reply) {
    throw new Error('Ollama không trả về nội dung phản hồi');
  }

  return {
    reply,
    model: data.model || OLLAMA_MODEL
  };
}

function extractJsonObject(text) {
  if (!text) {
    return null;
  }

  const fenced = text.match(/```(?:json)?\s*([\s\S]*?)```/i);
  const source = fenced ? fenced[1] : text;
  const start = source.indexOf('{');
  const end = source.lastIndexOf('}');

  if (start === -1 || end === -1 || end <= start) {
    return null;
  }

  try {
    return JSON.parse(source.slice(start, end + 1));
  } catch (error) {
    return null;
  }
}

// Tú thêm: bước 2 pipeline - LLM làm rõ câu hỏi thành searchQuery.
async function clarifyQuestion(messages) {
  const latestUserMessage = getLatestUserMessage(messages);
  const conversation = messages
    .slice(-6)
    .map((item) => `${item.role}: ${item.content}`)
    .join('\n');

  try {
    const { reply } = await callOllamaChat(
      [
        {
          role: 'system',
          content: [
            'Bạn là bộ phận làm rõ câu hỏi cho shop nông nghiệp.',
            'Nhiệm vụ: chuyển đoạn chat thành truy vấn tìm sản phẩm/dữ liệu trong database.',
            'Chỉ trả JSON hợp lệ, không markdown.',
            'Schema: {"searchQuery":"string","customerNeed":"string","needsClarification":boolean,"clarificationQuestion":string|null}.',
            'needsClarification true khi khách chỉ nói chung chung như muốn mua phân bón, thuốc BVTV hoặc sản phẩm nông nghiệp nhưng chưa nêu cây trồng, triệu chứng, mục đích sử dụng, loại sản phẩm hoặc khoảng giá.',
            'Nếu needsClarification true, hỏi lại ngắn gọn bằng tiếng Việt để lấy thêm cây trồng và nhu cầu.'
          ].join(' ')
        },
        {
          role: 'user',
          content: `Đoạn chat gần nhất:\n${conversation}`
        }
      ],
      {
        temperature: 0,
        numPredict: 180
      }
    );

    const parsed = extractJsonObject(reply);

    if (!parsed) {
      throw new Error('LLM did not return valid preprocessing JSON');
    }

    const searchQuery = String(parsed.searchQuery || '').trim();
    const customerNeed = String(parsed.customerNeed || searchQuery || latestUserMessage).trim();
    const clarificationQuestion = parsed.clarificationQuestion
      ? String(parsed.clarificationQuestion).trim()
      : null;

    return {
      searchQuery: searchQuery || latestUserMessage,
      customerNeed: customerNeed || latestUserMessage,
      needsClarification: Boolean(parsed.needsClarification && clarificationQuestion),
      clarificationQuestion
    };
  } catch (error) {
    throw createHttpError('AgroBot hiện chưa thể phản hồi. Vui lòng thử lại sau.', 503);
  }
}

function removeVietnameseTones(value = '') {
  return String(value)
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/đ/g, 'd')
    .replace(/Đ/g, 'D');
}

function normalizeSearchText(value = '') {
  return removeVietnameseTones(value)
    .toLowerCase()
    .replace(/[^a-z0-9\s.-]/g, ' ')
    .replace(/\s+/g, ' ')
    .trim();
}

function getSearchTerms(query) {
  const normalized = normalizeSearchText(query);

  if (!normalized) {
    return [];
  }

  return [
    ...new Set(
      normalized
        .split(' ')
        .map((term) => term.trim())
        .filter((term) => term.length >= 2)
    )
  ].slice(0, 10);
}

function productText(row, fields) {
  return fields
    .map((field) => row[field])
    .filter((value) => value !== undefined && value !== null && value !== '')
    .join(' ');
}

function normalizeAssistantReply(reply) {
  return String(reply || '')
    .replace(/\r\n/g, '\n')
    .replace(/\s+#{1,6}\s*(?=\d+[.)])/g, '\n')
    .replace(/^\s{0,3}#{1,6}\s*/gm, '')
    .replace(/\*\*([^*]+)\*\*/g, '$1')
    .replace(/\s+\*\s*/g, ' ')
    .replace(/[ \t]{2,}/g, ' ')
    .trim();
}

// Tú thêm: fallback keyword search khi chưa có embedding hoặc Ollama embedding lỗi.
function scoreProductByKeyword(row, query) {
  const normalizedQuery = normalizeSearchText(query);
  const terms = getSearchTerms(query);

  if (!normalizedQuery || !terms.length) {
    return 0;
  }

  const nameText = normalizeSearchText(productText(row, ['ProductName']));
  const skuText = normalizeSearchText(productText(row, ['SKU']));
  const taxonomyText = normalizeSearchText(
    productText(row, [
      'CategoryName',
      'Brand',
      'PesticideName',
      'CropNames',
      'PestNames',
      'ToxicLevels'
    ])
  );
  const detailText = normalizeSearchText(
    productText(row, [
      'Description',
      'TechnicalContent',
      'UsageInstructions',
      'PesticideDescription',
      'Dosage',
      'Method',
      'SafetyWarning',
      'Precaution'
    ])
  );
  const allText = `${nameText} ${skuText} ${taxonomyText} ${detailText}`;

  let score = 0;

  if (nameText.includes(normalizedQuery)) score += 35;
  if (skuText.includes(normalizedQuery)) score += 30;
  if (taxonomyText.includes(normalizedQuery)) score += 20;
  if (detailText.includes(normalizedQuery)) score += 12;

  for (const term of terms) {
    if (nameText.includes(term)) score += 8;
    if (skuText.includes(term)) score += 8;
    if (taxonomyText.includes(term)) score += 5;
    if (detailText.includes(term)) score += 2;
  }

  if (!score && allText.includes(normalizedQuery)) {
    score = 5;
  }

  return score;
}

// Tú thêm: gom dữ liệu sản phẩm thành text để tạo embedding.
function buildProductContent(row) {
  const lines = [
    `Ten san pham: ${row.ProductName}`,
    row.SKU ? `SKU: ${row.SKU}` : null,
    row.CategoryName ? `Danh muc: ${row.CategoryName}` : null,
    row.Price !== null && row.Price !== undefined ? `Gia: ${row.Price}` : null,
    row.UnitName ? `Don vi: ${row.UnitName}` : null,
    row.Brand ? `Thuong hieu: ${row.Brand}` : null,
    row.OriginCountry ? `Xuat xu: ${row.OriginCountry}` : null,
    row.Weight ? `Khoi luong: ${row.Weight}` : null,
    row.Description ? `Mo ta: ${row.Description}` : null,
    row.TechnicalContent ? `Thong tin ky thuat: ${row.TechnicalContent}` : null,
    row.UsageInstructions ? `Huong dan su dung: ${row.UsageInstructions}` : null,
    row.AvailableQuantity !== null && row.AvailableQuantity !== undefined
      ? `Ton kha dung: ${row.AvailableQuantity}`
      : null,
    row.PesticideName ? `Thuoc BVTV: ${row.PesticideName}` : null,
    row.PesticideDescription ? `Mo ta thuoc: ${row.PesticideDescription}` : null,
    row.Dosage ? `Lieu luong: ${row.Dosage}` : null,
    row.Method ? `Cach dung: ${row.Method}` : null,
    row.UseTime ? `Thoi diem dung: ${row.UseTime}` : null,
    row.HarvestInterval ? `Thoi gian cach ly: ${row.HarvestInterval}` : null,
    row.SafetyWarning ? `Canh bao an toan: ${row.SafetyWarning}` : null,
    row.Precaution ? `Luu y: ${row.Precaution}` : null,
    row.CropNames ? `Cay trong phu hop: ${row.CropNames}` : null,
    row.PestNames ? `Sau benh/dich hai: ${row.PestNames}` : null,
    row.ToxicLevels ? `Muc doc: ${row.ToxicLevels}` : null
  ];

  return lines.filter(Boolean).join('\n').slice(0, 12000);
}

// Tú thêm: format dữ liệu thật của shop thành JSON đưa cho LLM trả lời.
function formatProductForPrompt(row) {
  return {
    ProductID: row.ProductID,
    ProductName: row.ProductName,
    SKU: row.SKU,
    Slug: row.Slug,
    CategoryName: row.CategoryName,
    Price: row.Price,
    UnitName: row.UnitName,
    Brand: row.Brand,
    OriginCountry: row.OriginCountry,
    Weight: row.Weight,
    Description: row.Description,
    TechnicalContent: row.TechnicalContent,
    UsageInstructions: row.UsageInstructions,
    Inventory: {
      Quantity: row.Quantity,
      AvailableQuantity: row.AvailableQuantity,
      AllocatedQuantity: row.AllocatedQuantity,
      MinStockLevel: row.MinStockLevel,
      LocationRacks: row.LocationRacks,
      BatchNumbers: row.BatchNumbers,
      NearestExpiryDate: row.NearestExpiryDate
    },
    Pesticide: row.PesticideName
      ? {
          Name: row.PesticideName,
          Description: row.PesticideDescription,
          Dosage: row.Dosage,
          Method: row.Method,
          UseTime: row.UseTime,
          HarvestInterval: row.HarvestInterval,
          SafetyWarning: row.SafetyWarning,
          Precaution: row.Precaution,
          CropNames: row.CropNames,
          PestNames: row.PestNames,
          ToxicLevels: row.ToxicLevels
        }
      : null,
    Match: {
      score: row.matchScore || null,
      type: row.matchType || null
    }
  };
}

function summarizeSource(row) {
  return {
    ProductID: row.ProductID,
    ProductName: row.ProductName,
    SKU: row.SKU,
    Price: row.Price,
    ImageURL: row.ImageURL,
    UnitName: row.UnitName,
    CategoryName: row.CategoryName,
    AvailableQuantity: row.AvailableQuantity,
    matchScore: row.matchScore || null,
    matchType: row.matchType || null
  };
}

// Tú thêm: tìm sản phẩm liên quan bằng embedding đã lưu trong MySQL.
async function searchByEmbeddings(searchQuery, limit) {
  const queryEmbedding = await embeddingService.embedText(searchQuery);
  const storedRows = await aiAdvisorRepository.findStoredEmbeddings();

  if (!storedRows.length) {
    return {
      items: [],
      usedEmbeddings: false,
      reason: 'EMPTY_EMBEDDINGS'
    };
  }

  const scoredRows = storedRows
    .map((row) => ({
      ProductID: row.ProductID,
      score: embeddingService.cosineSimilarity(queryEmbedding, row.embedding)
    }))
    .filter((row) => row.score > 0)
    .sort((a, b) => b.score - a.score)
    .slice(0, limit);

  const products = await aiAdvisorRepository.findProductsByIds(
    scoredRows.map((row) => row.ProductID)
  );

  const scoreMap = new Map(scoredRows.map((row) => [row.ProductID, row.score]));

  return {
    items: products.map((product) => ({
      ...product,
      matchScore: Number(scoreMap.get(product.ProductID)?.toFixed(4)) || null,
      matchType: 'embedding'
    })),
    usedEmbeddings: true,
    reason: null
  };
}

async function searchByKeyword(searchQuery, limit) {
  const products = await aiAdvisorRepository.findProductsForAi({
    limit: KEYWORD_SCAN_LIMIT
  });

  return products
    .map((product) => ({
      ...product,
      matchScore: scoreProductByKeyword(product, searchQuery),
      matchType: 'keyword'
    }))
    .filter((product) => product.matchScore > 0)
    .sort((a, b) => b.matchScore - a.matchScore)
    .slice(0, limit);
}

function mergeSearchResults(embeddingItems, keywordItems, limit) {
  const map = new Map();

  for (const item of embeddingItems) {
    map.set(item.ProductID, item);
  }

  for (const item of keywordItems) {
    const existing = map.get(item.ProductID);

    if (!existing) {
      map.set(item.ProductID, item);
      continue;
    }

    map.set(item.ProductID, {
      ...existing,
      matchScore: Number(((existing.matchScore || 0) + (item.matchScore || 0) / 100).toFixed(4)),
      matchType: `${existing.matchType}+keyword`
    });
  }

  return [...map.values()]
    .sort((a, b) => (b.matchScore || 0) - (a.matchScore || 0))
    .slice(0, limit);
}

// Tú thêm: kết hợp embedding search và keyword search để lấy vài dòng phù hợp nhất.
async function findRelevantProducts(searchQuery, limit = MAX_CONTEXT_PRODUCTS) {
  let embeddingResult = {
    items: [],
    usedEmbeddings: false,
    reason: null
  };
  let embeddingError = null;

  try {
    embeddingResult = await searchByEmbeddings(searchQuery, limit);
  } catch (error) {
    embeddingError = {
      message: error.message,
      code: error.code || error.statusCode || null
    };
  }

  const keywordItems = await searchByKeyword(searchQuery, limit);
  const items = mergeSearchResults(embeddingResult.items, keywordItems, limit);

  return {
    items,
    meta: {
      usedEmbeddings: embeddingResult.usedEmbeddings,
      embeddingReason: embeddingResult.reason,
      embeddingError,
      keywordCount: keywordItems.length
    }
  };
}

// Tú thêm: bước 6 pipeline - LLM chỉ trả lời dựa trên SHOP_DATA_JSON.
async function answerFromProducts({ messages, clarifiedQuestion, products }) {
  const recentConversation = messages
    .slice(-6)
    .map((item) => `${item.role}: ${item.content}`)
    .join('\n');

  if (!products.length) {
    return {
      reply: [
        'Sản phẩm phù hợp hiện chưa được tìm thấy.',
        'Bạn vui lòng mô tả rõ hơn về loại cây trồng, triệu chứng, thời gian xuất hiện và điều kiện chăm sóc.'
      ].join(' '),
      model: OLLAMA_MODEL
    };
  }

  if (!products.length) {
    return {
      reply: [
        'Mình chưa tìm thấy sản phẩm phù hợp trong dữ liệu hiện có của shop.',
        'Bạn có thể nói rõ cây trồng, loại sâu bệnh, mục đích dùng hoặc khoảng giá để mình tìm chính xác hơn.'
      ].join(' '),
      model: OLLAMA_MODEL
    };
  }

  const answer = await callOllamaChat(
    [
      {
        role: 'system',
        content: [
          'Bạn là trợ lý AI tư vấn sản phẩm cho AgroShop.',
          'Chỉ được trả lời dựa trên SHOP_DATA_JSON do hệ thống cung cấp.',
          'Không tự bịa sản phẩm, giá, tồn kho, liều dùng, công dụng hoặc thông tin không có trong dữ liệu.',
          'Nếu dữ liệu thiếu, nói rõ là shop chưa có đủ thông tin.',
          'Trả lời bằng tiếng Việt, thân thiện, ngắn gọn và có tính tư vấn.',
          'Không nhắc đến SHOP_DATA_JSON, database hoặc dữ liệu nội bộ trong câu trả lời.',
          'Không dùng Markdown, không dùng ký tự ### hoặc **. Viết tối đa 3 ý ngắn, mỗi ý rõ ràng.',
          'Nếu tư vấn thuốc BVTV, nhắc khách đọc nhãn và tuân thủ an toàn sử dụng.'
        ].join(' ')
      },
      {
        role: 'user',
        content: [
          `CHAT_CONTEXT:\n${recentConversation}`,
          `CAU_HOI_DA_LAM_RO: ${clarifiedQuestion.customerNeed}`,
          `TRUY_VAN_TIM_KIEM: ${clarifiedQuestion.searchQuery}`,
          `SHOP_DATA_JSON:\n${JSON.stringify(products.map(formatProductForPrompt), null, 2)}`,
          'Hay tra loi dua tren SHOP_DATA_JSON. Khong dung Markdown. Neu cau hoi con chung chung, hoi them thong tin truoc. Neu goi y san pham, neu ten, gia, ton kho neu co trong JSON.'
        ].join('\n\n')
      }
    ],
    {
      temperature: 0.2,
      numPredict: OLLAMA_NUM_PREDICT
    }
  );

  return {
    ...answer,
    reply: normalizeAssistantReply(answer.reply)
  };
}

// Tú thêm: public method cho POST /api/ai-advisor/chat.
async function chat({ message, messages }) {
  const cleanMessages = normalizeMessages(message, messages);
  const clarifiedQuestion = await clarifyQuestion(cleanMessages);

  if (clarifiedQuestion.needsClarification) {
    return {
      reply: clarifiedQuestion.clarificationQuestion,
      model: OLLAMA_MODEL,
      needsClarification: true,
      searchQuery: clarifiedQuestion.searchQuery,
      sources: []
    };
  }

  const searchResult = await findRelevantProducts(
    clarifiedQuestion.searchQuery,
    MAX_CONTEXT_PRODUCTS
  );

  const answer = await answerFromProducts({
    messages: cleanMessages,
    clarifiedQuestion,
    products: searchResult.items
  });

  return {
    reply: answer.reply,
    model: answer.model,
    needsClarification: false,
    searchQuery: clarifiedQuestion.searchQuery,
    customerNeed: clarifiedQuestion.customerNeed,
    sources: searchResult.items.map(summarizeSource),
    retrieval: searchResult.meta
  };
}

// Tú thêm: public method đồng bộ bảng product_embeddings từ dữ liệu sản phẩm.
async function syncProductEmbeddings({ productId = null, limit = null } = {}) {
  await aiAdvisorRepository.ensureEmbeddingTable();

  const products = await aiAdvisorRepository.findProductsForAi({
    productId,
    limit
  });

  const result = {
    total: products.length,
    synced: 0,
    failed: 0,
    model: embeddingService.getEmbeddingModel(),
    errors: []
  };

  for (const product of products) {
    try {
      const content = buildProductContent(product);
      const embedding = await embeddingService.embedText(content);

      await aiAdvisorRepository.upsertProductEmbedding(
        product.ProductID,
        content,
        embedding,
        result.model
      );

      result.synced += 1;
    } catch (error) {
      result.failed += 1;
      result.errors.push({
        ProductID: product.ProductID,
        ProductName: product.ProductName,
        message: error.message
      });
    }
  }

  return result;
}

// Tú thêm: public method kiểm tra số embedding đã lưu.
async function getEmbeddingStats() {
  await aiAdvisorRepository.ensureEmbeddingTable();

  const products = await aiAdvisorRepository.findProductsForAi();
  const total = await aiAdvisorRepository.countEmbeddings();

  return {
    total,
    productTotal: products.length,
    missing: Math.max(products.length - total, 0),
    ready: total >= products.length,
    model: embeddingService.getEmbeddingModel()
  };
}

async function ensureProductEmbeddings() {
  await aiAdvisorRepository.ensureEmbeddingTable();

  const products = await aiAdvisorRepository.findProductsForAi();
  const total = await aiAdvisorRepository.countEmbeddings();

  if (total >= products.length) {
    return {
      skipped: true,
      reason: 'EMBEDDINGS_READY',
      total,
      productTotal: products.length,
      model: embeddingService.getEmbeddingModel()
    };
  }

  const result = await syncProductEmbeddings();

  return {
    skipped: false,
    beforeTotal: total,
    productTotal: products.length,
    ...result
  };
}

module.exports = {
  chat,
  syncProductEmbeddings,
  getEmbeddingStats,
  ensureProductEmbeddings
};
