import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/core/common/widgets/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SubjectProgressCard extends StatelessWidget {
  final String subjectName;
  final int completedLessons;
  final int progressPercentage;
  final Color subjectColor;

  const SubjectProgressCard({
    super.key,
    required this.subjectName,
    required this.completedLessons,
    required this.progressPercentage,
    required this.subjectColor,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.border, width: 1),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [AppColors.shadowLarge],
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Subject Info Row
            Row(
              children: [
                // Subject Icon
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: subjectColor,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: SvgPicture.asset('assets/icons/target.svg'),
                ),
                const SizedBox(width: 12),
                // Subject Name and Completion
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subjectName,
                        style: AppTypography.labelxl.copyWith(
                          color: AppColors.foreground,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$completedLessons lessons completed',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.mutedforeground,
                        ),
                      ),
                    ],
                  ),
                ),
                // Percentage
                Text(
                  '$progressPercentage%',
                  style: AppTypography.heading3.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Progress Bar
            Container(
              height: 8,
              decoration: BoxDecoration(
                color: AppColors.funmint5,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Stack(
                children: [
                  Container(
                    height: 12,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.funmint5,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: (progressPercentage / 100).clamp(0.0, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
