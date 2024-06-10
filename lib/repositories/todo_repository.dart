import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/plan.dart';
import '../models/task.dart';

class TodoRepository {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'plan_task.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE Plans(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)');
    await db.execute(
        'CREATE TABLE Tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, description TEXT, complete INTEGER, planId INTEGER)');
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

  Future deletePlan(Plan plan) async {
    final db = await database;
    await db.delete('Plans', where: 'id = ?', whereArgs: [plan.id]);
  }

  Future<List<Task>> getTasksForPlan(Plan plan) async {
    final db = await database;
    final List<Map<String, dynamic>> taskMaps =
        await db.query('Tasks', where: 'planId = ?', whereArgs: [plan.id]);
    return taskMaps.map((taskMap) => Task.fromMap(taskMap)).toList();
  }

  Future<int> insertTask(Task task) async {
    final db = await database;
    int id = await db.insert('Tasks', task.toMap());
    return id;
  }
}
