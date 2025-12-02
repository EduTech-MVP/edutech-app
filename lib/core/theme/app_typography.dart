import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTypography {
  // Update to use Fredoka
  static TextStyle get heading1 => TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.0,
    letterSpacing: -0.012,
    color: AppColors.textPrimary,
  );

  static TextStyle get heading2 => TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.0075,
    color: AppColors.textPrimary,
  );

  static TextStyle get heading3 => TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 18,
    fontWeight: FontWeight.w700,
    height: 1.33,
    letterSpacing: -0.006,
    color: AppColors.textPrimary,
  );

  static TextStyle get heading4 => TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 1.4,
    letterSpacing: -0.005,
    color: AppColors.textPrimary,
  );

  static TextStyle get heading5 => TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.4,
    letterSpacing: -0.005,
    color: AppColors.textPrimary,
  );

  static TextStyle get heading6 => TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 12,
    fontWeight: FontWeight.w700,
    height: 1.4,
    letterSpacing: -0.005,
    color: AppColors.textPrimary,
  );

  //XL

  static TextStyle get xxxxl => TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 72,
    fontWeight: FontWeight.w700,
    height: 1.16,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  static TextStyle get xxxl => TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 64,
    fontWeight: FontWeight.w700,
    height: 1.125,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  static TextStyle get xxl => TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 56,
    fontWeight: FontWeight.w700,
    height: 1.4,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  static TextStyle get xl => TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 48,
    fontWeight: FontWeight.w700,
    height: 1.6,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  //label
  static TextStyle get labelxl => TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 1.375,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  static TextStyle get labellarge => TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.42,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  static TextStyle get labelmedium => TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 12,
    fontWeight: FontWeight.w700,
    height: 1.5,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  static TextStyle get labelsmall => TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 11,
    fontWeight: FontWeight.w700,
    height: 1.45,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  //paragraph
  static TextStyle get paragrah => TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  //caption
  static TextStyle get caption => TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  //overline
  static TextStyle get overline => TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 10,
    fontWeight: FontWeight.w600,
    height: 1.6,
    letterSpacing: 0,
    color: AppColors.textPrimary,
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

  //Large, medium  and Small
  static TextStyle get large => TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 40,
    fontWeight: FontWeight.w700,
    height: 1.2,
    color: AppColors.textBlack,
  );

  static TextStyle get medium => TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.25,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  static TextStyle get small => TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.28,
    color: AppColors.textBlack, //change this
  );

  //body
  static TextStyle get bodyxl => TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  static TextStyle get bodylarge => TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  static TextStyle get bodymedium => TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  static TextStyle get bodysmall => TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  static TextStyle get bodyxs => TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 1.45,
    letterSpacing: 0,
    color: AppColors.textPrimary,
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
