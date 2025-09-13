import 'package:edutech_app/core/common/widgets/gradient_background.dart';
import 'package:edutech_app/core/common/widgets/custom_appbar.dart';
import 'package:edutech_app/core/common/widgets/profile_achievements_card.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/teacher/controller/teacher_classes_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TeacherProfileScreen extends StatelessWidget {
  const TeacherProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold.main(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90 + MediaQuery.of(context).padding.top),
        child: _buildAppBar(context),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Card
              _buildProfileCard(context),

              // Stats
              _buildStatsSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return const CustomAppbar.page(
      pageTitle: 'Profile',
      trailingWidget: Icon(
        Icons.settings_outlined,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.spacing32),
      margin: const EdgeInsets.all(AppSpacing.spacing24),
      decoration: BoxDecoration(
        color: AppColors.sky50,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [AppColors.defaultShadow],
      ),
      child: Column(
        children: [
          // Profile Image
          Stack(
            children: [
              const CircleAvatar(
                radius: 64,
                backgroundImage: AssetImage(
                  'assets/images/profile_placeholder.png',
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  height: 24,
                  width: 24,
                  padding: const EdgeInsets.all(AppSpacing.spacing4),
                  decoration: BoxDecoration(
                    color: AppColors.sky50,
                    shape: BoxShape.circle,
                    boxShadow: [AppColors.defaultShadow],
                  ),
                  child: const Icon(
                    Icons.camera_enhance_outlined,
                    color: AppColors.sky700,
                    size: 12,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.spacing16),

          // Name and Username
          Text('Aubrey Graham', style: AppTypography.heading3),
          Text(
            '@certifiedloverboy',
            style: AppTypography.subtle.copyWith(color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    final classesController = context.watch<TeacherClassesController>();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.spacing24),
      child: Row(
        children: [
          ProfileAchievementsCard(
            image: 'assets/icons/book.svg',
            num: 37,
            acheive: 'Lessons Created',
          ),
          const SizedBox(width: AppSpacing.spacing16),
          ProfileAchievementsCard(
            image: 'assets/icons/grad_cap.svg',
            num: classesController.classCount,
            acheive: 'Classes',
          ),
        ],
      ),
    );
  }
}
