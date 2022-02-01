import 'package:flutter/foundation.dart';
import 'package:local_db/database_helper.dart';
import 'package:local_db/models/task.dart';

class DbProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  late DatabaseHelper _dbHelper;

  List<Task> get tasks => _tasks;

  DbProvider() {
    _dbHelper = DatabaseHelper();
    _getAllTask();
  }

  void _getAllTask() async {
    _tasks = await _dbHelper.getTask();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await _dbHelper.insertTask(task);
    _getAllTask();
  }

  Future<Task> getTaskById(int id) async {
    return await _dbHelper.getTaskById(id);
  }

  void updateTask(Task task) async {
    await _dbHelper.updateTask(task);
    _getAllTask();
  }

  void deleteTask(int id) async {
    await _dbHelper.deleteTask(id);
    _getAllTask();
  }
}
