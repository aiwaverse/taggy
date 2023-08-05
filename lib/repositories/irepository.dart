abstract class IRepository<T> {
  Future<Iterable<T>> getAll();
  Future<T> insert(T entity);
  Future<bool> update(T entity);
  Future<bool> delete(T entity);
}
