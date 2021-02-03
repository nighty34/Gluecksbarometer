import 'package:gluecks_barometer/src/model/entry.dart';
import 'package:sqflite/sqflite.dart';

import 'dao.dart';
import 'db.dart';

class EntryDao implements Dao<int, Entry> {
  final String _table = "entries";
  final String _activitiesTable = "entries_activities";

  @override
  Future<Entry> read(int id) {
    return readAll(filter: "id=?", args: [id]).then((results) => results.first);
  }

  @override
  Future<List<Entry>> readAll({String filter, List args}) async {
    Database conn = await DB().conn;
    List<Entry> entries = await conn
        .query(_table,
            where: filter, whereArgs: args) // TODO is a join feasible here?
        .then((maps) => List.of(maps.map((map) => Entry.fromMap(map))));

    for (Entry entry in entries) {
      entry.activities = await conn
          .query(_activitiesTable, where: "e_id=?", whereArgs: [entry.id]).then(
              (values) => List.of(values.map((value) => value["a_id"])));
    }

    return entries;
  }

  @override
  Future<int> insert(Entry value) async {
    Database conn = await DB().conn;
    int id = await conn.insert(_table, value.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    value.activities.forEach((activity) =>
        conn.insert(_activitiesTable, {"e_id": id, "a_id": activity}));
    return id;
  }

  @override
  update(Entry value) async {
    Database conn = await DB().conn;
    conn.update(_table, value.toMap(), where: "id=?", whereArgs: [value.id]);

    // reinsert activities corresponding to entry
    conn.delete(_activitiesTable, where: "e_id=?", whereArgs: [value.id]);
    value.activities.forEach((activity) =>
        conn.insert(_activitiesTable, {"e_id": value.id, "a_id": activity}));
  }

  @override
  delete(int id) async {
    Database conn = await DB().conn;
    conn.delete(_table, where: "id=?", whereArgs: [id]);
    conn.delete(_activitiesTable, where: "e_id=?", whereArgs: [id]);
  }
}
