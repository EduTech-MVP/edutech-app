import 'package:edutech_app/core/common/widgets/custom_appbar.dart';
import 'package:edutech_app/core/common/widgets/gradient_background.dart';
import 'package:edutech_app/features/student/views/widgets/courses_list.dart';
import 'package:flutter/material.dart';

class StudentLessons extends StatelessWidget {
  const StudentLessons({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold.main(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).padding.top * 2.5,
        ),
        child: const CustomAppbar.page(pageTitle: "Classes"),
      ),
      body: const CoursesList(),
    );
  }
}
