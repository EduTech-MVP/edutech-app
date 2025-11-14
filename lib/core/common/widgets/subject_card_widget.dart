import 'package:edutech_app/core/common/widgets/rounded_container.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_gradient.dart';
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
      bordercolor: AppColors.borderMedium,
      boxShadow: [AppColors.shadowLarge],

      color: AppColors.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (Rect bounds) {
              return AppGradients.icongold.createShader(
                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
              );
            },
            child: SvgPicture.asset(subject.image, height: AppSpacing.iconXXXL),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            subject.title,
            style: AppTypography.small.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
              fontSize: 28,
            ),
          ),
          Text(
            subject.subTitle,
            style: AppTypography.subtle.copyWith(
              fontSize: 14,
              color: AppColors.mutedtext,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            subject.lessonsCompleted,
            style: AppTypography.subtle.copyWith(
              fontSize: 18,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
