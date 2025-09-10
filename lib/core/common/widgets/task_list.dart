import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/child/controllers/task_list_controller.dart';
import 'package:edutech_app/features/child/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'task_tile.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    final taskController = context.watch<TaskListController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppSpacing.xxxl),

        Row(
          children: [
            Image(
              height: AppSpacing.iconXL,
              color: AppColors.sky500,
              image: AssetImage('assets/icons/done.svg'),
            ),
            SizedBox(width: AppSpacing.sm),

            Text('Today\'s Tasks', style: AppTypography.heading3),
          ],
        ),
        const SizedBox(height: 8),
        ...taskController.tasks.asMap().entries.map((entry) {
          int index = entry.key;
          Task task = entry.value;
          return TaskTile(
            title: task.title,
            isCompleted: task.isCompleted,
            onTap: () => taskController.toggleTaskCompletion(index),
            buttonLabel: task.isCompleted ? null : 'Start',
          );
        }),
      ],
    );
  }
}
