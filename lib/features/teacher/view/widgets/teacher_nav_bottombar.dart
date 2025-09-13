import 'package:flutter/material.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/features/teacher/view/widgets/teacher_nav_item.dart';

class TeacherNavBottombar extends StatelessWidget {
  const TeacherNavBottombar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSpacing.bottomNavHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [AppColors.defaultShadow],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          TeacherNavItem(
            index: 0,
            iconPath: 'assets/images/house.svg',
            label: 'Home',
          ),
          TeacherNavItem(
            index: 1,
            iconPath: 'assets/icons/book.svg',
            label: 'Classes',
          ),
          TeacherNavItem(
            index: 2,
            iconPath: 'assets/images/people.svg',
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
