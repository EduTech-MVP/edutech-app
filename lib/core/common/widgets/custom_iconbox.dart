import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class CustomIconBox extends StatelessWidget {
  final Widget icon;
  final double size;
  final double radius;
  final Color backgroundColor;

  const CustomIconBox({
    super.key,
    required this.icon,
    this.size = 56,
    this.radius = AppSpacing.radiusXXL,
    this.backgroundColor = AppColors.sky700,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: IconTheme(data: Theme.of(context).primaryIconTheme, child: icon),
    );
  }
}
