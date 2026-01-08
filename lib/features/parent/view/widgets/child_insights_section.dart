import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/core/common/widgets/ai_evaluation_card.dart';
import 'package:edutech_app/features/parent/controller/parent_controller.dart';
import 'package:edutech_app/features/parent/model/child_insights_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ChildInsightsSection extends StatefulWidget {
  const ChildInsightsSection({super.key});

  @override
  State<ChildInsightsSection> createState() => _ChildInsightsSectionState();
}

class _ChildInsightsSectionState extends State<ChildInsightsSection> {
  int? _selectedChildId;

  @override
  void initState() {
    super.initState();
    // Auto-select first child if available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<ParentProvider>();
      if (provider.allChildren.isNotEmpty && _selectedChildId == null) {
        _selectedChildId = provider.allChildren.first.studentId;
        provider.fetchChildInsights(_selectedChildId!);
      }
    });
  }

  void _onChildSelected(int? childId) {
    if (childId != null && childId != _selectedChildId) {
      setState(() {
        _selectedChildId = childId;
      });
      context.read<ParentProvider>().fetchChildInsights(childId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ParentProvider>(
      builder: (context, provider, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.md),
            _buildHeader(),
            const SizedBox(height: AppSpacing.md),
            _buildChildSelector(provider),
            const SizedBox(height: AppSpacing.md),
            _buildContent(provider),
          ],
        );
      },
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.sky50,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
          ),
          child: SvgPicture.asset(
            'assets/icons/target.svg',
            width: 20,
            height: 20,
            colorFilter: const ColorFilter.mode(
              AppColors.sky600,
              BlendMode.srcIn,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Text(
          'Activity Insights',
          style: AppTypography.heading5.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildChildSelector(ParentProvider provider) {
    if (provider.allChildren.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.neutral50,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
        ),
        child: Row(
          children: [
            const Icon(Icons.info_outline, color: AppColors.neutral500),
            const SizedBox(width: AppSpacing.sm),
            Text(
              'No children available',
              style: AppTypography.bodysmall.copyWith(
                color: AppColors.neutral600,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
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
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: _selectedChildId,
          isExpanded: true,
          hint: Text(
            'Select a child',
            style: AppTypography.bodysmall.copyWith(
              color: AppColors.neutral500,
            ),
          ),
          items: provider.allChildren.map((child) {
            return DropdownMenuItem<int>(
              value: child.studentId,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage:
                        child.profilePicture.isNotEmpty &&
                            (child.profilePicture.startsWith('http://') ||
                                child.profilePicture.startsWith('https://'))
                        ? NetworkImage(child.profilePicture)
                        : null,
                    backgroundColor: AppColors.sky100,
                    child:
                        child.profilePicture.isEmpty ||
                            (!child.profilePicture.startsWith('http://') &&
                                !child.profilePicture.startsWith('https://'))
                        ? Text(
                            child.firstName.isNotEmpty
                                ? child.firstName[0].toUpperCase()
                                : 'C',
                            style: const TextStyle(
                              color: AppColors.sky600,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      child.fullName,
                      style: AppTypography.bodysmall.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: _onChildSelected,
          icon: const Icon(Icons.arrow_drop_down, color: AppColors.sky600),
        ),
      ),
    );
  }

  Widget _buildContent(ParentProvider provider) {
    if (_selectedChildId == null) {
      return _buildEmptyState('Select a child to view insights');
    }

    if (provider.loadingInsights) {
      return _buildLoadingState();
    }

    if (provider.insightsError != null) {
      return _buildErrorState(provider);
    }

    final insights = provider.selectedChildInsights;
    if (insights == null) {
      return _buildEmptyState('No insights available');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSummaryCard(insights),
        const SizedBox(height: AppSpacing.lg),
        if (insights.aiEvaluation != null)
          AIEvaluationCard(evaluation: insights.aiEvaluation!),
      ],
    );
  }

  Widget _buildSummaryCard(ChildInsights insights) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.sky500, AppColors.sky600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusXL),
        boxShadow: [
          BoxShadow(
            color: AppColors.sky500.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
            ),
            child: SvgPicture.asset(
              'assets/icons/grad_cap.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Learning Progress',
                  style: AppTypography.subtle.copyWith(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${insights.completedLessons}/${insights.totalLessons} lessons completed',
                  style: AppTypography.bodysmall.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${insights.progressPercentage.toStringAsFixed(0)}%',
                style: AppTypography.bodysmall.copyWith(
                  color: AppColors.sky600,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: const CircularProgressIndicator(color: AppColors.sky500),
      ),
    );
  }

  Widget _buildErrorState(ParentProvider provider) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                'assets/icons/info.svg',
                width: 32,
                height: 32,
                colorFilter: const ColorFilter.mode(
                  AppColors.error,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Failed to load insights',
              style: AppTypography.bodysmall.copyWith(
                color: AppColors.error,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              provider.insightsError ?? 'Unknown error',
              style: AppTypography.subtle.copyWith(color: AppColors.neutral500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton(
              onPressed: () {
                if (_selectedChildId != null) {
                  provider.fetchChildInsights(_selectedChildId!);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.sky500,
                foregroundColor: Colors.white,
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(String message) {
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
                'assets/icons/target.svg',
                width: 40,
                height: 40,
                colorFilter: const ColorFilter.mode(
                  AppColors.neutral400,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              message,
              style: AppTypography.bodysmall.copyWith(
                color: AppColors.neutral600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
