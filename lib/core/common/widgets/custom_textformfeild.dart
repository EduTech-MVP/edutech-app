import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Color? fillColor;
  final double? height;
  final int maxlines;
  final void Function(String)? onChanged;
  final bool? enabled;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;

  const CustomTextFormField({
    super.key,
    required this.controller,
    this.hintText,
    this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.fillColor = AppColors.sky50,
    this.height = AppSpacing.buttonHeight,
    this.maxlines = 1,
    this.onChanged,
    this.enabled,
    this.textInputAction,
    this.onFieldSubmitted,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      cursorHeight: AppSpacing.lg,
      textAlign: TextAlign.justify,
      onChanged: onChanged,
      maxLines: maxlines,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      focusNode: focusNode,

      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSpacing.spacing16,
          vertical: AppSpacing.spacing12,
        ),
        hintText: hintText,
        hintStyle: AppTypography.subtle.copyWith(color: AppColors.neutral500),
        filled: true,
        fillColor: fillColor,
        prefixIcon: prefixIcon,
        prefixIconColor: AppColors.neutral500,

        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(AppColors.sky700),
        errorBorder: buildBorder(AppColors.error),
        focusedErrorBorder: buildBorder(AppColors.error),
      ),
    );
  }

  OutlineInputBorder buildBorder([color]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radiusXXL),
      borderSide: BorderSide(
        width: AppSpacing.radiusXS / 2,
        color: color ?? AppColors.neutral300,
      ),
    );
  }
}
