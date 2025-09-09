import 'package:edutech_app/core/common/widgets/nav_item.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class CustomNavBottombar extends StatelessWidget {
  const CustomNavBottombar({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSpacing.bottomNavHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white.withOpacity(.1), Colors.white],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildNavItem(
            context,
            index: 0,
            iconPath: 'assets/images/house.svg',
            label: 'Home',
          ),
          buildNavItem(
            context,
            index: 1,
            iconPath: 'assets/images/book.svg',
            label: 'Lessons',
          ),
          buildNavItem(
            context,
            index: 2,
            iconPath: 'assets/images/award.svg',
            label: 'Awards',
          ),
          buildNavItem(
            context,
            index: 3,
            iconPath: 'assets/images/people.svg',
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
