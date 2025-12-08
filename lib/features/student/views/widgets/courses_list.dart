import 'package:edutech_app/core/common/widgets/shimmer_loader_helper.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/roadmap/views/roadmap_screen.dart';
import 'package:edutech_app/features/student/controllers/student_classes_controller.dart';
import 'package:edutech_app/features/student/views/widgets/subject_course_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CoursesList extends StatefulWidget {
  const CoursesList({super.key});

  @override
  State<CoursesList> createState() => _CoursesListState();
}

class _CoursesListState extends State<CoursesList> {
  @override
  void initState() {
    super.initState();
    // Trigger fetch on load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<StudentClassesController>(
        context,
        listen: false,
      ).loadCourses();
    });
  }

  void _showJoinClassDialog() {
    showDialog(context: context, builder: (context) => const JoinClassDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentClassesController>(
      builder: (context, controller, child) {
        //  Shimmer State
        if (controller.isLoading) {
          return const ClassListShimmer();
        }

        if (controller.courses.isEmpty) {
          return const Center(child: Text("No classes found."));
        }

        //  Data State
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My classes',
                      style: AppTypography.heading1.copyWith(
                        color: AppColors.foreground,
                        fontSize: 22,
                      ),
                    ),
                    GestureDetector(
                      onTap: _showJoinClassDialog,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          boxShadow: [AppColors.shadowMedium],
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/icons/arrow_enter.svg'),
                            SizedBox(width: 8),
                            Text(
                              'Join class',
                              style: AppTypography.labelxl.copyWith(
                                color: AppColors.primaryforeground,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 18),
                ...controller.courses.map(
                  (course) => Column(
                    children: [
                      SubjectCourseCard(
                        subject: course.subject,
                        detail: course.detail,
                        progress: course.progress,
                        onContinue: () {
                          Get.to(
                            () => RoadmapScreen(
                              classId: 6,
                              subjectName: course.subject,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 36),
                    ],
                  ),
                ),
                const SizedBox(height: 64),
              ],
            ),
          ),
        );
      },
    );
  }
}

class JoinClassDialog extends StatefulWidget {
  const JoinClassDialog({super.key});

  @override
  State<JoinClassDialog> createState() => _JoinClassDialogState();
}

class _JoinClassDialogState extends State<JoinClassDialog> {
  final TextEditingController _codeController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _joinClass() async {
    final code = _codeController.text.trim();

    if (code.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter a class code',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final controller = Provider.of<StudentClassesController>(
        context,
        listen: false,
      );

      await controller.joinClass(code);

      // Close dialog
      Navigator.of(context).pop();

      // Show success message
      Get.snackbar(
        'Success',
        'Successfully joined the class',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.secondary,
        colorText: Colors.white,
      );

      // Reload courses
      controller.loadCourses();
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.sky50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Join Class',
                  style: AppTypography.heading2.copyWith(
                    color: AppColors.foreground,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: SvgPicture.asset('assets/icons/close.svg'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Class Code',
              style: AppTypography.labellarge.copyWith(
                color: AppColors.foreground,
              ),
            ),
            // const SizedBox(height: 8),
            TextField(
              controller: _codeController,
              enabled: !_isLoading,
              decoration: InputDecoration(
                hintText: 'Enter a class code',
                hintStyle: AppTypography.bodymedium.copyWith(
                  color: AppColors.mutedforeground,
                ),
                filled: true,
                fillColor: AppColors.background,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: _isLoading ? null : _joinClass,

              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),

                width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: [AppColors.shadowMedium],
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(16),
                ),

                child: _isLoading
                    ? const SizedBox(
                        height: 15,
                        width: 15,
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.background,
                          ),
                        ),
                      )
                    : Center(
                        child: Text(
                          'join class',
                          style: AppTypography.labelxl.copyWith(
                            color: AppColors.primaryforeground,
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
