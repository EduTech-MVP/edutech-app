import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/teacher/model/student_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StudentCard extends StatelessWidget {
  final StudentModel student;
  final VoidCallback? onTap;

  const StudentCard({super.key, required this.student, this.onTap});

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
        child: Row(
          children: [
            // Profile Image
            CircleAvatar(
              radius: 28,
              backgroundImage: student.profileImageUrl != null
                  ? NetworkImage(student.profileImageUrl!)
                  : const AssetImage('assets/images/profile_placeholder.png')
                        as ImageProvider,
            ),
            const SizedBox(width: AppSpacing.spacing16),

            // Student Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(student.name, style: AppTypography.heading4),
                  const SizedBox(height: AppSpacing.spacing8),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/book.svg',
                        height: 16,
                        width: 16,
                        colorFilter: const ColorFilter.mode(
                          AppColors.neutral500,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.spacing8),
                      Text(
                        'Completed ${student.completedLessons} lessons',
                        style: AppTypography.subtle.copyWith(
                          color: AppColors.neutral500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Points Badge
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.spacing8,
                vertical: AppSpacing.spacing4,
              ),
              decoration: BoxDecoration(
                color: AppColors.sky100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.neutral300),
              ),
              child: Text(
                '${student.points} pts',
                style: AppTypography.subtle.copyWith(color: AppColors.sky700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
