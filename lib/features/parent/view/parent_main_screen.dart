import 'package:edutech_app/features/parent/controller/parent_navigation_controller.dart';
import 'package:edutech_app/features/parent/view/children_screen.dart';
import 'package:edutech_app/features/parent/view/parent_home.dart';
import 'package:edutech_app/features/parent/view/parent_profile_screen.dart';
import 'package:edutech_app/features/parent/view/widgets/parent_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ParentMainScreen extends StatelessWidget {
  const ParentMainScreen({super.key});

  static final List<Widget> _pages = [
    const ParentHome(),
    const ChildrenScreen(),
    const ParentProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ParentNavigationController>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: IndexedStack(index: controller.selectedIndex, children: _pages),
      bottomNavigationBar: const ParentCustomBar(),
    );
  }
}
