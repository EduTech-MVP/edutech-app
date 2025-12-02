import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class ClassesLoadingState extends StatelessWidget {
  const ClassesLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.spacing24),
        child: CircularProgressIndicator(color: AppColors.primary500),
      ),
    );
  }
}

