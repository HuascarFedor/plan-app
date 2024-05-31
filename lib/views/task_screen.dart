import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Plan: ${plan.name}'),
      ),
    );
  }
}
