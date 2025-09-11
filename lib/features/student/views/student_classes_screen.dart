import 'package:edutech_app/core/common/widgets/custom_appbar.dart';
import 'package:edutech_app/core/common/widgets/gradient_background.dart';
import 'package:edutech_app/features/student/views/widgets/courses_list.dart';
import 'package:edutech_app/features/student/controllers/navigation_controller.dart';
import 'package:edutech_app/features/student/controllers/student_classes_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentLessons extends StatefulWidget {
  const StudentLessons({super.key});

  @override
  State<StudentLessons> createState() => _StudentLessonsState();
}

class _StudentLessonsState extends State<StudentLessons> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NavigationController>().onItemTapped(1);
      context.read<StudentClassesController>().loadCourses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold.main(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80 + MediaQuery.of(context).padding.top),
        child: const CustomAppbar.page(pageTitle: "Classes"),
      ),
      body: const CoursesList(),
    );
  }
}
