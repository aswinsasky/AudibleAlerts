import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  static const _tableName = 'TaskTable';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'audiblealerts.db');
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, stringValue TEXT, dateTimeValue TEXT),dropdownvalue1 TEXT,dropdownvalue2 TEXT');
  }

  Future<int> insertData(String stringValue, String dateTimeValue,
      String dropdownvalue1, String dropdownvalue2) async {
    final db = await database;
    return await db.insert(_tableName, {
      'stringValue': stringValue,
      'dateTimeValue': dateTimeValue,
      'dropdownvalue1': dropdownvalue1,
      'dropdownvalue2': dropdownvalue2
    });
  }

  Future<List<Map<String, dynamic>>> getData() async {
    final db = await database;
    return await db.query(_tableName);
  }
}
