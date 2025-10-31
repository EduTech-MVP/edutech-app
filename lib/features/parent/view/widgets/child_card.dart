import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// Card displaying child information in the children list
class ChildCard extends StatelessWidget {
  final int studentId;
  final String name;
  final String username;
  final int grade;
  final String profileImage;
  final VoidCallback? onTap;

  const ChildCard({
    super.key,
    required this.studentId,
    required this.name,
    required this.username,
    required this.grade,
    required this.profileImage,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap ?? () => _handleTap(context),
          borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                _buildAvatar(),
                const SizedBox(width: AppSpacing.md),
                Expanded(child: _buildChildInfo()),
                _buildArrowIcon(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    final hasImage = profileImage.isNotEmpty;
    final initial = name.isNotEmpty ? name[0].toUpperCase() : 'C';

    return CircleAvatar(
      radius: 30,
      backgroundImage: hasImage ? NetworkImage(profileImage) : null,
      backgroundColor: AppColors.sky100,
      child: !hasImage
          ? Text(
              initial,
              style: const TextStyle(
                color: AppColors.sky600,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            )
          : null,
    );
  }

  Widget _buildChildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: AppTypography.heading4.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          '@$username',
          style: AppTypography.small.copyWith(color: AppColors.neutral600),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        _buildGradeBadge(),
      ],
    );
  }

  Widget _buildGradeBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.sky50,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXS),
      ),
      child: Text(
        'Grade $grade',
        style: AppTypography.small.copyWith(
          color: AppColors.sky700,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildArrowIcon() {
    return const Icon(
      Icons.arrow_forward_ios,
      color: AppColors.neutral400,
      size: 16,
    );
  }

  void _handleTap(BuildContext context) {
    // TODO: Navigate to child detail screen
    // Navigator.pushNamed(
    //   context,
    //   AppRoutes.childDetailScreen,
    //   arguments: studentId,
    // );
    debugPrint('Tapped on child: $studentId');
  }
}
