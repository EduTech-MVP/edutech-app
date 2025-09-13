import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class YourChildrenCard extends StatelessWidget {
  const YourChildrenCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data - replace with actual data from your state management
    final List<Map<String, dynamic>> children = [
      {
        'name': 'Aubrey Graham',
        'lessonsCompleted': 37,
        'points': 67,
        'profileImage': null,
      },
      {
        'name': 'Aubrey Graham',
        'lessonsCompleted': 37,
        'points': 67,
        'profileImage': null,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppSpacing.lg),

        // Header with icon and title
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/profile.svg',
                  height: AppSpacing.iconLG,
                  colorFilter: ColorFilter.mode(
                    AppColors.sky500,
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(width: AppSpacing.sm),
                Text(
                  'Your Children',
                  style: AppTypography.heading3.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.childrescreen);
              },
              child: Row(
                children: [
                  Text(
                    'View All',
                    style: AppTypography.subtle.copyWith(
                      color: AppColors.sky600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: AppSpacing.xs),
                  Icon(
                    Icons.arrow_forward,
                    color: AppColors.sky600,
                    size: AppSpacing.iconSM,
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.lg),

        // Children List
        ...children.map((child) => _buildChildSummaryCard(child)).toList(),
      ],
    );
  }

  Widget _buildChildSummaryCard(Map<String, dynamic> child) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Profile Image
          CircleAvatar(
            radius: 20,
            backgroundImage: child['profileImage'] != null
                ? AssetImage(child['profileImage'])
                : null,
            backgroundColor: AppColors.sky100,
            child: child['profileImage'] == null
                ? Icon(Icons.person, color: AppColors.sky600, size: 24)
                : null,
          ),

          const SizedBox(width: AppSpacing.sm),

          // Child Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  child['name'],
                  style: AppTypography.paragrah.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xs,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.sky50,
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusXS,
                        ),
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/book.svg',
                        height: 12,
                        colorFilter: ColorFilter.mode(
                          AppColors.neutral600,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      'Completed ${child['lessonsCompleted']} lessons',
                      style: AppTypography.small.copyWith(
                        color: AppColors.neutral600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Points
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: AppColors.sky50,
              borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
            ),
            child: Text(
              '${child['points']} pts',
              style: AppTypography.small.copyWith(
                color: AppColors.sky700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
