abstract class IRepository<T> {
  Future<Iterable<T>> getAll();
  Future<T> insert();
  Future<T> update();
  Future<bool> delete();
}
