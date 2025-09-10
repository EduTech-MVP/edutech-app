import 'package:edutech_app/core/common/widgets/rounded_container.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(AppSpacing.cardPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 50,
            child: Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                  backgroundColor: AppColors.sky100,
                  radius: 14,
                  child: Image.asset(
                    width: 16,
                    height: 16,
                    color: AppColors.sky700,
                    'assets/images/camera.svg',
                  ),
                ),
              ),
            ),
          ),
          Text('name', style: AppTypography.heading4),
          Text('@email'),
          SizedBox(height: 20),
          Text('age-grade', style: AppTypography.small),
        ],
      ),
    );
  }
}
