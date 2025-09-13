import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/teacher/controller/teacher_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class TeacherNavItem extends StatelessWidget {
  final int index;
  final String iconPath;
  final String label;

  const TeacherNavItem({
    super.key,
    required this.index,
    required this.iconPath,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TeacherNavigationController>();
    final isSelected = controller.selectedIndex == index;

    return GestureDetector(
      onTap: () {
        context.read<TeacherNavigationController>().onItemTapped(index);
      },
      child: Container(
        width: 64,
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.spacing8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              height: 24,
              width: 24,
              colorFilter: ColorFilter.mode(
                isSelected ? Colors.black : AppColors.neutral500,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: AppSpacing.spacing4),
            Text(
              label,
              style: AppTypography.subtle.copyWith(
                color: isSelected ? Colors.black : AppColors.neutral500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
