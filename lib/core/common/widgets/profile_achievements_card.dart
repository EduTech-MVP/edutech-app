import 'package:edutech_app/core/common/widgets/rounded_container.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileAchievementsCard extends StatelessWidget {
  final String? image;
  final int? num;
  final String acheive;
  const ProfileAchievementsCard({
    super.key,
    required this.image,
    required this.num,
    required this.acheive,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RoundedContainer(
        bordercolor: AppColors.neutral300,
        boxShadow: [
          AppColors.defaultShadow.copyWith(
            offset: Offset(0, 0),
            spreadRadius: .1,
            blurRadius: 4,
          ),
        ],
        padding: EdgeInsets.all(AppSpacing.cardPadding),
        child: Column(
          children: [
            SvgPicture.asset(
              '$image',
              width: 64,
              height: 64,
              colorFilter: ColorFilter.mode(AppColors.sky500, BlendMode.srcIn),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text('$num', style: AppTypography.heading4),
            Text(
              acheive,
              style: AppTypography.subtle.copyWith(
                fontSize: 12,
                color: AppColors.neutral900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
