import 'package:edutech_app/core/common/widgets/custom_nav_bottombar.dart';
import 'package:edutech_app/features/student/controllers/navigation_controller.dart';
import 'package:edutech_app/features/student/views/awards_screen.dart';
import 'package:edutech_app/features/student/views/student_classes_screen.dart';
import 'package:edutech_app/features/student/views/student_home.dart';
import 'package:edutech_app/features/student/views/student_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static final List<Widget> _pages = [
    const StudentHome(),
    const studentLessons(),
    const AwardsScreen(),
    const StudentProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<NavigationController>();

    return Scaffold(
      body: IndexedStack(index: controller.selectedIndex, children: _pages),
      bottomNavigationBar: const CustomNavBottombar(),
    );
  }
}
