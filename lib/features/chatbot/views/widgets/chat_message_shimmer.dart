import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// Shimmer for chat messages loading
class ChatMessagesShimmer extends StatelessWidget {
  const ChatMessagesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          _buildBotMessageShimmer(context),
          SizedBox(height: 16),
          _buildUserMessageShimmer(context),
          SizedBox(height: 16),
          _buildBotMessageShimmer(context),
          SizedBox(height: 16),
          _buildUserMessageShimmer(context),
          SizedBox(height: 16),
          _buildBotMessageShimmer(context),
        ],
      ),
    );
  }

  Widget _buildBotMessageShimmer(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: AppColors.neutral200,
          highlightColor: AppColors.neutral100,
          child: CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.neutral200,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: AppColors.neutral200,
                highlightColor: AppColors.neutral100,
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                    color: AppColors.neutral200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUserMessageShimmer(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: AppColors.neutral200,
          highlightColor: AppColors.neutral100,
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(
              color: AppColors.neutral200,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        SizedBox(width: 8),
        Shimmer.fromColors(
          baseColor: AppColors.neutral200,
          highlightColor: AppColors.neutral100,
          child: CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.neutral200,
          ),
        ),
      ],
    );
  }
}

// Shimmer for history sidebar sessions
class HistorySessionsShimmer extends StatelessWidget {
  const HistorySessionsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header shimmer
          Shimmer.fromColors(
            baseColor: AppColors.neutral200,
            highlightColor: AppColors.neutral100,
            child: Container(
              height: 20,
              width: 100,
              decoration: BoxDecoration(
                color: AppColors.neutral200,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          SizedBox(height: 12),
          // Session items shimmer
          ...List.generate(
            6,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: _buildSessionItemShimmer(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSessionItemShimmer(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.neutral200,
      highlightColor: AppColors.neutral100,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.neutral200,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
