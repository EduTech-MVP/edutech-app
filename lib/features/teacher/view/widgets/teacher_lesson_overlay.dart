import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_gradient.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/teacher/model/lesson_model.dart';
import 'package:edutech_app/features/teacher/view/teacher_homework_screen.dart';
import 'package:edutech_app/features/teacher/view/teacher_video_tutorial_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

void showTeacherLessonOverlay(
  BuildContext context,
  TeacherLesson lesson,
  int classId,
) {
  Get.dialog(
    TeacherLessonOverlay(lesson: lesson, classId: classId),
    barrierDismissible: true,
  );
}

class TeacherLessonOverlay extends StatelessWidget {
  final TeacherLesson lesson;
  final int classId;

  const TeacherLessonOverlay({
    super.key,
    required this.lesson,
    required this.classId,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.primaryforeground,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.borderMedium, width: 1),
          boxShadow: [AppColors.shadowMedium],
        ),
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with title and close button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Lesson ${lesson.id}: ${lesson.title}',
                      style: AppTypography.heading2,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Ghost button style close button
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/close.svg',
                        width: 16,
                        height: 16,
                        colorFilter: ColorFilter.mode(
                          AppColors.foreground,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Video Tutorial Option
              _buildLessonOption(
                icon: 'assets/icons/play.svg',
                title: 'Video Tutorial',
                subtitle: 'Watch interactive video lessons',
                gradient: AppGradients.red,
                onTap: () {
                  Get.back();
                  Get.to(
                    () => TeacherVideoTutorialScreen(
                      lesson: lesson,
                      classId: classId,
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),

              // Homework Option
              _buildLessonOption(
                icon: 'assets/icons/book.svg',
                title: 'Homework',
                subtitle: 'Complete tasks',
                gradient: AppGradients.green,
                onTap: () {
                  Get.back();
                  Get.to(
                    () =>
                        TeacherHomeworkScreen(lesson: lesson, classId: classId),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLessonOption({
    required String icon,
    required String title,
    required String subtitle,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [AppColors.shadowLarge],
        ),
        child: Row(
          children: [
            // Icon container with white overlay
            Container(
              width: 48,
              height: 48,
              padding: const EdgeInsets.all(11),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [AppColors.shadowMedium],
              ),
              child: SvgPicture.asset(
                icon,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
                width: 24,
                height: 24,
              ),
            ),
            const SizedBox(width: 12),
            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.heading4.copyWith(color: Colors.white),
                  ),
                  Text(
                    subtitle,
                    style: AppTypography.bodysmall.copyWith(
                      color: Colors.white,
                      fontSize: 12,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
