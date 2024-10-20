import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'uroflow.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE patients(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, flowRate REAL, date TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertPatient(String name, double flowRate, String date) async {
    final db = await initializeDB();
    await db.insert('patients', {
      'name': name,
      'flowRate': flowRate,
      'date': date,
    });
  }

  Future<List<Map<String, dynamic>>> getPatients() async {
    final db = await initializeDB();
    return db.query('patients');
  }

  Future<void> clearPatients() async {
    final db = await initializeDB();
    await db.delete('patients');
  }
}
