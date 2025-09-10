import 'package:edutech_app/core/common/widgets/custom_nav_bottombar.dart';
import 'package:edutech_app/features/child/controllers/navigation_controller.dart';
import 'package:edutech_app/features/child/views/awards_screen.dart';
import 'package:edutech_app/features/child/views/child_home.dart';
import 'package:edutech_app/features/child/views/lessons_screen.dart';
import 'package:edutech_app/features/child/views/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static final List<Widget> _pages = [
    const ChildHome(),
    const LessonsScreen(),
    const AwardsScreen(),
    const ProfileScreen(),
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
