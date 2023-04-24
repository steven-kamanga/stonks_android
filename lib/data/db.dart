import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Db {
  static const dbName = 'stonks.db';
  static const dbVersion = 0;
  static const addProfile = 'add_profile';

  Future<Database> initDb() async {
    String path = await getDatabasesPath();
    String addDb = '''
  CREATE TABLE IF NOT EXISTS $addProfile (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    market TEXT NOT NULL,
    email TEXT NOT NULL,
    password TEXT NOT NULL,
  );
  ''';
    return openDatabase(
      join(path, dbName),
      onCreate: (database, version) async {
        await database.execute(addDb);
      },
      version: dbVersion,
      onConfigure: _onConfigure,
    );
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }
}
