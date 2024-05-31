import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/plan_notifier.dart';
import '../models/plan.dart';
import './mixins/scroll_to_last_item_mixin.dart';
import './widgets/add_dialog.dart';
import './widgets/delete_dialog.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> with ScrollToLastItemMixin {
  final ScrollController _scrollController = ScrollController();
  @override
  ScrollController get scrollController => _scrollController;
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final planNotifier = Provider.of<PlanNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plan Maestro'),
      ),
      body: _buildList(planNotifier),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddPlanDialog(),
        tooltip: 'Agregar Plan',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildList(PlanNotifier planNotifier) {
    if (planNotifier.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (planNotifier.plans.isEmpty) {
      return const Center(
        child: Text('No hay planes'),
      );
    }
    return ListView.builder(
      controller: scrollController,
      itemCount: planNotifier.plansCount,
      itemBuilder: ((context, index) {
        final plan = planNotifier.plans[index];
        return Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.black26,
                width: 1.0,
              ),
            ),
          ),
          child: ListTile(
            title: Text(
              plan.name,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
              ),
            ),
            onTap: () {},
            trailing: IconButton(
              onPressed: () {
                _showDeletePlanDialog(planNotifier, plan);
              },
              icon: const Icon(Icons.delete, color: Colors.redAccent),
            ),
          ),
        );
      }),
    );
  }

  void _showAddPlanDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddDialog(
          title: 'Añadir nuevo plan',
          decoration: 'Nombre del plan',
          onAdd: (String text) {
            final planNotifier =
                Provider.of<PlanNotifier>(context, listen: false);
            planNotifier.addPlan(text);
            if (planNotifier.erroMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(planNotifier.erroMessage!)));
            }
            scrollToLastItem();
          },
        );
      },
    );
  }

  void _showDeletePlanDialog(PlanNotifier planNotifier, Plan plan) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DeleteDialog(
              title: 'Eliminar plan',
              content: '¿Está seguro de eliminar el plan?',
              onDelete: () {
                planNotifier.deletePlan(plan);
                if (planNotifier.erroMessage != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(planNotifier.erroMessage!))
                  );
                }
              });
        });
  }
}
