import 'package:edutech_app/features/student/controllers/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';

class NavItem extends StatelessWidget {
  final int index;
  final String iconPath;
  final String label;

  const NavItem({
    super.key,
    required this.index,
    required this.iconPath,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<NavigationController>();
    final bool isSelected = index == controller.selectedIndex;
    final Color itemColor = isSelected ? Colors.black : AppColors.neutral500;

    return GestureDetector(
      onTap: () => controller.onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(iconPath, height: AppSpacing.iconLG, color: itemColor),
          Text(
            label,
            style: TextStyle(color: itemColor, fontSize: AppSpacing.lg),
          ),
        ],
      ),
    );
  }
}
