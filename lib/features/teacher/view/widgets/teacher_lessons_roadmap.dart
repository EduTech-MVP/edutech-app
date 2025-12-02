import 'package:edutech_app/core/common/widgets/generic_empty_state.dart';
import 'package:edutech_app/core/common/widgets/generic_error_state.dart';
import 'package:edutech_app/core/common/widgets/shimmer_loader_helper.dart';
import 'package:edutech_app/features/teacher/controller/teacher_lessons_controller.dart';
import 'package:edutech_app/features/teacher/view/widgets/teacher_lesson_node.dart';
import 'package:edutech_app/features/teacher/view/widgets/teacher_lesson_overlay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class TeacherLessonsRoadmap extends StatelessWidget {
  final int classId;

  const TeacherLessonsRoadmap({
    super.key,
    required this.classId,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<TeacherLessonsController>(
      builder: (context, controller, child) {
        if (controller.isLoading) {
          return const RoadmapShimmer();
        }

        if (controller.error != null) {
          return GenericErrorState(
            error: controller.error!,
            onRetry: () => controller.loadLessons(classId),
          );
        }

        if (controller.lessons.isEmpty) {
          return const GenericEmptyState(
            icon: Icons.school_outlined,
            title: 'No Lessons Yet',
            message: 'Lessons for this class will appear here',
          );
        }

        return ListView.builder(
          reverse: true,
          padding: const EdgeInsets.symmetric(vertical: 40),
          itemCount: controller.lessons.length,
          itemBuilder: (context, index) {
            final lesson = controller.lessons[index];

            return TeacherLessonNode(
              lesson: lesson,
              index: index,
              onTap: () {
                if (!lesson.isLocked) {
                  showTeacherLessonOverlay(context, lesson, classId);
                } else {
                  Get.snackbar(
                    "Locked",
                    "Complete previous lessons first",
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
            );
          },
        );
      },
    );
  }
}

