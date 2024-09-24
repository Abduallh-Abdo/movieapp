import 'dart:developer';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfliteDb {
  static final SqfliteDb instance = SqfliteDb._init();
  static Database? _database;

  SqfliteDb._init();

  // Get database instance (Singleton)
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('movies.db');
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // Define the table schema
  Future _createDB(Database db, int version) async {
    const sql = '''
    CREATE TABLE movies (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      image TEXT,
      description TEXT
    )
    ''';
    await db.execute(sql);
    log('Table created');
  }

  // Insert data into the database
  Future<void> insertDB({
    required String title,
    required String image,
    required String description,
  }) async {
    final db = await instance.database;
    try {
      await db.insert(
        'movies',
        {'title': title, 'image': image, 'description': description},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      log('Insert success');
    } catch (error) {
      log('Insert error: $error');
    }
  }

  // Fetch all records from the database
  Future<List<Map<String, dynamic>>> getRecordsFromDB() async {
    final db = await instance.database;
    return await db.query('movies');
  }
}
