class BaseRepository {
  constructor(model) {
    this.model = model;
  }

  async findAll() {
    return this.model.findAll ? this.model.findAll() : [];
  }

  async findById(id) {
    return this.model.findById ? this.model.findById(id) : null;
  }

  async create(payload) {
    return this.model.create ? this.model.create(payload) : payload;
  }

  async update(id, payload) {
    return this.model.update ? this.model.update(id, payload) : null;
  }

  async delete(id) {
    return this.model.delete ? this.model.delete(id) : null;
  }
}

module.exports = BaseRepository;
