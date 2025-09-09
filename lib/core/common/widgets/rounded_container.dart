import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  final Gradient? gradient;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  const RoundedContainer({
    super.key,
    this.gradient,
    required this.child,
    this.padding,
    this.color = AppColors.sky50,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        gradient: gradient,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXXL),
        boxShadow: [AppColors.DefaultShadow],
      ),
      child: child,
    );
  }
}
