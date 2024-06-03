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
    return MultiProvider(
      providers: [
        Provider<TodoRepository>(
          create: (_) => TodoRepository(),
        ),
        ChangeNotifierProvider<PlanNotifier>(
          create: (context) => PlanNotifier(PlanController(PlanService(Provider.of<TodoRepository>(context, listen: false)))),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PlanScreen(),
      ),
    );
  }
}
