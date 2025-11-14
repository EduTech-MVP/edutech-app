import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ShadowCard extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color backgroundColor;
  final Widget child; // 1. Added required child for content
  final double shadowDepth;
  final double borderRadius;

  const ShadowCard({
    super.key,
    required this.child, // Ensure content is provided
    this.padding,
    this.margin,
    this.backgroundColor = AppColors.neutral200,
    this.shadowDepth = 50.0, // Default offset for the custom shadow
    this.borderRadius = 26.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? const EdgeInsets.only(top: 10, left: 16, right: 16),

      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: shadowDepth),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.neutral400,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
          ),

          child,
        ],
      ),
    );
  }
}
