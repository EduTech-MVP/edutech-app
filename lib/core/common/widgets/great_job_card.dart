import 'package:edutech_app/core/common/widgets/rounded_container.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_gradient.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class GreatJobCard extends StatelessWidget {
  const GreatJobCard({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      padding: EdgeInsets.all(32),
      gradient: AppGradients.card,
      child: Column(
        children: [
          Image(
            height: AppSpacing.xxxxl,
            image: AssetImage('assets/icons/award.svg'),
          ),
          SizedBox(height: AppSpacing.xl),

          Text(
            'Great job!',
            style: AppTypography.heading3.copyWith(color: AppColors.sky700),
          ),
          SizedBox(height: AppSpacing.xl),
          Text(
            style: AppTypography.lead.copyWith(
              fontSize: 13,
              height: 1.5,
              color: Colors.black,
            ),
            maxLines: 1,
            overflow: TextOverflow.visible,
            softWrap: false,
            'You’ve completed 8 lessons this week. Keep it up!',
          ),
        ],
      ),
    );
  }
}
