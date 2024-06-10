import 'package:flutter/material.dart';
import 'package:plan_app/models/task.dart';
import 'package:plan_app/views/widgets/add_dialog.dart';
import 'package:plan_app/views/widgets/delete_dialog.dart';
import 'package:provider/provider.dart';

import '../controllers/task_controller.dart';
import '../providers/task_notifier.dart';
import '../repositories/todo_repository.dart';
import '../services/task_service.dart';
import '../models/plan.dart';

class TaskScreen extends StatefulWidget {
  final Plan plan;

  const TaskScreen({super.key, required this.plan});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late Plan plan;

  @override
  void initState() {
    super.initState();
    plan = widget.plan;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskNotifier>(
      create: (_) => TaskNotifier(TaskController(plan,
          TaskService(Provider.of<TodoRepository>(context, listen: false)))),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Plan: ${plan.name}'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Consumer<TaskNotifier>(
                builder: (context, taskNotifier, child) =>
                    _buildList(taskNotifier),
              ),
            ),
          ],
        ),
        floatingActionButton: Consumer<TaskNotifier>(
          builder: (context, taskNotifier, child) {
            return FloatingActionButton(
              onPressed: () => _showAddTaskDialog(taskNotifier),
              child: const Icon(Icons.add),
            );
          },
        ),
      ),
    );
  }

  void _showAddTaskDialog(TaskNotifier taskNotifier) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AddDialog(
              title: "Añadir nueva tarea",
              decoration: "Descripción",
              onAdd: (String text) {
                taskNotifier.addTask(text);
                if (taskNotifier.errorMessage != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(taskNotifier.errorMessage!)));
                }
              });
        });
  }

  Widget _buildList(TaskNotifier taskNotifier) {
    if (taskNotifier.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (taskNotifier.tasks.isEmpty) {
      return const Center(
        child: Text('No hay tareas'),
      );
    }
    return ListView.builder(
      //controller: scrollController,
      itemCount: taskNotifier.taskCount,
      itemBuilder: ((context, index) {
        final task = taskNotifier.tasks[index];
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
              task.description,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
              ),
            ),
            onTap: () {},
            trailing: IconButton(
              onPressed: () {
                _showDeleteTaskDialog(taskNotifier, task);
              },
              icon: const Icon(Icons.delete, color: Colors.redAccent),
            ),
          ),
        );
      }),
    );
  }

  void _showDeleteTaskDialog(TaskNotifier taskNotifier, Task task) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DeleteDialog(
              title: 'Eliminar tarea',
              content: '¿Está seguro de eliminar la tarea?',
              onDelete: () {
                taskNotifier.deleteTask(task);
                if (taskNotifier.errorMessage != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(taskNotifier.errorMessage!)));
                }
              });
        });
  }
}
