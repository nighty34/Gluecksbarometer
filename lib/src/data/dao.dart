abstract class Dao<K, T> {
  Future<List<T>> readAll({String filter, List<dynamic> args});

  Future<T> read(K id);

  Future<int> insert(T value); // returns the id
  update(T value);

  delete(K id);
}
