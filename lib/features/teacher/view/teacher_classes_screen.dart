import 'package:edutech_app/core/common/widgets/gradient_background.dart';
import 'package:edutech_app/core/common/widgets/section_header.dart';
import 'package:edutech_app/core/common/widgets/custom_appbar.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/teacher/controller/teacher_classes_controller.dart';
import 'package:edutech_app/features/teacher/view/class_details_screen.dart';
import 'package:edutech_app/features/teacher/view/widgets/add_class_dialog.dart';
import 'package:edutech_app/features/teacher/view/widgets/class_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class TeacherClassesScreen extends StatelessWidget {
  const TeacherClassesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold.main(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90 + MediaQuery.of(context).padding.top),
        child: _buildAppBar(context),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // App Bar

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.spacing24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Classes Section
                      _buildClassesSection(context),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return const CustomAppbar.page(pageTitle: 'Classes');
  }

  Widget _buildClassesSection(BuildContext context) {
    final classesController = context.watch<TeacherClassesController>();

    return SectionHeader(
      title: 'Manage Classes',
      icon: SvgPicture.asset(
        'assets/icons/grad_cap.svg',
        width: 36,
        height: 36,
        colorFilter: ColorFilter.mode(AppColors.primary500, BlendMode.srcIn),
      ),
      actionButtonText: 'Create Class',
      onActionPressed: () => _showAddClassDialog(context),
      useElevatedButton: true,
      child: Padding(
        padding: const EdgeInsets.only(top: AppSpacing.spacing16),
        child: Column(
          children: classesController.classes.isEmpty
              ? [_buildEmptyState()]
              : classesController.classes.map((classData) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: AppSpacing.spacing16,
                    ),
                    child: ClassCard(
                      classData: classData,
                      onTap: () {
                        // Navigate to class detail/students screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ClassDetailsScreen(classData: classData),
                          ),
                        );
                      },
                    ),
                  );
                }).toList(),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.spacing24),
      decoration: BoxDecoration(
        color: AppColors.sky50,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [AppColors.defaultShadow],
      ),
      child: Column(
        children: [
          const Icon(Icons.school_outlined, size: 64, color: AppColors.sky300),
          const SizedBox(height: AppSpacing.spacing16),
          Text('No Classes Yet', style: AppTypography.heading4),
          const SizedBox(height: AppSpacing.spacing8),
          Text(
            'Create your first class to get started',
            style: AppTypography.paragrah.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showAddClassDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddClassDialog(
        onAddClass: (classModel) {
          final classesController = context.read<TeacherClassesController>();
          classesController.addClass(classModel);
        },
      ),
    );
  }
}
