import 'package:flutter/material.dart';
import 'package:edutech_app/core/common/widgets/generic_nav_item.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/features/parent/controller/parent_navigation_controller.dart';
import 'package:provider/provider.dart';

class ParentCustomBar extends StatelessWidget {
  const ParentCustomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ParentNavigationController>();

    return Container(
      height: AppSpacing.bottomNavHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [AppColors.defaultShadow],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GenericNavItem(
            index: 0,
            iconPath: 'assets/images/house.svg',
            label: 'Home',
            selectedIndex: controller.selectedIndex,
            onTap: controller.onItemTapped,
          ),
          GenericNavItem(
            index: 1,
            iconPath: 'assets/icons/profile.svg',
            label: 'Children',
            selectedIndex: controller.selectedIndex,
            onTap: controller.onItemTapped,
          ),
          GenericNavItem(
            index: 2,
            iconPath: 'assets/images/people.svg',
            label: 'Profile',
            selectedIndex: controller.selectedIndex,
            onTap: controller.onItemTapped,
          ),
        ],
      ),
    );
  }
}
