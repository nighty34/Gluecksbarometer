import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {

  // there does not seem to be any good web api for requesting german motivational quotes.
  // The only one I could find was paperquotes.com, but it provided english quotes regardless of
  // the language requested, despite it saying that it supported english, german and 13 other languages.
  // So this is the solution I've settled with (I'm sorry).
  // I have these quotes from https://www.ausdauerblog.de/zitate-motivation/
  static final List<String> quotes = [
    "Unbekannt", "Es ist nicht wichtig, wie groß der erste Schritt ist, sondern in welche Richtung er geht.",
    "Marquise du Deffand", "Die Entfernung ist unwichtig. Nur der erste Schritt ist wichtig.",
    "Publilius Syrus", "Niemand weiß, was er kann, bis er es probiert hat.",
    "Michael Jordan", "Ich kann Versagen akzeptieren, keiner ist perfekt. Aber was ich nicht akzeptieren kann ist, es nicht zu versuchen.",
    "Olin Miller", "Wenn Du willst, dass Dir eine leichte Aufgabe richtig schwer erscheint, schieb sie einfach auf.",
    "Unbekannt", "Der Unterschied zwischen dem, der du bist und dem, der du sein möchtest, ist das was du tust.",
    "Unbekannt", "Es spielt kein Rolle, woher du kommst. Alles was zählt ist, wohin du gehst.",
    "Henry Ford", "Es gibt mehr Leute, die kapitulieren, als solche, die scheitern.",
    "Marie von Ebner-Eschenbach", "Nenne dich nicht arm, weil deine Träume nicht in Erfüllung gegangen sind; wirklich arm ist nur, der nie geträumt hat.",
    "chin. Sprichwort", "Achte auf deine Gedanken! Sie sind der Anfang deiner Taten.",
    "Francois Truffaut", "Man kann niemanden überholen, wenn man in seine Fußstapfen tritt.",
    "Unbekannt", "Versuch nicht besser zu sein als andere. Versuche besser zu sein als Du gestern warst.",
  ];

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
    print("Init DB");
    // TODO use sql file or other
    db.execute("CREATE TABLE activities(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, iconSrc TEXT)");
    db.execute("CREATE TABLE entries(id INTEGER PRIMARY KEY AUTOINCREMENT, entryDate DATETIME, mood INTEGER, productivity INTEGER)");
    db.execute("CREATE TABLE entries_activities(e_id INTEGER REFERENCES entries(id), a_id INTEGER REFERENCES activities(id), PRIMARY KEY (e_id, a_id))");
    db.execute("CREATE TABLE settings(stype TEXT PRIMARY KEY, name TEXT, themeType INTEGER, tipsEnabled INTEGER, reminderEnabled INTEGER, reminderTime DATETIME)");
    db.execute("CREATE TABLE tips(id INTEGER PRIMARY KEY AUTOINCREMENT, text TEXT, author TEXT, shown DATETIME, saved INTEGER)");

    db.execute("INSERT INTO settings VALUES ('default', 'Mensch', 0, 1, 1, '${DateTime(1970, 1, 1, 19)}')");
    db.execute("INSERT INTO settings VALUES ('user', 'Mensch', 0, 1, 1, '${DateTime(1970, 1, 1, 19)}')");

    // save all predefined quotes
    for (int i = 0; i < quotes.length; i += 2) {
      db.execute("INSERT INTO tips VALUES (${(i/2).ceil().toString()}, '${quotes[i+1]}', '${quotes[i]}', '${DateTime(1970)}', 0)");
    }
  }

  Future<Database> get conn async => await _conn;
}
