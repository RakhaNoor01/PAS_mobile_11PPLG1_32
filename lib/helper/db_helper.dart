import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('characters.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL';

    await db.execute('''
      CREATE TABLE favorites (
        id $idType,
        characterId $intType,
        nameEn $textType,
        nameJp $textType,
        thumbImg $textType,
        colorMain $textType
      )
    ''');
  }

  // CREATE - Insert Favorite
  Future<int> insertFavorite(Map<String, dynamic> favorite) async {
    final db = await instance.database;
    return await db.insert('favorites', favorite);
  }

  // READ - Get All Favorites
  Future<List<Map<String, dynamic>>> getAllFavorites() async {
    final db = await instance.database;
    return await db.query('favorites', orderBy: 'id DESC');
  }

  // READ - Check if Character is Favorite
  Future<bool> isFavorite(int characterId) async {
    final db = await instance.database;
    final result = await db.query(
      'favorites',
      where: 'characterId = ?',
      whereArgs: [characterId],
    );
    return result.isNotEmpty;
  }

  // UPDATE - Update Favorite
  Future<int> updateFavorite(int id, Map<String, dynamic> favorite) async {
    final db = await instance.database;
    return await db.update(
      'favorites',
      favorite,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // DELETE - Delete Favorite by ID
  Future<int> deleteFavorite(int id) async {
    final db = await instance.database;
    return await db.delete(
      'favorites',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // DELETE - Delete Favorite by Character ID
  Future<int> deleteFavoriteByCharacterId(int characterId) async {
    final db = await instance.database;
    return await db.delete(
      'favorites',
      where: 'characterId = ?',
      whereArgs: [characterId],
    );
  }

  // DELETE ALL - Clear All Favorites
  Future<int> deleteAllFavorites() async {
    final db = await instance.database;
    return await db.delete('favorites');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}