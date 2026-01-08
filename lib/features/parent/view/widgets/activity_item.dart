import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/parent/model/child_insights_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActivityItem extends StatelessWidget {
  final Activity activity;

  const ActivityItem({
    super.key,
    required this.activity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXL),
        border: Border.all(
          color: AppColors.neutral200,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          _buildIcon(),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: _buildContent(),
          ),
          _buildTimestamp(),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    String svgAsset;
    Color iconColor;
    Color backgroundColor;

    switch (activity.type) {
      case ActivityType.lessonCompleted:
        svgAsset = 'assets/icons/book.svg';
        iconColor = AppColors.sky600;
        backgroundColor = AppColors.sky50;
        break;
      case ActivityType.quizCompleted:
        svgAsset = 'assets/icons/done.svg';
        iconColor = AppColors.success;
        backgroundColor = AppColors.success.withOpacity(0.1);
        break;
      case ActivityType.dailyLogin:
        svgAsset = 'assets/icons/enter.svg';
        iconColor = AppColors.warning;
        backgroundColor = AppColors.warning.withOpacity(0.1);
        break;
      case ActivityType.achievementUnlocked:
        svgAsset = 'assets/icons/award.svg';
        iconColor = AppColors.funyellow;
        backgroundColor = AppColors.funyellow.withOpacity(0.1);
        break;
    }

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
      ),
      child: Center(
        child: SvgPicture.asset(
          svgAsset,
          width: 20,
          height: 20,
          colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          activity.title,
          style: AppTypography.bodysmall.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          activity.description,
          style: AppTypography.subtle.copyWith(
            color: AppColors.neutral600,
            fontSize: 11,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildTimestamp() {
    return Padding(
      padding: const EdgeInsets.only(left: AppSpacing.sm),
      child: Text(
        activity.relativeTime,
        style: AppTypography.subtle.copyWith(
          color: AppColors.neutral500,
          fontSize: 10,
        ),
      ),
    );
  }
}

