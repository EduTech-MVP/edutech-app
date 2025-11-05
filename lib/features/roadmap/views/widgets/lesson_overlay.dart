import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/roadmap/controller/lesson_provider.dart';
import 'package:edutech_app/features/roadmap/models/lesson_ui_model.dart';
import 'package:edutech_app/features/roadmap/views/video_tutorial_screen.dart';
import 'package:edutech_app/features/roadmap/views/widgets/lesson_option.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void showLessonOverlay(BuildContext context, Lesson lesson) {
  final provider = context.read<LessonProvider>();

  Get.dialog(
    LessonOverlay(
      lesson: lesson,
      onComplete: (lessonId) {
        provider.completeLesson(lessonId);
      },
    ),
    barrierDismissible: true,
  );
}

class LessonOverlay extends StatelessWidget {
  final Lesson lesson;
  final Function(int)? onComplete;

  const LessonOverlay({super.key, required this.lesson, this.onComplete});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.neutral50,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Lesson ${lesson.id}: ${lesson.title}',
                      style: AppTypography.heading2.copyWith(fontSize: 24),
                    ),
                  ),
                  GestureDetector(
                    child: Image.asset(
                      'assets/icons/close.svg',
                      width: 18,
                      height: 18,
                    ),
                    onTap: () => Get.back(),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              LessonOption(
                image: 'assets/icons/video.svg',
                title: 'Video Tutorial',
                subtitle: 'Watch interactive video lessons',
                colors: [const Color(0xFFF87070), const Color(0xFFEF4545)],
                onTap: () {
                  Get.back();
                  Get.to(() => VideoTutorialScreen(lesson: lesson));
                },
              ),
              const SizedBox(height: 16),
              LessonOption(
                image: 'assets/icons/messege.svg',
                title: 'AI Session',
                subtitle: 'Chat with AI tutor for help',
                colors: [const Color(0xFF84D1F9), const Color(0xFF28B0F4)],
                onTap: () {
                  Get.back();
                  Get.snackbar(
                    'AI Session',
                    'Opening AI tutor chat...',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.white,
                    colorText: Colors.black,
                  );
                },
              ),
              const SizedBox(height: 16),
              LessonOption(
                image: 'assets/icons/book2.svg',
                title: 'Homework',
                subtitle: 'Complete tasks',
                colors: [const Color(0xFF49DD7F), const Color(0xFF17A44B)],
                onTap: () {
                  onComplete?.call(lesson.id);
                  Get.back();
                  Get.snackbar(
                    'Homework',
                    'Lesson marked as complete!',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.white,
                    colorText: Colors.black,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
