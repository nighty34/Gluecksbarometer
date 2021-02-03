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
    List<Entry> entries = await DB().conn.then((c) => c
        .query(_table,
            where: filter, whereArgs: args) // TODO is a join feasible here?
        .then((maps) => List.of(maps.map((map) => Entry.fromMap(map)))));

    for (Entry entry in entries) {
      entry.activities = await DB().conn.then((c) => c
          .query(_activitiesTable, where: "e_id=?", whereArgs: [entry.id]).then(
              (values) => List.of(values.map((value) => value["a_id"]))));
    }

    return entries;
  }

  @override
  Future<int> insert(Entry value) {
    Future<int> id = DB().conn.then((c) => c.insert(_table, value.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace));
    id.then((_id) => value.activities.forEach((activity) => DB().conn.then(
        (c) => c.insert(_activitiesTable, {"e_id": _id, "a_id": activity}))));
    return id;
  }

  @override
  update(Entry value) {
    DB().conn.then((c) =>
        c.update(_table, value.toMap(), where: "id=?", whereArgs: [value.id]));

    // reinsert activities corresponding to entry
    DB().conn.then((c) =>
        c.delete(_activitiesTable, where: "e_id=?", whereArgs: [value.id]));
    value.activities.forEach((activity) => DB().conn.then((c) =>
        c.insert(_activitiesTable, {"e_id": value.id, "a_id": activity})));
  }

  @override
  delete(int id) {
    DB().conn.then((c) => c.delete(_table, where: "id=?", whereArgs: [id]));
    DB().conn.then(
        (c) => c.delete(_activitiesTable, where: "e_id=?", whereArgs: [id]));
  }
}
