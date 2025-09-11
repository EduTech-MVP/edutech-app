import 'package:edutech_app/features/student/controllers/student_classes_controller.dart';
import 'package:edutech_app/features/student/view/widgets/subject_course_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoursesList extends StatelessWidget {
  const CoursesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentClassesController>(
      builder: (context, controller, child) {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                ...controller.courses.map(
                  (course) => Column(
                    children: [
                      SubjectCourseCard(
                        subject: course.subject,
                        detail: course.detail,
                        progress: course.progress,
                        onContinue: () =>
                            controller.onContinuePressed(course.subject),
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
