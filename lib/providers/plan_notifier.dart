import 'package:flutter/material.dart';
import '../models/plan.dart';
import '../controllers/plan_controller.dart';

class PlanNotifier extends ChangeNotifier {
  final PlanController _planController;
  bool _isLoading = false;
  String? _errorMessage;

  PlanNotifier(this._planController) {
    _loadPLans();
  }

  bool get isLoading => _isLoading;
  String? get erroMessage => _errorMessage;
  List<Plan> get plans => _planController.plans;
  int get plansCount => plans.length;

  Future<void> _loadPLans() async {
    try {
      _isLoading = true;
      notifyListeners();
      await _planController.loadPlans();
    } catch (e) {
      _errorMessage = "No se pudieron cargar los planes";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addPlan(String name) async {
    try {
      _errorMessage = null;
      notifyListeners();
      await _planController.addPlan(name);
    } catch (e) {
      _errorMessage = "Error al añadir el plan";
    }
    notifyListeners();
  }
}
