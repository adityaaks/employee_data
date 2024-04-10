import 'package:employee_data/constants/arguments.dart';
import 'package:employee_data/constants/export.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? db;

  static Future<Database?> dpOpen() async {
    db = await openDatabase(
      dbName,
      version: dbVersion,
      onConfigure: (Database database) async {},
    );
    debugPrint(db?.path);
    return db;
  }

  static Future<void> createEmployeeTables() async {
    await db?.execute(
        """CREATE TABLE IF NOT EXISTS ${DatabaseValues.tableEmployee} (
      ${DatabaseValues.columnId} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ${DatabaseValues.columnName} TEXT NOT NULL,
      ${DatabaseValues.columnEmail} TEXT NOT NULL,
      ${DatabaseValues.columnGender} INTEGER ,
      ${DatabaseValues.columnSalaryPerMonth} TEXT,
      ${DatabaseValues.columnCreatedOn} TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
    print('Table Created');
  }

  static Future<dynamic> insertItemMap({dynamic model}) async {
    try {
      await db?.insert(
        DatabaseValues.tableEmployee,
        model,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      debugPrint(
          "Data Inserted Successfully into ${DatabaseValues.tableEmployee} ${model}");
    } catch (e) {
      return e;
    }
  }

  static Future<List<Map<String, dynamic>>?> getEmployeesList() async {
    if (db == null) {
      debugPrint('Database is not open. Open the database first.');
      return null;
    }
    return await db?.query(DatabaseValues.tableEmployee);
  }
}
