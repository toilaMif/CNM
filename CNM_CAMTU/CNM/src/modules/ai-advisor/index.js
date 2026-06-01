module.exports = {
  routes: require('./ai-advisor.routes'),
  service: require('./ai-advisor.service'),
  repository: require('./ai-advisor.repository'),
  embeddingService: require('./embedding.service')
};
