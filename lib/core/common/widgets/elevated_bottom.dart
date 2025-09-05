import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final double? width;
  final Color? backgroundColor;
  final Color textColor;
  final Color borderColor;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onTap,
    this.leadingIcon,
    this.trailingIcon,
    this.width,
    this.backgroundColor,
    this.textColor = AppColors.sky50,
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
          color: backgroundColor,
          borderRadius: BorderRadius.circular(AppSpacing.radiusXL),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leadingIcon != null) ...[
              Icon(leadingIcon, color: textColor),
              const SizedBox(width: AppSpacing.spacing8),
            ],
            Text(
              text,
              style: AppTypography.blockquote.copyWith(color: textColor),
            ),
            if (trailingIcon != null) ...[
              const SizedBox(width: AppSpacing.spacing8),
              Icon(trailingIcon, color: textColor),
            ],
          ],
        ),
      ),
    );
  }
}
