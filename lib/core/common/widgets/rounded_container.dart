import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  final Gradient? gradient;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final double? width;

  final Color? color;
  final List<BoxShadow>? boxShadow;
  final Color bordercolor;
  final double borderWidth;
  const RoundedContainer({
    super.key,
    this.gradient,
    required this.child,
    this.padding,
    this.color = AppColors.primaryforeground,
    this.boxShadow = const [AppColors.defaultShadow],
    this.bordercolor = Colors.transparent,
    this.borderWidth = 0,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: padding,
      decoration: BoxDecoration(
        border: Border.all(width: borderWidth, color: bordercolor),
        color: color,
        gradient: gradient,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXXL),
        boxShadow: boxShadow,
      ),
      child: child,
    );
  }
}
