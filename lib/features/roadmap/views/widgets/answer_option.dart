import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class AnswerOption extends StatelessWidget {
  final String option;
  final int index;
  final bool isSelected;
  final bool isCorrect;
  final bool showResult;
  final VoidCallback? onTap;

  const AnswerOption({
    super.key,
    required this.option,
    required this.index,
    required this.isSelected,
    required this.isCorrect,
    required this.showResult,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color borderColor;

    if (showResult) {
      if (isCorrect) {
        backgroundColor = AppColors.funmint;
        borderColor = AppColors.success;
      } else if (isSelected && !isCorrect) {
        backgroundColor = AppColors.funcoral;
        borderColor = AppColors.error;
      } else {
        backgroundColor = Colors.white;
        borderColor = const Color(0xFFE0E0E0);
      }
    } else {
      backgroundColor = isSelected ? AppColors.gradientStart : Colors.white;
      borderColor = isSelected ? AppColors.primary400 : AppColors.neutral200;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            boxShadow: [AppColors.shadowMedium],
            color: backgroundColor,
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: borderColor, width: 1),
          ),
          child: Row(
            children: [
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: showResult || isSelected
                      ? Colors.transparent
                      : Colors.transparent,
                  border: Border.all(color: AppColors.primary400, width: 1),
                ),
                child:
                    showResult && isCorrect ||
                        isSelected && !showResult ||
                        showResult && isSelected && !isCorrect
                    ? Center(
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary400,
                          ),
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  option,
                  style: AppTypography.heading3.copyWith(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
