import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class ClassesEmptyState extends StatelessWidget {
  const ClassesEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.spacing24),
      decoration: BoxDecoration(
        color: AppColors.sky50,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [AppColors.defaultShadow],
      ),
      child: Column(
        children: [
          const Icon(Icons.school_outlined, size: 64, color: AppColors.sky300),
          const SizedBox(height: AppSpacing.spacing16),
          Text('No Classes Yet', style: AppTypography.heading4),
          const SizedBox(height: AppSpacing.spacing8),
          Text(
            'Create your first class to get started',
            style: AppTypography.paragrah.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

