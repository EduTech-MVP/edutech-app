import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/parent/controller/add_child_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Reusable grade dropdown field
class AddChildGradeDropdown extends StatelessWidget {
  const AddChildGradeDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddChildController>(
      builder: (context, controller, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Grade',
              style: AppTypography.paragrah.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Container(
              height: 55,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.spacing16,
                vertical: AppSpacing.spacing12,
              ),
              decoration: BoxDecoration(
                color: AppColors.sky50,
                borderRadius: BorderRadius.circular(AppSpacing.radiusXXL),
                border: Border.all(
                  color: AppColors.neutral300,
                  width: AppSpacing.radiusXS / 2,
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: controller.selectedGrade,
                  hint: Text(
                    'Select grade',
                    style: AppTypography.subtle.copyWith(
                      color: AppColors.neutral500,
                    ),
                  ),
                  isExpanded: true,
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.neutral500,
                  ),
                  items: AddChildController.grades.map((String grade) {
                    return DropdownMenuItem<String>(
                      value: grade,
                      child: Text(
                        grade,
                        style: AppTypography.paragrah.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: controller.isLoading
                      ? null
                      : (String? newValue) {
                          controller.setSelectedGrade(newValue);
                        },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

