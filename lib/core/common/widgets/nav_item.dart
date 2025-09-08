import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/providers/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget buildNavItem(
  BuildContext context, {
  required int index,
  required String iconPath,
  required String label,
}) {
  final navigationProvider = Provider.of<NavigationProvider>(context);
  final bool isSelected = index == navigationProvider.selectedIndex;
  final Color itemColor = isSelected ? Colors.black : AppColors.neutral500;

  return GestureDetector(
    onTap: () {
      navigationProvider.onItemTapped(index);
    },
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
