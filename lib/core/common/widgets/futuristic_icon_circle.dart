import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_gradient.dart';
import 'package:flutter/material.dart';

class FuturisticIconCircle extends StatelessWidget {
  final IconData icon;
  final double size;

  const FuturisticIconCircle({
    super.key,
    required this.icon,
    this.size = 80,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppGradients.icongold,
        border: Border.all(
          color: AppColors.borderLight.withOpacity(.5),
          width: 2,
        ),
      ),
      child: Icon(
        icon,
        size: size / 2,
        color: AppColors.textPrimary,
      ),
    );
  }
}

