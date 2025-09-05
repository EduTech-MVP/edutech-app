import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:flutter/cupertino.dart';

class Logo extends StatelessWidget {
  final String firstText;
  final String secondText;

  const Logo({super.key, required this.firstText, required this.secondText});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          height: AppSpacing.iconXXXL * 2,
          image: AssetImage('assets/images/logo.png'),
        ),
        Text(firstText, style: AppTypography.heading2),
        Text(
          secondText,
          style: AppTypography.paragrah.copyWith(color: AppColors.sky700),
        ),
      ],
    );
  }
}
