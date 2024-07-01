import 'package:flutter/material.dart';
import '../models/task.dart';
import '../controllers/task_controller.dart';

class TaskNotifier extends ChangeNotifier {
  final TaskController _taskController;
  bool _isLoading = false;
  String? _errorMessage;

  TaskNotifier(this._taskController) {
    _loadTasks();
  }

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  List<Task> get tasks => _taskController.tasks;
  int get taskCount => tasks.length;
  int get completeCount => tasks.where((task) => task.complete).length;
  String get completeMessage =>
      "$completeCount tareas concluidas de $taskCount";

  Future<void> _loadTasks() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();
      await _taskController.loadTasks();
    } catch (e) {
      _errorMessage = "No se pudo cargar las tareas: ${e.toString()}";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addTask(String description) async {
    try {
      _errorMessage = null;
      notifyListeners();
      await _taskController.addTask(description);
    } catch (e) {
      _errorMessage = "Error al añdir la tarea: ${e.toString()}";
    } finally {
      notifyListeners();
    }
  }

  Future<void> deleteTask(Task task) async {
    try {
      _errorMessage = null;
      notifyListeners();
      await _taskController.deleteTask(task);
    } catch (e) {
      _errorMessage = "Error al eliminar la tarea $e";
    }
    notifyListeners();
  }

  Future<void> updateTaskCompletion(Task task, bool isComplete) async {
    try {
      _errorMessage = null;
      notifyListeners();
      await _taskController.updateTaskCompletion(task, isComplete);
    } catch (e) {
      _errorMessage = "Error al completar la tarea: $e";
    }
    notifyListeners();
  }
}
