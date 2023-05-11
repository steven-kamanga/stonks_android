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
    return await openDatabase(path, version: 2, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const profileSql = '''
  CREATE TABLE profiles (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    markets TEXT NOT NULL
  )''';

    await db.execute(profileSql);

    const marketSql = '''
  CREATE TABLE markets (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    marketName TEXT NOT NULL,
    profileId INTEGER,
    FOREIGN KEY (profileId) REFERENCES profiles (id)
  )''';

    await db.execute(marketSql);
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

  // Create a new market
  Future<Market> createMarket(Market market, int profileId) async {
    final db = await instance.database;
    final id = await db.insert('markets', {
      'marketName': market.marketName,
      'profileId': profileId,
    });
    return market.copy(id: id);
  }

// Update an existing market
  Future<void> updateMarket(Market market) async {
    final db = await instance.database;
    await db.update(
      'markets',
      market.toMap(),
      where: 'id = ?',
      whereArgs: [market.id],
    );
  }

// Delete a market
  Future<void> deleteMarket(int id) async {
    final db = await instance.database;
    await db.delete(
      'markets',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

// Get markets for a profile
  Future<List<Market>> getMarketsForProfile(int profileId) async {
    final db = await instance.database;
    final result = await db.query(
      'markets',
      where: 'profileId = ?',
      whereArgs: [profileId],
    );
    return result.map((map) => Market.fromMap(map)).toList();
  }
}
