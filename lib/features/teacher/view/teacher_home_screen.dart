import 'package:edutech_app/core/common/widgets/gradient_background.dart';
import 'package:edutech_app/core/common/widgets/section_header.dart';
import 'package:edutech_app/core/common/widgets/custom_appbar.dart';
import 'package:edutech_app/core/routes/app_routes.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/teacher/controller/teacher_classes_controller.dart';
import 'package:edutech_app/features/teacher/view/widgets/home_class_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TeacherHomeScreen extends StatelessWidget {
  const TeacherHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold.main(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).padding.top * 2.5,
        ),
        child: _buildAppBar(context),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main Content
              Padding(
                padding: const EdgeInsets.all(AppSpacing.spacing24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Teaching Overview
                    _buildTeachingOverview(context),

                    const SizedBox(height: AppSpacing.spacing32),

                    // Classes Section
                    _buildClassesSection(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return const CustomAppbar.home(
      trailingWidget: Icon(
        Icons.notifications_outlined,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildTeachingOverview(BuildContext context) {
    final classesController = context.watch<TeacherClassesController>();

    return SectionHeader(
      title: 'Teaching Overview',
      icon: Icon(Icons.star_outline_rounded, size: 36, color: AppColors.sky500),
      showViewAll: false,
      child: Padding(
        padding: const EdgeInsets.only(top: AppSpacing.spacing16),
        child: Row(
          children: [
            _buildOverviewCard(
              title: classesController.classCount.toString(),
              subtitle: 'Classes',
              icon: Icons.school_outlined,
            ),
            const SizedBox(width: AppSpacing.spacing16),
            _buildOverviewCard(
              title: classesController.totalStudents.toString(),
              subtitle: 'Students',
              icon: Icons.people_outline,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCard({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.spacing24),
        decoration: BoxDecoration(
          color: AppColors.sky50,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.borderLight),
          boxShadow: [AppColors.defaultShadow],
        ),
        child: Column(
          children: [
            Icon(icon, size: 48, color: AppColors.sky500),
            const SizedBox(height: AppSpacing.spacing8),
            Text(title, style: AppTypography.heading3),
            Text(
              subtitle,
              style: AppTypography.paragrah.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClassesSection(BuildContext context) {
    final classesController = context.watch<TeacherClassesController>();

    return SectionHeader(
      title: 'Your Classes',
      icon: Icon(Icons.school_outlined, size: 36, color: AppColors.sky500),
      actionButtonText: 'View All',
      onActionPressed: () {
        Navigator.pushNamed(context, AppRoutes.teacherClasses);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: AppSpacing.spacing16),
        child: Column(
          children: classesController.classes.map((classData) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.spacing16),
              child: HomeClassCard(
                classData: classData,
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.teacherClassDetails);
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
