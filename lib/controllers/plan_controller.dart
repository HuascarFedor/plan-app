import '../services/plan_service.dart';
import '../utils/list_utils.dart';
import '../models/plan.dart';

class PlanController {
  final PlanService _planService;
  PlanController(this._planService);
  final _plans = <Plan>[];
  List<Plan> get plans => List.unmodifiable(_plans);

  Future<void> loadPlans() async {
    try {
      _plans.clear();
      final loadedPlans = await _planService.getPlans();
      if (loadedPlans.isNotEmpty) _plans.addAll(loadedPlans);
    } catch (e) {
      throw Exception("Error al cargar los planes: $e");
    }
  }

  Future<void> addPlan(String name) async {
    if (name.isEmpty) name = "Plan";
    name = ListUtils.checkForDuplicates(plans.map((plan) => plan.name), name);
    try {
      int id = await _planService.addPlan(Plan(name: name));
      _plans.add(Plan(id: id, name: name));
    } catch (e) {
      throw Exception("Error al añadir el plan: $e");
    }
  }

  Future<void> deletePlan(Plan plan) async {
    try {
      await _planService.deletePlan(plan);
    } catch (e) {
      throw Exception('Error al eliminar el plan: $e');
    } finally {
      _plans.removeWhere((item) => item.id == plan.id);
    }
  }
}
