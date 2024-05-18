import 'package:mon/model/User.dart';
import 'package:mon/utils/Logger.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  static const String _databaseName = 'mon_database.db';
  
  static const int _databaseVersion = 1; 

  DatabaseManager._privateConstructor();

  static final DatabaseManager shared = DatabaseManager._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    try {
      final documentsDirectory = await getApplicationDocumentsDirectory();
      final path = join(documentsDirectory.path, _databaseName);
      Logger.log("Database Path is $path");
      return await openDatabase(path,
          version: _databaseVersion,
          onConfigure: _onConfigure,
          onCreate: _onCreate,
          onUpgrade: _onUpgrade);
    } catch (e) {
      Logger.log("Error while initializing database: $e");
      rethrow;
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    try {
      await db.execute(TUser.dbCreation());
    } catch (e) {
      Logger.log("Error creating tables: $e");
    }
  }

  Future<void> _onConfigure(Database db) async {
    try {
      await db.execute('PRAGMA foreign_keys = OFF');
    } catch (e) {
      Logger.log("Error configuration tables: $e");
    }
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Handle database upgrade
    // You can check the old and new versions to decide what to do
    // For example, you can use a switch statement to execute different SQL commands
    // depending on the old and new versions

    if (oldVersion == 1 && newVersion == 2) {
      await db.execute(TUser.dbCreation());
    }

    // if (oldVersion == 2 && newVersion == 3) {
    //   await db.execute(TAnotherNewTable.dbCreation());
    // }
  }

  Future<int> insertOrUpdate(String schema, Map<String, dynamic> row,
      {String primaryKey = 'id'}) async {
    try {
      final db = await shared.database;
      final id = row[primaryKey];
      final existingRow =
          await db.query(schema, where: '$primaryKey = ?', whereArgs: [id]);

      if (existingRow.isNotEmpty) {
        return await db
            .update(schema, row, where: '$primaryKey = ?', whereArgs: [id]);
      } else {
        return await db.insert(schema, row);
      }
    } catch (e) {
      Logger.log("Error Insert and update: $e");
      rethrow;
    }
  }

  Future<int> insert(String schema, Map<String, dynamic> row) async {
    try {
      final db = await shared.database;
      return await db.insert(schema, row);
    } catch (e) {
      Logger.log("Error Insert: $e");
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> queryAllRows(String schema) async {
    try {
      final db = await shared.database;
      return await db.query(schema);
    } catch (e) {
      Logger.log("Error query: $e");
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> queryWhere(
      String schema, String? where, List<Object?>? whereArgs) async {
    try {
      final db = await shared.database;
      return await db.query(schema, where: 'id = ?', whereArgs: whereArgs);
    } catch (e) {
      Logger.log("Error queryWhere: $e");
      rethrow;
    }
  }

  Future<int> update(String schema, Map<String, dynamic> row,
      {String primaryKey = "id"}) async {
    try {
      final db = await shared.database;
      final id = row[primaryKey];
      return await db
          .update(schema, row, where: '$primaryKey = ?', whereArgs: [id]);
    } catch (e) {
      Logger.log("Error update: $e");
      rethrow;
    }
  }

  Future<int> delete(String schema, int id, {String primaryKey = "id"}) async {
    try {
      final db = await shared.database;
      return await db.delete(schema, where: '$primaryKey = ?', whereArgs: [id]);
    } catch (e) {
      Logger.log("Error delete: $e");
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> rawQuery(String query) async {
    try {
      final db = await shared.database;
      return await db.rawQuery(query);
    } catch (e) {
      Logger.log("Error delete: $e");
      rethrow;
    }
  }
} 