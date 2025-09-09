import 'package:edutech_app/core/common/widgets/rounded_container.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final String title;
  final bool isCompleted;
  final String? buttonLabel;
  final VoidCallback onTap;

  const TaskTile({
    super.key,
    required this.title,
    this.isCompleted = false,
    this.buttonLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Determine colors based on completion status
    Color tileColor = isCompleted ? Color(0xffBBF7D0) : AppColors.sky50;
    Color iconColor = isCompleted ? Color(0xff4ADE80) : Colors.black;

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RoundedContainer(
          color: tileColor,

          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Completion circle/icon
              Icon(
                isCompleted ? Icons.check_circle : Icons.circle_outlined,
                color: iconColor,
                size: AppSpacing.iconLG,
              ),
              const SizedBox(width: 16),
              // Task title
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: isCompleted ? Colors.black54 : Colors.black87,
                  ),
                ),
              ),
              if (buttonLabel != null)
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Text(buttonLabel!),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
