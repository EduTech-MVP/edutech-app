import 'package:edutech_app/core/common/widgets/rounded_container.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
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
    Color tileColor = isCompleted ? const Color(0xffBBF7D0) : AppColors.sky50;
    Color iconColor = isCompleted ? const Color(0xff4ADE80) : Colors.black;
    Color bordercolor = isCompleted ? Colors.white : AppColors.neutral400;
    ;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.paddingSM),
        child: RoundedContainer(
          boxShadow: [AppColors.defaultShadow.copyWith(spreadRadius: 0)],
          bordercolor: bordercolor,
          color: tileColor,
          padding: const EdgeInsets.all(AppSpacing.paddingLG),
          child: Row(
            children: [
              Icon(
                isCompleted ? Icons.check_circle : Icons.circle_outlined,
                color: iconColor,
                size: AppSpacing.iconLG,
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(child: Text(title, style: AppTypography.heading4)),
              if (buttonLabel != null)
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        width: .2,
                        color: AppColors.neutral900,
                      ),
                    ),
                    padding: const EdgeInsets.all(AppSpacing.paddingMD),
                    child: Text(
                      buttonLabel!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
