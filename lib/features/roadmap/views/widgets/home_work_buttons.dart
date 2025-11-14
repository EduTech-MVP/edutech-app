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
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary400,
          padding: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          disabledBackgroundColor: AppColors.funsky,
        ),
        child: Text(
          'Submit Answer',
          style: AppTypography.heading4.copyWith(
            color: Colors.white,
            fontSize: 18,
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
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary400,
          padding: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Text(
          'Next Question',
          style: AppTypography.heading4.copyWith(
            color: Colors.white,
            fontSize: 18,
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
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary400,
          padding: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Text(
          'Finish Homework',
          style: AppTypography.heading4.copyWith(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
