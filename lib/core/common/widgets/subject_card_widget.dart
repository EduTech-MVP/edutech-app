import 'package:edutech_app/core/common/widgets/rounded_container.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/student/models/subjec_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SubjectCard extends StatelessWidget {
  final Subject subject;
  final EdgeInsetsGeometry? padding;

  const SubjectCard({super.key, required this.subject, this.padding});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      padding: padding,
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
          SvgPicture.asset(
            subject.image,
            height: AppSpacing.iconXXXL,
            colorFilter: ColorFilter.mode(AppColors.sky500, BlendMode.srcIn),
          ),
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
