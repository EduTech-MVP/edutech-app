import 'package:edutech_app/core/common/widgets/custom_textformfeild.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// Reusable form field with label
class AddChildFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final bool enabled;
  final TextInputType keyboardType;
  final Widget? prefixIcon;

  const AddChildFormField({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.validator,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.paragrah.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        CustomTextFormField(
          controller: controller,
          hintText: hintText,
          obscureText: obscureText,
          enabled: enabled,
          validator: validator,
          keyboardType: keyboardType,
          prefixIcon: prefixIcon,
        ),
      ],
    );
  }
}
