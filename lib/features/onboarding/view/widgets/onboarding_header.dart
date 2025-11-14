import 'package:flutter/material.dart';
import '../../../../core/common/widgets/linear_progress.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../controller/onboarding_provider.dart';

class OnboardingHeader extends StatelessWidget {
  final OnboardingProvider provider;
  final VoidCallback onBackPressed;

  const OnboardingHeader({
    super.key,
    required this.provider,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.spacing24),
      child: Column(
        children: [
          // Back Button and Progress Text
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (provider.currentStep > 0)
                GestureDetector(
                  onTap: onBackPressed,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.arrow_back,
                        color: AppColors.buttonprimary,
                        size: 20,
                      ),
                      const SizedBox(width: AppSpacing.spacing8),
                      Text(
                        "Back",
                        style: AppTypography.paragrah.copyWith(
                          color: AppColors.buttonprimary,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                )
              else
                const SizedBox.shrink(),

              Text(
                "${provider.currentStep + 1} of ${provider.totalSteps}",
                style: AppTypography.subtle.copyWith(
                  color: AppColors.mutedtext,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.spacing16),

          // Progress Bar
          LinearProgress(
            value: (provider.currentStep + 1) / provider.totalSteps,
          ),
        ],
      ),
    );
  }
}
