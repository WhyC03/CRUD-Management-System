import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/record_model.dart';

class LocalDatabase {
  static final LocalDatabase instance = LocalDatabase._init();
  static Database? _database;

  LocalDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('records.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE records (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        age INTEGER NOT NULL,
        address TEXT NOT NULL,
        role TEXT NOT NULL
      )
    ''');
  }

  // Insert
  Future<int> insertRecord(Record record) async {
    final db = await instance.database;
    return await db.insert('records', record.toMap());
  }

  // Read All
  Future<List<Record>> getAllRecords() async {
    final db = await instance.database;
    final result = await db.query('records');
    return result.map((e) => Record.fromMap(e)).toList();
  }

  // Update
  Future<int> updateRecord(Record record) async {
    final db = await instance.database;
    return await db.update(
      'records',
      record.toMap(),
      where: 'id = ?',
      whereArgs: [record.id],
    );
  }

  // Delete
  Future<int> deleteRecord(int id) async {
    final db = await instance.database;
    return await db.delete(
      'records',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Search
  Future<List<Record>> searchRecords(String query) async {
    final db = await instance.database;
    final result = await db.query(
      'records',
      where: 'name LIKE ? OR role LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
    );
    return result.map((e) => Record.fromMap(e)).toList();
  }
}
