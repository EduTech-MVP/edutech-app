import 'package:edutech_app/core/common/widgets/custom_appbar.dart';
import 'package:edutech_app/core/common/widgets/custom_nav_bottombar.dart';
import 'package:edutech_app/core/common/widgets/gradient_background.dart';
import 'package:edutech_app/features/student/views/widgets/courses_list.dart';
import 'package:edutech_app/features/student/controllers/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class studentLessons extends StatefulWidget {
  const studentLessons({super.key});

  @override
  State<studentLessons> createState() => _studentLessonsState();
}

class _studentLessonsState extends State<studentLessons> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NavigationController>().onItemTapped(1);
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
      bottomNavigationBar: const CustomNavBottombar(),
    );
  }
}
