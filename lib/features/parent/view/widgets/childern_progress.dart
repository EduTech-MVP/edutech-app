import 'package:edutech_app/core/common/widgets/rounded_container.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/parent/model/family_progress_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FamilyCard extends StatelessWidget {
  final FamilyProgressModel familyProgress;
  final EdgeInsetsGeometry? padding;

  const FamilyCard({super.key, required this.familyProgress, this.padding});

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
            familyProgress.image,
            height: AppSpacing.iconXXXL,
            colorFilter: ColorFilter.mode(AppColors.sky500, BlendMode.srcIn),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            "${familyProgress.num}",
            style: AppTypography.heading3.copyWith(color: Colors.black),
          ),
          Text(
            familyProgress.title,
            style: AppTypography.subtle.copyWith(
              fontSize: 14,
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}
