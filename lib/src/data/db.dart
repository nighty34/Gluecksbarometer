import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  Future<Database> _conn;

  DB._constructor() {
    _conn = _connect();
  }

  static final DB _instance = DB._constructor();

  factory DB() {
    return _instance;
  }

  Future<Database> _connect() async {
    WidgetsFlutterBinding.ensureInitialized();
    return openDatabase(
      join(await getDatabasesPath(), "user.db"),
      onCreate: (db, _) => _setup(db),
      version: 1,
    );
  }

  _setup(Database db) {
    // TODO use sql file or other
    db.execute(
        "CREATE TABLE activities(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, iconSrc TEXT)");
    db.execute(
        "CREATE TABLE entries(id INTEGER PRIMARY KEY AUTOINCREMENT, entryDate DATETIME, mood INTEGER, productivity INTEGER)");
    db.execute(
        "CREATE TABLE entries_activities(e_id INTEGER REFERENCES entries(id), a_id INTEGER REFERENCES activities(id), PRIMARY KEY (e_id, a_id))");
  }

  Future<Database> get conn async => await _conn;
}
