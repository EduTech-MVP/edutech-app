import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_gradient.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final double? width;
  final Gradient gradient;
  final Color textColor;
  final Color borderColor;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onTap,
    this.leadingIcon,
    this.trailingIcon,
    this.width,
    this.gradient = AppGradients.iconBlue,
    this.textColor = AppColors.background,
    this.borderColor = AppColors.sky700,
  }) : assert(
         leadingIcon == null || trailingIcon == null,
         'You can only provide either leadingIcon or trailingIcon, not both',
       );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppSpacing.buttonHeight,
        width: width,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(AppSpacing.radiusXXL),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leadingIcon != null) ...[
              leadingIcon!,
              const SizedBox(width: AppSpacing.spacing8),
            ],
            Text(
              text,
              style: AppTypography.paragrah.copyWith(color: textColor),
            ),
            if (trailingIcon != null) ...[
              const SizedBox(width: AppSpacing.spacing8),
              trailingIcon!,
            ],
          ],
        ),
      ),
    );
  }
}
