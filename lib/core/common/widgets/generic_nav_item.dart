import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GenericNavItem extends StatelessWidget {
  final int index;
  final String iconPath;
  final String label;
  final int selectedIndex;
  final Function(int) onTap;

  const GenericNavItem({
    super.key,
    required this.index,
    required this.iconPath,
    required this.label,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = index == selectedIndex;
    final Color itemColor = isSelected ? Colors.black : AppColors.neutral500;

    return GestureDetector(
      onTap: () => onTap(index),
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
