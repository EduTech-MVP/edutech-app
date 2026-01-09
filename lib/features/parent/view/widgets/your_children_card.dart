import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/core/routes/app_routes.dart';
import 'package:edutech_app/features/parent/controller/parent_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

/// Card showing preview of children (max 2) with "View All" option
class YourChildrenCard extends StatelessWidget {
  const YourChildrenCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ParentProvider>(
      builder: (context, provider, _) {
        final children = provider.homeChildren;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.lg),
            _buildHeader(context, children.isNotEmpty),
            const SizedBox(height: AppSpacing.lg),
            _buildContent(context, provider, children),
          ],
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, bool hasChildren) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              'assets/icons/profile.svg',
              height: AppSpacing.iconLG,
              colorFilter: const ColorFilter.mode(
                AppColors.sky500,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              'Your Children',
              style: AppTypography.heading3.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        if (hasChildren) _buildViewAllButton(context),
      ],
    );
  }

  Widget _buildViewAllButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.childrescreen),
      child: Row(
        children: [
          Text(
            'View All',
            style: AppTypography.subtle.copyWith(
              color: AppColors.sky600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          const Icon(
            Icons.arrow_forward,
            color: AppColors.sky600,
            size: AppSpacing.iconSM,
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    ParentProvider provider,
    List children,
  ) {
    if (provider.loadingHome) {
      return _buildLoadingState();
    }

    if (provider.homeError != null) {
      return _buildErrorState(provider);
    }

    if (children.isEmpty) {
      return _buildEmptyState();
    }

    return _buildChildrenList(children);
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.xl),
        child: CircularProgressIndicator(color: AppColors.sky500),
      ),
    );
  }

  Widget _buildErrorState(ParentProvider provider) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            const Icon(Icons.error_outline, color: AppColors.error, size: 40),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Failed to load children data',
              style: AppTypography.paragrah.copyWith(color: AppColors.error),
            ),
            const SizedBox(height: AppSpacing.sm),
            TextButton(
              onPressed: provider.refreshHome,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.neutral50,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                'assets/icons/profile.svg',
                width: 40,
                height: 40,
                colorFilter: const ColorFilter.mode(
                  AppColors.neutral400,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'No children added yet',
              style: AppTypography.paragrah.copyWith(
                color: AppColors.neutral600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChildrenList(List children) {
    // Limit to maximum 2 children for preview
    final limitedChildren = children.take(2).toList();

    return Column(
      children: limitedChildren
          .map((child) => _ChildSummaryCard(child: child))
          .toList(),
    );
  }
}

/// Private widget for child summary card
class _ChildSummaryCard extends StatelessWidget {
  final dynamic child;

  const _ChildSummaryCard({required this.child});

  @override
  Widget build(BuildContext context) {
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
          _buildAvatar(),
          const SizedBox(width: AppSpacing.sm),
          Expanded(child: _buildChildInfo()),
          _buildPointsBadge(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    final hasImage =
        child.profileImageUrl.isNotEmpty &&
        (child.profileImageUrl.startsWith('http://') ||
            child.profileImageUrl.startsWith('https://'));
    final initial = child.childName.isNotEmpty
        ? child.childName[0].toUpperCase()
        : 'C';

    return CircleAvatar(
      radius: 20,
      backgroundImage: hasImage ? NetworkImage(child.profileImageUrl) : null,
      backgroundColor: AppColors.sky100,
      child: !hasImage
          ? Text(
              initial,
              style: const TextStyle(
                color: AppColors.sky600,
                fontWeight: FontWeight.bold,
                fontSize: 18,
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
          child.childName,
          style: AppTypography.paragrah.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xs,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: AppColors.sky50,
                borderRadius: BorderRadius.circular(AppSpacing.radiusXS),
              ),
              child: SvgPicture.asset(
                'assets/icons/book.svg',
                height: 12,
                colorFilter: const ColorFilter.mode(
                  AppColors.neutral600,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Flexible(
              child: Text(
                'Completed ${child.completedLessons} lessons',
                style: AppTypography.bodyxs.copyWith(
                  color: AppColors.neutral600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPointsBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.sky50,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
      ),
      child: Text(
        '${child.points} pts',
        style: AppTypography.bodymedium.copyWith(
          color: AppColors.sky700,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
