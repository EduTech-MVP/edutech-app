import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/features/student/controllers/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

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
    final provider = context.watch<NavigationController>();
    final bool isSelected = index == provider.selectedIndex;
    final Color itemColor = isSelected ? Colors.black : AppColors.neutral500;

    return GestureDetector(
      onTap: () => provider.onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconPath,
            height: AppSpacing.iconLG,
            colorFilter: ColorFilter.mode(itemColor, BlendMode.srcIn),
          ),
          Text(
            label,
            style: TextStyle(color: itemColor, fontSize: AppSpacing.lg),
          ),
        ],
      ),
    );
  }
}
