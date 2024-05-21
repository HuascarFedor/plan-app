import '../models/plan.dart';
import '../repositories/todo_repository.dart';

class PlanService {
  final TodoRepository _todoRepository;

  PlanService(this._todoRepository);

  Future<List<Plan>> getPlans() async {
    return await _todoRepository.getAllPlans();
  }

  Future<int> addPlan(Plan plan) async {
    return await _todoRepository.insertPlan(plan);
  }
}
