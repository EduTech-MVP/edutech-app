import 'package:edutech_app/core/common/widgets/rounded_container.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/child/models/subjec_model.dart';
import 'package:flutter/material.dart';

class SubjectCard extends StatelessWidget {
  final Subject subject;

  const SubjectCard({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      bordercolor: AppColors.neutral400,
      boxShadow: [
        AppColors.defaultShadow.copyWith(
          offset: Offset(0, 0),
          spreadRadius: .2,
        ),
      ],

      color: AppColors.sky50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(color: AppColors.sky500, image: AssetImage(subject.image)),
          const SizedBox(height: AppSpacing.lg),
          Text(subject.title, style: AppTypography.heading4),
          Text(
            subject.subTitle,
            style: AppTypography.subtle.copyWith(
              fontSize: 12,
              color: AppColors.neutral900,
            ),
          ),
          Text(
            subject.lessonsCompleted,
            style: AppTypography.subtle.copyWith(
              fontSize: 12,
              color: AppColors.neutral900,
            ),
          ),
        ],
      ),
    );
  }
}
