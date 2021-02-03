import 'package:gluecks_barometer/src/data/db.dart';
import 'package:gluecks_barometer/src/model/activity.dart';
import 'package:sqflite/sqflite.dart';

import 'dao.dart';

class ActivityDao implements Dao<int, Activity> {
  final String _table = "activities";

  @override
  Future<Activity> read(int id) {
    return readAll(filter: "id=?", args: [id]).then((results) => results.first);
  }

  @override
  Future<List<Activity>> readAll({String filter, List<dynamic> args}) {
    return DB().conn.then((c) => c
        .query(_table, where: filter, whereArgs: args)
        .then((maps) => List.of(maps.map((map) => Activity.fromMap(map)))));
  }

  @override
  Future<int> insert(Activity value) {
    return DB().conn.then((c) => c.insert(_table, value.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace));
  }

  @override
  update(Activity value) {
    DB().conn.then((c) =>
        c.update(_table, value.toMap(), where: "id=?", whereArgs: [value.id]));
  }

  @override
  delete(int id) {
    DB().conn.then((c) => c.delete(_table, where: "id=?", whereArgs: [id]));
  }
}
