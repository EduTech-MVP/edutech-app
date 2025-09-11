import 'package:flutter/material.dart';
import 'package:edutech_app/core/common/widgets/nav_item.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';

class CustomNavBottombar extends StatelessWidget {
  const CustomNavBottombar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSpacing.bottomNavHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          AppColors.DefaultShadow.copyWith(offset: const Offset(0, 0)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          NavItem(index: 0, iconPath: 'assets/images/house.svg', label: 'Home'),
          NavItem(
            index: 1,
            iconPath: 'assets/icons/book.svg',
            label: 'Lessons',
          ),
          NavItem(
            index: 2,
            iconPath: 'assets/images/people.svg',
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
