import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/core/common/widgets/rounded_container.dart';
import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  final String lessonTitle;
  final String timeAgo;
  final int score;

  const ActivityCard({
    super.key,
    required this.lessonTitle,
    required this.timeAgo,
    required this.score,
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
        child: Row(
          children: [
            // Lesson Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lessonTitle,
                    style: AppTypography.labelxl.copyWith(
                      color: AppColors.foreground,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    timeAgo,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.mutedforeground,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Time Icon Row
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_outlined,
                        size: 16,
                        color: AppColors.primaryforeground,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        timeAgo,
                        style: AppTypography.bodyxs.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Score Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.funyellow.withOpacity(0.2),
                border: Border.all(color: AppColors.funyellow, width: 1),
                borderRadius: BorderRadius.circular(36),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.star_outline_rounded,
                    size: 16,
                    color: AppColors.primaryforeground,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    score.toString(),
                    style: AppTypography.labelmedium.copyWith(
                      color: AppColors.foreground,
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

