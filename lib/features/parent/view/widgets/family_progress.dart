import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/parent/controller/parent_controller.dart';
import 'package:edutech_app/features/parent/model/family_progress_model.dart';
import 'package:edutech_app/features/parent/view/widgets/childern_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

/// Card showing family progress statistics (children count, classes count)
class FamilyProgressCard extends StatelessWidget {
  const FamilyProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ParentProvider>(
      builder: (context, provider, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.lg),
            _buildHeader(),
            const SizedBox(height: AppSpacing.xl),
            _buildContent(provider),
          ],
        );
      },
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/icons/cup.svg',
          height: AppSpacing.iconLG,
          colorFilter: const ColorFilter.mode(
            AppColors.sky500,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          'Family progress',
          style: AppTypography.heading3.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildContent(ParentProvider provider) {
    if (provider.loadingHome) {
      return _buildLoadingState();
    }

    if (provider.homeError != null) {
      return _buildErrorState(provider);
    }

    return _buildStatsGrid(provider);
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
              provider.homeError!,
              style: AppTypography.paragrah.copyWith(color: AppColors.error),
              textAlign: TextAlign.center,
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

  Widget _buildStatsGrid(ParentProvider provider) {
    final stats = [
      FamilyProgressModel(
        image: 'assets/icons/profile.svg',
        num: provider.numberOfChildren,
        title: 'Children',
      ),
      FamilyProgressModel(
        image: 'assets/icons/grad_cap.svg',
        num: provider.numberOfClasses,
        title: 'Classes',
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: stats.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: AppSpacing.md,
        crossAxisSpacing: AppSpacing.md,
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return FamilyCard(familyProgress: stats[index]);
      },
    );
  }
}
