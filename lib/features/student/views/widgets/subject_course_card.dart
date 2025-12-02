import 'package:edutech_app/core/common/widgets/elevated_bottom.dart';
import 'package:edutech_app/core/common/widgets/rounded_container.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SubjectCourseCard extends StatelessWidget {
  final String subject;
  final String detail;
  final String progress;
  final VoidCallback onContinue;

  const SubjectCourseCard({
    super.key,
    required this.subject,
    required this.detail,
    required this.progress,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
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
            children: [
              // Subject name at the top
              Row(
                children: [
                  Text(
                    subject,
                    style: AppTypography.heading4.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Detail, Progress, and Button row
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Left side: Detail and Progress
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Detail
                        Text(
                          detail,
                          style: AppTypography.subtle.copyWith(
                            fontSize: 14,
                            color: AppColors.mutedtext,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Progress
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/book.svg',
                              width: 16,
                              height: 16,
                              colorFilter: ColorFilter.mode(
                                AppColors.textPrimary,
                                BlendMode.srcIn,
                              ),
                            ),
                            const SizedBox(width: 4.67),
                            Flexible(
                              child: Text(
                                progress,
                                style: AppTypography.paragrah.copyWith(
                                  fontSize: 12,
                                  color: AppColors.textPrimary,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  CustomElevatedButton(
                    text: "Continue",
                    leadingIcon: const Icon(
                      Icons.play_arrow_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                    onTap: onContinue,
                    width: 120,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
