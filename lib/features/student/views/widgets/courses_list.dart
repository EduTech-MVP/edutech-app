import 'package:edutech_app/core/common/widgets/shimmer_loader_helper.dart';
import 'package:edutech_app/features/roadmap/views/roadmap_screen.dart';
import 'package:edutech_app/features/student/controllers/student_classes_controller.dart';
import 'package:edutech_app/features/student/views/widgets/subject_course_card.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentClassesController>(
      builder: (context, controller, child) {
        // 1. Shimmer State
        if (controller.isLoading) {
          return const ClassListShimmer();
        }

        // 2. Empty State (Optional)
        if (controller.courses.isEmpty) {
          return const Center(child: Text("No classes found."));
        }

        // 3. Data State
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
