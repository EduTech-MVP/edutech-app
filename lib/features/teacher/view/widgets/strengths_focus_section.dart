import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/core/common/widgets/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StrengthsFocusSection extends StatelessWidget {
  final List<String> strengths;
  final List<String> focusAreas;

  const StrengthsFocusSection({
    super.key,
    required this.strengths,
    required this.focusAreas,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Strengths Card
        Expanded(
          child: _buildCard(
            iconPath: 'assets/icons/star.svg',
            iconColor: AppColors.funyellow,
            title: 'Strengths',
            items: strengths,
            backgroundColor: AppColors.funmint2,
            borderColor: AppColors.secondary,
          ),
        ),
        const SizedBox(width: 16),
        // Focus On Card
        Expanded(
          child: _buildCard(
            iconPath: 'assets/icons/target.svg',
            iconColor: AppColors.destructive,
            title: 'Focus On',
            items: focusAreas,
            backgroundColor: AppColors.destructive.withOpacity(0.2),
            borderColor: AppColors.destructive,
          ),
        ),
      ],
    );
  }

  Widget _buildCard({
    required String iconPath,
    required Color iconColor,
    required String title,
    required List<String> items,
    required Color backgroundColor,
    required Color borderColor,
  }) {
    return RoundedContainer(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.border, width: 1),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [AppColors.shadowLarge],
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                SvgPicture.asset(
                  iconPath,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                ),
                const SizedBox(width: 4),
                Text(
                  title,
                  style: AppTypography.labelxl.copyWith(
                    color: AppColors.foreground,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Tags
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    border: Border.all(color: borderColor, width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    item,
                    style: AppTypography.labelmedium.copyWith(
                      color: AppColors.foreground,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
