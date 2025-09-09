import 'package:edutech_app/providers/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'task_tile.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Watch the provider to listen for changes
    final taskProvider = context.watch<TaskProvider>();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title
          const SizedBox(height: 16),
          // List of tasks
          ...taskProvider.tasks.asMap().entries.map((entry) {
            int index = entry.key;
            Task task = entry.value;
            return TaskTile(
              title: task.title,
              isCompleted: task.isCompleted,
              // Call the provider method when tapped
              onTap: () => taskProvider.toggleTaskCompletion(index),
              buttonLabel: task.isCompleted ? null : 'Start',
            );
          }).toList(),
        ],
      ),
    );
  }
}
