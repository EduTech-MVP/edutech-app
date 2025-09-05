import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTypography {
  // Update to use Fredoka
  static TextStyle get heading1 => TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 48,
    fontWeight: FontWeight.bold,
    height: 1.0,
    letterSpacing: -0.012,
    color: AppColors.textPrimary,
  );

  static TextStyle get heading2 => TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 30,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: -0.0075,
    color: AppColors.textPrimary,
  );

  static TextStyle get heading3 => TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.33,
    letterSpacing: -0.006,
    color: AppColors.textPrimary,
  );

  static TextStyle get heading4 => TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.4,
    letterSpacing: -0.005,
    color: AppColors.textPrimary,
  );

  //paragraph
  static TextStyle get paragrah => TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 2.4,
  );

  // Blockquote
  static TextStyle get blockquote => TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 2.4,
    color: AppColors.textPrimary,
  );

  // Table Styles
  static TextStyle get tableHeader => TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 2.4,
    color: AppColors.textPrimary,
  );

  static TextStyle get tableItem => TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 2.4,
    color: AppColors.textPrimary,
  );

  // List Styles
  static TextStyle get listItem => TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 2.4,
    color: AppColors.textPrimary,
  );

  // Code Styles
  static TextStyle get codeInline => TextStyle(
    fontFamily: 'CascadiaCode',
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 2.0,
    color: AppColors.textBlack,
  );

  // Lead Text
  static TextStyle get lead => TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 20,
    fontWeight: FontWeight.w400,
    height: 2.8,
    color: AppColors.textPrimary,
  );
  //Large and Small
  static TextStyle get large => TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 2.8,
    color: AppColors.textBlack,
  );
  static TextStyle get small => TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: AppColors.textBlack, //change this
  );

  //  Subtle Text

  static TextStyle get subtle => TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 2.0,
    color: AppColors.textTertiary,
  );

  // Override methods for different colors
  static TextStyle heading1WithColor(Color color) =>
      heading1.copyWith(color: color);
  static TextStyle heading2WithColor(Color color) =>
      heading2.copyWith(color: color);
  static TextStyle heading3WithColor(Color color) =>
      heading3.copyWith(color: color);
  static TextStyle heading4WithColor(Color color) =>
      heading4.copyWith(color: color);
}
