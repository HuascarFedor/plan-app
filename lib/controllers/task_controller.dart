import '../utils/list_utils.dart';
import '../models/task.dart';
import '../services/task_service.dart';
import '../models/plan.dart';

class TaskController {
  final Plan _plan;
  final TaskService _taskService;

  TaskController(this._plan, this._taskService);

  final _tasks = <Task>[];

  List<Task> get tasks => List.unmodifiable(_tasks);

  Future<void> loadTasks() async {
    try {
      _tasks.clear();
      final loadedTasks = await _taskService.getTasks(_plan);
      if (loadedTasks.isNotEmpty) {
        _tasks.addAll(loadedTasks);
      }
    } catch (e) {
      throw Exception("Error al cargar las tareas: $e");
    }
  }

  Future<void> addTask(String description) async {
    if (description.isEmpty) description = "Tarea";
    description = ListUtils.checkForDuplicates(
        tasks.map((task) => task.description), description);
    try {
      int id = await _taskService
          .addTask(Task(description: description, planId: _plan.id!));
      _tasks.add(Task(id: id, description: description, planId: _plan.id!));
    } catch (e) {
      throw Exception("Error al añadir la tarea: $e");
    }
  }

  Future<void> deleteTask(Task task) async {
    try {
      await _taskService.deleteTask(task);
    } catch (e) {
      throw Exception('Error al eliminar la tarea: $e');
    } finally {
      _tasks.removeWhere((item) => item.id == task.id);
    }
  }
}
