import 'package:edutech_app/core/common/widgets/gradient_background.dart';
import 'package:edutech_app/core/common/widgets/section_header.dart';
import 'package:edutech_app/core/common/widgets/custom_appbar.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/teacher/controller/teacher_students_controller.dart';
import 'package:edutech_app/features/teacher/model/class_model.dart';
import 'package:edutech_app/features/teacher/view/widgets/add_student_dialog.dart';
import 'package:edutech_app/features/teacher/view/widgets/student_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ClassDetailsScreen extends StatelessWidget {
  final ClassModel classData;

  const ClassDetailsScreen({super.key, required this.classData});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold.main(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          100 + MediaQuery.of(context).padding.top,
        ),
        child: _buildAppBar(context),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Main Content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.spacing24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Students Section
                      _buildStudentsSection(context),
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
    return CustomAppbar.screen(
      pageTitle: '${classData.subject} • ${classData.name}',
    );
  }

  Widget _buildStudentsSection(BuildContext context) {
    final studentsController = context.watch<TeacherStudentsController>();
    final students = studentsController.getStudentsForClass(classData.id);

    return SectionHeader(
      title: 'Manage Students',
      icon: SvgPicture.asset(
        'assets/icons/profile.svg',
        width: 32,
        height: 32,
        colorFilter: ColorFilter.mode(AppColors.sky500, BlendMode.srcIn),
      ),
      actionButtonText: 'Add Student',
      onActionPressed: () => _showAddStudentDialog(context),
      useElevatedButton: true,
      child: Padding(
        padding: const EdgeInsets.only(top: AppSpacing.spacing16),
        child: studentsController.loading
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.spacing24),
                  child: CircularProgressIndicator(color: AppColors.primary500),
                ),
              )
            : studentsController.error != null
            ? _buildErrorState(studentsController)
            : Column(
                children: students.isEmpty
                    ? [_buildEmptyState()]
                    : students.map((student) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            bottom: AppSpacing.spacing16,
                          ),
                          child: StudentCard(
                            student: student,
                            onTap: () {
                              // Navigate to student detail or show student options
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
          const Icon(Icons.people_outline, size: 64, color: AppColors.sky300),
          const SizedBox(height: AppSpacing.spacing16),
          Text('No Students Yet', style: AppTypography.heading4),
          const SizedBox(height: AppSpacing.spacing8),
          Text(
            'Add students to this class to get started',
            style: AppTypography.paragrah.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(TeacherStudentsController controller) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.spacing24),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: AppSpacing.spacing16),
          Text(
            controller.error ?? 'An error occurred',
            style: AppTypography.paragrah.copyWith(
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.spacing16),
          ElevatedButton(
            onPressed: () {
              final classId = int.tryParse(classData.id);
              if (classId != null) {
                controller.fetchClassStudents(classId);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary500,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.spacing24,
                vertical: AppSpacing.spacing12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  void _showAddStudentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddStudentDialog(classId: int.parse(classData.id)),
    );
  }
}
