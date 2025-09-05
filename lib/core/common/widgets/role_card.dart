import 'package:edutech_app/core/common/widgets/custom_iconbox.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class Rolecard extends StatelessWidget {
  final Widget leadingIcon;
  final String titleText;
  final String subtitleText;
  final void Function()? onTap;

  const Rolecard({
    super.key,
    required this.leadingIcon,
    required this.subtitleText,
    required this.titleText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowMedium,
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          color: AppColors.sky50,
          borderRadius: BorderRadius.circular(AppSpacing.radiusXXL),
        ),
        padding: const EdgeInsets.all(AppSpacing.inputPaddingLarge),
        child: Row(
          children: [
            CustomIconBox(icon: leadingIcon),
            const SizedBox(width: AppSpacing.spacing16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(titleText, style: AppTypography.heading3),
                  Text(
                    subtitleText,
                    style: AppTypography.paragrah.copyWith(
                      color: AppColors.sky700,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
