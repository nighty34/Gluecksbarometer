/// Data Access Object template
abstract class Dao<K, T> {

  /// Read all data.
  ///
  /// Optionally, an sql [filter] with [args] can be provided.
  Future<List<T>> readAll({String filter, List<dynamic> args});

  /// Read a data point given its id.
  Future<T> read(K id);

  /// Insert a value into the dataset. Returns the designated id.
  Future<int> insert(T value);

  /// Update a value in the dataset.
  ///
  /// It is assumed that value contains its id and can thus be identified.
  update(T value);

  /// Delete a data point given its id
  delete(K id);
}
