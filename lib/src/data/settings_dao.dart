import 'package:gluecks_barometer/src/model/settings.dart';
import 'package:sqflite/sqflite.dart';

import 'dao.dart';
import 'db.dart';

class SettingsDao extends Dao<String, Settings> {

  final String _table = "settings";

  @override
  delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<int> insert(Settings value) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<Settings> read(String id) async {
    Database conn = await DB().conn;
    return conn.query(_table, where: "stype=?", whereArgs: [id]).then((maps) => Settings.fromMap(maps.first));
  }

  @override
  Future<List<Settings>> readAll({String filter, List args}) {
    // TODO: implement readAll
    throw UnimplementedError();
  }

  @override
  update(Settings value) async {
    Database conn = await DB().conn;
    conn.update(_table, value.toMap(), where: "stype=?", whereArgs: [value.stype]);
  }

}