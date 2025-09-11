import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Logo extends StatelessWidget {
  final String firstText;
  final String secondText;

  const Logo({super.key, required this.firstText, required this.secondText});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          'assets/images/logo.svg',
          height: AppSpacing.iconXXXL * 2,
        ),
        Text(firstText, style: AppTypography.heading2.copyWith(fontSize: 38)),
        Text(
          secondText,
          style: AppTypography.lead.copyWith(
            color: AppColors.sky700,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
