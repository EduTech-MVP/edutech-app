import 'package:edutech_app/core/common/widgets/rounded_container.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/teacher/model/class_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ClassCard extends StatelessWidget {
  final ClassModel classData;
  final VoidCallback? onTap;

  const ClassCard({super.key, required this.classData, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RoundedContainer(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primaryforeground,
            border: Border.all(color: AppColors.border, width: 1),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [AppColors.shadowMedium],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Class name and grade badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        '${classData.subject} • ${classData.name}',
                        style: AppTypography.heading2.copyWith(
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.sky50,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: AppColors.buttonprimary,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          '${classData.grade}th grade',
                          style: AppTypography.labelxl.copyWith(
                            color: const Color(0xFF25AFF4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Lessons and Students
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/book.svg',
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        AppColors.sky500,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${classData.lessonCount} lessons',
                      style: AppTypography.paragrah.copyWith(
                        fontSize: 14,
                        color: AppColors.sky500,
                      ),
                    ),
                    const SizedBox(width: 24),
                    SvgPicture.asset(
                      'assets/icons/profile.svg',
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        AppColors.sky500,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${classData.studentCount} students',
                      style: AppTypography.paragrah.copyWith(
                        fontSize: 14,
                        color: AppColors.sky500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
