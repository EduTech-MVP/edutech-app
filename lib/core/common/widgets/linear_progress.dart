import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class LinearProgress extends StatelessWidget {
  final double? value;
  const LinearProgress({super.key, this.value = 0.25});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSpacing.radiusXXL),
        child: LinearProgressIndicator(
          value: value,
          backgroundColor: AppColors.neutral100,
          color: AppColors.buttonprimary,
          minHeight: AppSpacing.sm,
        ),
      ),
    );
  }
}
