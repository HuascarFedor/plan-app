import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import './providers/plan_notifier.dart';
import './controllers/plan_controller.dart';
import '../repositories/todo_repository.dart';
import '../services/plan_service.dart';

import './views/plan_screen.dart';

void main() => runApp(const PlanApp());

class PlanApp extends StatelessWidget {
  const PlanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PlanNotifier(PlanController(PlanService(TodoRepository()))),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PlanScreen(),
      ),
    );
  }
}