import 'package:edutech_app/core/theme/app_gradient.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class CustomIconBox extends StatelessWidget {
  final Widget icon;
  final double size;
  final double radius;
  final Gradient gradient;

  const CustomIconBox({
    super.key,
    required this.icon,
    this.size = 56,
    this.radius = AppSpacing.radiusXXL,
    this.gradient = AppGradients.iconBlue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Center(
        child: IconTheme(data: Theme.of(context).primaryIconTheme, child: icon),
      ),
    );
  }
}
