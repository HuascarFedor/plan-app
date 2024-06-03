import '../models/plan.dart';
import '../models/task.dart';
import '../repositories/todo_repository.dart';

class TaskService {
  final TodoRepository _todoRepository;

  TaskService(this._todoRepository);

  Future<List<Task>> getTasks(Plan plan) async {
    return await _todoRepository.getTasksForPlan(plan);
  }

  Future<int> addTask(Task task) async {
    return await _todoRepository.insertTask(task);
  }
}
