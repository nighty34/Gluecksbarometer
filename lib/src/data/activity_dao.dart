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
  Future<List<Activity>> readAll({String filter, List<dynamic> args}) async {
    Database conn = await DB().conn;
    List<Map<String, dynamic>> activities =
        await conn.query(_table, where: filter, whereArgs: args);
    return List.of(activities.map((map) => Activity.fromMap(map)));
  }

  @override
  Future<int> insert(Activity value) async {
    Database conn = await DB().conn;
    return conn.insert(_table, value.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  update(Activity value) async {
    Database conn = await DB().conn;
    conn.update(_table, value.toMap(), where: "id=?", whereArgs: [value.id]);
  }

  @override
  delete(int id) async {
    Database conn = await DB().conn;
    conn.delete(_table, where: "id=?", whereArgs: [id]);
  }
}
