import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_gradient.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/teacher/model/class_model.dart';
import 'package:flutter/material.dart';

class ClassCard extends StatelessWidget {
  final ClassModel classData;
  final VoidCallback? onTap;

  const ClassCard({super.key, required this.classData, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.spacing24),
        decoration: BoxDecoration(
          color: AppColors.sky50,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.neutral300),
          boxShadow: [AppColors.defaultShadow],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Class title and grade
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${classData.subject} • ${classData.name}',
                  style: AppTypography.heading4.copyWith(
                    color: AppColors.neutral800,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.spacing8,
                    vertical: AppSpacing.spacing4,
                  ),
                  decoration: BoxDecoration(
                    gradient: AppGradients.grade,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.neutral300),
                  ),
                  child: Text(
                    classData.grade,
                    style: AppTypography.subtle.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.sky700,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.spacing16),

            // Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _StatItem(
                  value: classData.lessonCount.toString(),
                  label: 'Lessons',
                ),
                const SizedBox(width: 8),
                _StatItem(
                  value: classData.studentCount.toString(),
                  label: 'Students',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: AppTypography.heading3),
        Text(
          label,
          style: AppTypography.subtle.copyWith(color: AppColors.neutral600),
        ),
      ],
    );
  }
}
