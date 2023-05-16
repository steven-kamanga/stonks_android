import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/model.dart';
import '../models/trade_model.dart';

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
    return await openDatabase(path, version: 3, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const profileSql = '''
  CREATE TABLE profiles (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    markets TEXT NOT NULL
  )''';

    const marketSql = '''
  CREATE TABLE markets (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    marketName TEXT NOT NULL,
    profileId INTEGER,
    FOREIGN KEY (profileId) REFERENCES profiles (id)
  )''';

    const tradeSql = '''
  CREATE TABLE trades (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    type TEXT NOT NULL,
    price REAL NOT NULL,
    exitPrice REAL NULL,
    quantity REAL NOT NULL,
    date TEXT NOT NULL,
    time TEXT NOT NULL,
    marketId INTEGER,
    FOREIGN KEY (marketId) REFERENCES markets (id)
  )
''';

    await db.execute(profileSql);
    await db.execute(marketSql);
    await db.execute(tradeSql);
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

// Insert a trade
  Future<int> insertTrade(Trade trade) async {
    Database? db = await instance.database;
    return await db.insert('trades', trade.toJson());
  }

// Update a trade
  Future<int> updateTrade(Trade trade) async {
    Database? db = await instance.database;
    return await db.update(
      'trades',
      trade.toJson(),
      where: 'id = ?',
      whereArgs: [trade.id],
    );
  }

// Delete a trade
  Future<int> deleteTrade(int id) async {
    Database? db = await instance.database;
    return await db.delete(
      'trades',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

// Get all trades
  Future<List<Trade>> getTrades() async {
    Database? db = await instance.database;
    List<Map<String, dynamic>> result = await db.query('trades');
    return result.map((map) => Trade.fromJson(map)).toList();
  }
}
