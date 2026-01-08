import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
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
    return LayoutBuilder(
      builder: (context, constraints) {
        // Use column layout on smaller screens, row on larger screens
        final useColumn = constraints.maxWidth < 600;

        if (useColumn) {
          return Column(
            children: [
              _buildCard(
                iconPath: 'assets/icons/star.svg',
                iconColor: AppColors.funyellow,
                title: 'Strengths',
                items: strengths.take(3).toList(),
                boxColor: const Color(0xFFE6F7F3),
                textColor: AppColors.textPrimary,
              ),
              const SizedBox(height: 16),
              _buildCard(
                iconPath: 'assets/icons/target.svg',
                iconColor: AppColors.destructive,
                title: 'Focus On',
                items: focusAreas.take(3).toList(),
                boxColor: const Color(0xFFFFE8E3),
                textColor: AppColors.textPrimary,
              ),
            ],
          );
        } else {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildCard(
                  iconPath: 'assets/icons/star.svg',
                  iconColor: AppColors.funyellow,
                  title: 'Strengths',
                  items: strengths.take(3).toList(),
                  boxColor: const Color(0xFFE6F7F3),
                  textColor: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildCard(
                  iconPath: 'assets/icons/target.svg',
                  iconColor: AppColors.destructive,
                  title: 'Focus On',
                  items: focusAreas.take(3).toList(),
                  boxColor: const Color(0xFFFFE8E3),
                  textColor: AppColors.textPrimary,
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildCard({
    required String iconPath,
    required Color iconColor,
    required String title,
    required List<String> items,
    required Color boxColor,
    required Color textColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border, width: 1),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [AppColors.shadowLarge],
      ),
      padding: const EdgeInsets.all(20),
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
              const SizedBox(width: 8),
              Text(
                title,
                style: AppTypography.labelxl.copyWith(
                  color: AppColors.foreground,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Items in colored boxes
          if (items.isEmpty)
            Text(
              'No items available',
              style: AppTypography.labelmedium.copyWith(
                color: AppColors.textTertiary,
                fontSize: 11,
              ),
            )
          else
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  constraints: const BoxConstraints(minHeight: 40),
                  decoration: BoxDecoration(
                    color: boxColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Bullet point
                      Padding(
                        padding: const EdgeInsets.only(top: 3, right: 8),
                        child: Container(
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                            color: textColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      // Text content - allow full text to wrap
                      Expanded(
                        child: Text(
                          item,
                          style: AppTypography.labelmedium.copyWith(
                            color: textColor,
                            fontSize: 13,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.left,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
