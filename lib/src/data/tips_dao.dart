
import 'package:gluecks_barometer/src/model/quote.dart';
import 'package:sqflite/sqflite.dart';

import 'dao.dart';
import 'db.dart';

class TipsDao extends Dao<int, Quote> {

  static const _table = "tips";

  @override
  delete(int id) async {
    Database conn = await DB().conn;
    conn.delete(_table, where: "id=?", whereArgs: [id]);
  }

  @override
  Future<int> insert(Quote value) async {
    Database conn = await DB().conn;
    return conn.insert(_table, value.toMap());
  }

  @override
  Future<Quote> read(int id) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<List<Quote>> readAll({String filter, List args}) async {
    Database conn = await DB().conn;
    List<Map<String, dynamic>> quotes =
        await conn.query(_table, where: filter, whereArgs: args);
    return List.of(quotes.map((map) => Quote.fromMap(map)));
  }

  @override
  update(Quote value) async {
    Database conn = await DB().conn;
    conn.update(_table, value.toMap(), where: "id=?", whereArgs: [value.id]);
  }

}
