// ignore_for_file: deprecated_member_use

import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class ChildCard extends StatelessWidget {
  final String name;
  final String username;
  final int lessonsCompleted;
  final int classes;
  final int points;
  final String? profileImage;

  const ChildCard({
    super.key,
    required this.name,
    required this.username,
    required this.lessonsCompleted,
    required this.classes,
    required this.points,
    this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.sky50,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXL),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Profile, Name, Username, Points
          Row(
            children: [
              // Profile Image
              CircleAvatar(
                radius: 25,
                backgroundImage: profileImage != null
                    ? AssetImage(profileImage!)
                    : null,
                backgroundColor: AppColors.sky100,
                child: profileImage == null
                    ? Icon(Icons.person, color: AppColors.sky600, size: 30)
                    : null,
              ),

              const SizedBox(width: AppSpacing.md),

              // Name and Username
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppTypography.heading4.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      username,
                      style: AppTypography.subtle.copyWith(
                        color: AppColors.neutral500,
                      ),
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
                  '$points pts',
                  style: AppTypography.subtle.copyWith(
                    color: AppColors.sky700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.md),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Lessons Completed
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '$lessonsCompleted',
                      style: AppTypography.heading3.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Lessons Completed',
                      style: AppTypography.small.copyWith(
                        color: AppColors.neutral600,
                      ),
                    ),
                  ],
                ),
              ),

              // Classes
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '$classes',
                      style: AppTypography.heading3.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      'Classes',
                      style: AppTypography.small.copyWith(
                        color: AppColors.neutral600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
