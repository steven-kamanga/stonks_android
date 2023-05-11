import 'dart:async';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/model.dart';

class ProfileDatabase {
  static final ProfileDatabase instance = ProfileDatabase._init();

  static Database? _database;

  ProfileDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('profiles.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const profileSql = '''
  CREATE TABLE profiles (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    markets TEXT NOT NULL
  )''';

    await db.execute(profileSql);
  }

  // Insert a new profile
  Future<ProfileItem> createProfile(ProfileItem profile) async {
    final db = await instance.database;
    final id = await db.insert('profiles', profile.toMap());
    return profile.copy(id: id);
  }

// Update an existing profile
  Future<int> updateProfile(ProfileItem profile) async {
    final db = await instance.database;
    return db.update(
      'profiles',
      profile.toMap(),
      where: 'id = ?',
      whereArgs: [profile.id],
    );
  }

// Delete a profile
  Future<int> deleteProfile(int id) async {
    final db = await instance.database;
    return await db.delete(
      'profiles',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

// Get all profiles
  Future<List<ProfileItem>> getProfiles() async {
    final db = await instance.database;
    const orderBy = 'name ASC';
    final result = await db.query('profiles', orderBy: orderBy);
    return result.map((json) => ProfileItem.fromMap(json)).toList();
  }
}
