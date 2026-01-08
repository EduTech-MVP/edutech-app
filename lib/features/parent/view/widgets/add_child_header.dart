import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// Header widget for add child dialog
class AddChildHeader extends StatelessWidget {
  final VoidCallback? onClose;

  const AddChildHeader({super.key, this.onClose});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Add New Child',
          style: AppTypography.heading3.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: onClose ?? () => Navigator.pop(context),
          child: const Icon(
            Icons.close,
            color: AppColors.neutral600,
            size: AppSpacing.iconMD,
          ),
        ),
      ],
    );
  }
}

