class BaseService {
  constructor(repository) {
    this.repository = repository;
  }

  async findAll() {
    return this.repository.findAll();
  }

  async findById(id) {
    return this.repository.findById(id);
  }

  async create(payload) {
    return this.repository.create(payload);
  }

  async update(id, payload) {
    return this.repository.update(id, payload);
  }

  async delete(id) {
    return this.repository.delete(id);
  }
}

module.exports = BaseService;
