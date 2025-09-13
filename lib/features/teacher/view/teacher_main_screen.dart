import 'package:edutech_app/features/teacher/controller/teacher_navigation_controller.dart';
import 'package:edutech_app/features/teacher/view/teacher_classes_screen.dart';
import 'package:edutech_app/features/teacher/view/teacher_home_screen.dart';
import 'package:edutech_app/features/teacher/view/teacher_profile_screen.dart';
import 'package:edutech_app/features/teacher/view/widgets/teacher_nav_bottombar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TeacherMainScreen extends StatelessWidget {
  const TeacherMainScreen({super.key});

  static final List<Widget> _pages = [
    const TeacherHomeScreen(),
    const TeacherClassesScreen(),
    const TeacherProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TeacherNavigationController>();

    return Scaffold(
      body: IndexedStack(index: controller.selectedIndex, children: _pages),
      bottomNavigationBar: const TeacherNavBottombar(),
    );
  }
}
