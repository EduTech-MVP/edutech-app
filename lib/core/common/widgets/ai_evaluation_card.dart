import 'package:edutech_app/core/common/widgets/rounded_container.dart';
import 'package:edutech_app/core/models/ai_evaluation_model.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AIEvaluationCard extends StatelessWidget {
  final AIEvaluation evaluation;

  const AIEvaluationCard({
    super.key,
    required this.evaluation,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      padding: const EdgeInsets.all(AppSpacing.md),
      gradient: LinearGradient(
        colors: [
          AppColors.sky50,
          AppColors.sky100.withOpacity(0.5),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: const [AppColors.shadowMedium],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: AppSpacing.md),
          _buildSummary(),
          const SizedBox(height: AppSpacing.lg),
          _buildStrengths(),
          const SizedBox(height: AppSpacing.md),
          _buildAreasForImprovement(),
          const SizedBox(height: AppSpacing.md),
          _buildRecommendations(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.sky500,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
          ),
          child: SvgPicture.asset(
            'assets/icons/bot.svg',
            width: 20,
            height: 20,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'AI Evaluation',
                style: AppTypography.bodysmall.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
              Text(
                'Generated ${_formatTime(evaluation.generatedAt)}',
                style: AppTypography.subtle.copyWith(
                  color: AppColors.neutral500,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummary() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
      ),
      child: Text(
        evaluation.summary,
        style: AppTypography.paragrah.copyWith(
          color: AppColors.textPrimary,
          fontSize: 13,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildStrengths() {
    return _buildSection(
      title: 'Strengths',
      icon: 'assets/icons/star.svg',
      iconColor: AppColors.success,
      items: evaluation.strengths,
      backgroundColor: AppColors.success.withOpacity(0.1),
    );
  }

  Widget _buildAreasForImprovement() {
    return _buildSection(
      title: 'Areas for Improvement',
      icon: 'assets/icons/target.svg',
      iconColor: AppColors.warning,
      items: evaluation.areasForImprovement,
      backgroundColor: AppColors.warning.withOpacity(0.1),
    );
  }

  Widget _buildRecommendations() {
    return _buildSection(
      title: 'Recommendations',
      icon: 'assets/icons/book.svg',
      iconColor: AppColors.sky600,
      items: evaluation.recommendations,
      backgroundColor: AppColors.sky50,
    );
  }

  Widget _buildSection({
    required String title,
    required String icon,
    required Color iconColor,
    required List<String> items,
    required Color backgroundColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              icon,
              width: 16,
              height: 16,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              title,
              style: AppTypography.bodysmall.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        ...items.map((item) => _buildListItem(item, backgroundColor)),
      ],
    );
  }

  Widget _buildListItem(String text, Color backgroundColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.xs),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6, right: AppSpacing.xs),
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.sky600,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: AppTypography.subtle.copyWith(
                color: AppColors.textPrimary,
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}

