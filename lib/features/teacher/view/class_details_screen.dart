import 'package:edutech_app/core/common/widgets/gradient_background.dart';
import 'package:edutech_app/core/common/widgets/section_header.dart';
import 'package:edutech_app/core/common/widgets/custom_appbar.dart';
import 'package:edutech_app/core/common/widgets/generic_empty_state.dart';
import 'package:edutech_app/core/common/widgets/generic_error_state.dart';
import 'package:edutech_app/core/common/widgets/generic_loading_state.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/features/student/controllers/student_classes_controller.dart';
import 'package:edutech_app/features/teacher/controller/teacher_students_controller.dart';
import 'package:edutech_app/features/teacher/model/class_model.dart';
import 'package:edutech_app/features/teacher/view/widgets/add_student_dialog.dart';
import 'package:edutech_app/features/teacher/view/widgets/custom_tab_bar.dart';
import 'package:edutech_app/features/teacher/view/widgets/students_list.dart';
import 'package:edutech_app/features/teacher/view/widgets/teacher_lessons_roadmap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ClassDetailsScreen extends StatefulWidget {
  final ClassModel classData;

  const ClassDetailsScreen({super.key, required this.classData});

  @override
  State<ClassDetailsScreen> createState() => _ClassDetailsScreenState();
}

class _ClassDetailsScreenState extends State<ClassDetailsScreen> {
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    // Load lessons when tab is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<StudentClassesController>(
        context,
        listen: false,
      ).loadCourses();
    });
  }

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
            // Tab Bar
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.spacing24,
                vertical: AppSpacing.spacing16,
              ),
              child: CustomTabBar(
                selectedIndex: _selectedTabIndex,
                onTabSelected: (index) {
                  setState(() {
                    _selectedTabIndex = index;
                  });
                },
                tabs: const ['Students', 'Lessons'],
              ),
            ),
            // Main Content
            Expanded(
              child: _selectedTabIndex == 0
                  ? SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.spacing24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [_buildStudentsSection(context)],
                        ),
                      ),
                    )
                  : _buildLessonsSection(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return CustomAppbar.witharrow(
      pageTitle: '${widget.classData.subject} • ${widget.classData.name}',
      onBackPressed: () => Navigator.pop(context),
    );
  }

  Widget _buildStudentsSection(BuildContext context) {
    final studentsController = context.watch<TeacherStudentsController>();
    final students = studentsController.getStudentsForClass(
      widget.classData.id,
    );
    final classId = int.tryParse(widget.classData.id);

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
            ? const GenericLoadingState(message: 'Loading students...')
            : studentsController.error != null
            ? GenericErrorState(
                error: studentsController.error!,
                onRetry: () =>
                    studentsController.fetchClassStudents(classId ?? 0),
              )
            : students.isEmpty
            ? const GenericEmptyState(
                icon: Icons.people_outline,
                title: 'No Students Yet',
                message: 'Add students to this class to get started',
              )
            : StudentsList(students: students),
      ),
    );
  }

  Widget _buildLessonsSection(BuildContext context) {
    final classId = int.tryParse(widget.classData.id);
    if (classId == null) {
      return const GenericEmptyState(
        icon: Icons.error_outline,
        title: 'Invalid Class',
        message: 'Unable to load lessons for this class',
      );
    }
    return TeacherLessonsRoadmap(classId: classId);
  }

  void _showAddStudentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) =>
          AddStudentDialog(classId: int.parse(widget.classData.id)),
    );
  }
}
