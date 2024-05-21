import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/plan.dart';

class TodoRepository {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'plan.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE Plans(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)');
  }

  Future<List<Plan>> getAllPlans() async {
    final db = await database;
    final List<Map<String, dynamic>> planMaps = await db.query('Plans');
    return planMaps.map((planMap) => Plan.fromMap(planMap)).toList();
  }

  Future insertPlan(Plan plan) async {
    final db = await database;
    int id = await db.insert('Plans', plan.toMap());
    return id;
  }
}