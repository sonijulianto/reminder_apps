import 'package:local_db/models/task.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static late Database _database;
  static DatabaseHelper? _databaseHelper;

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  static String _task = 'tasks';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = await openDatabase(
      join(path, 'task_db.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_task (
            id INTEGER PRIMARY KEY,
            title TEXT, description TEXT,
            date TEXT, time TEXT
          )''',
        );
      },
      version: 1,
    );
    return db;
  }

  Future<void> insertTask(Task task) async {
    final Database db = await database;
    await db.insert(_task, task.toMap());
    print('tasks saved');
  }

  Future<List<Task>> getTask() async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db.query(_task);

    return result.map((e) => Task.fromMap(e)).toList();
  }

  Future<Task> getTaskById(int id) async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      _task,
      where: 'id= ?',
      whereArgs: [id],
    );

    return result.map((e) => Task.fromMap(e)).first;
  }

  Future<void> updateTask(Task task) async {
    final db = await database;

    await db.update(
      _task,
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> deleteTask(int id) async {
    final Database db = await database;

    await db.delete(_task, where: 'id = ?', whereArgs: [id]);
  }
}
