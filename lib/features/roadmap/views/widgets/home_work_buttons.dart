import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final bool isEnabled;

  final VoidCallback onPressed;

  const SubmitButton({
    super.key,
    required this.isEnabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),

      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [AppColors.shadowMedium],
        color: isEnabled ? AppColors.primary : AppColors.funsky,

        borderRadius: BorderRadius.circular(18),
      ),
      child: GestureDetector(
        onTap: isEnabled ? onPressed : null,

        child: Center(
          child: Text(
            'Submit Answer',
            style: AppTypography.labelxl.copyWith(
              color: AppColors.primaryforeground,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}

class NextButton extends StatelessWidget {
  final VoidCallback onPressed;

  const NextButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary400,
        borderRadius: BorderRadius.circular(18),
      ),

      width: double.infinity,
      child: GestureDetector(
        onTap: onPressed,
        child: Center(
          child: Text(
            'Next Question',
            style: AppTypography.labelxl.copyWith(
              color: AppColors.primaryforeground,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}

class FinishButton extends StatelessWidget {
  final VoidCallback onPressed;

  const FinishButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),

      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primary400,
        borderRadius: BorderRadius.circular(18),
      ),
      child: GestureDetector(
        onTap: onPressed,
        child: Center(
          child: Text(
            'Finish Homework',
            style: AppTypography.labelxl.copyWith(
              color: AppColors.primaryforeground,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
