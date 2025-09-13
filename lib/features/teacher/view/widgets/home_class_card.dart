import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_gradient.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/teacher/model/class_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeClassCard extends StatelessWidget {
  final ClassModel classData;
  final VoidCallback? onTap;

  const HomeClassCard({super.key, required this.classData, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.md),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: AppColors.sky50,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${classData.subject} • ${classData.name}',
                  style: AppTypography.heading4.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                // Grade
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    gradient: AppGradients.grade,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    classData.grade,
                    style: AppTypography.subtle.copyWith(
                      color: const Color(0xFF0369A1),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Bottom Row: Lessons and Students
            Row(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/book.svg',
                      width: 16,
                      height: 16,
                      colorFilter: ColorFilter.mode(
                        AppColors.textTertiary,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${classData.lessonCount} lessons',
                      style: AppTypography.subtle.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                // Students
                Row(
                  children: [
                    Text(
                      '${classData.studentCount} students',
                      style: AppTypography.subtle.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
