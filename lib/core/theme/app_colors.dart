import 'package:flutter/material.dart';

class AppColors {
  // Sky Color Palette
  static const Color sky50 = Color(0xFFF0F9FF);
  static const Color sky100 = Color(0xFFE0F2FE);
  static const Color sky200 = Color(0xFFBAE6FD);
  static const Color sky300 = Color(0xFF7DD3FC);
  static const Color sky400 = Color(0xFF38BDF8);
  static const Color sky500 = Color(0xFF0EA5E9);
  static const Color sky600 = Color(0xFF0284C7);
  static const Color sky700 = Color(0xFF0369A1);
  static const Color sky800 = Color(0xFF075985);
  static const Color sky900 = Color(0xFF0C4A6E);
  static const Color funsky = Color(0xFF86D2F9);
  static const Color funmint = Color(0xFF93ECD6);
  static const Color funyellow = Color(0xFFFFD966);
  static const Color funcoral = Color(0xFFF59B89);

  // gradient color
  static const Color gradientStart = sky200;
  static const Color gradientEnd = Color(0xFFF0F9FF);

  // Primary Colors (using Sky palette)
  static const Color primary50 = sky50;
  static const Color primary100 = sky100;
  static const Color primary200 = sky200;
  static const Color primary300 = sky300;
  static const Color primary400 = sky400;
  static const Color primary500 = sky500;
  static const Color primary600 = sky600;
  static const Color primary700 = sky700;
  static const Color primary800 = sky800;
  static const Color primary900 = sky900;

  // Neutral Colors
  static const Color neutral50 = Color(0xFFF8FAFC);
  static const Color neutral100 = Color(0xFFF1F5F9);
  static const Color neutral200 = Color(0xFFE2E8F0);
  static const Color neutral300 = Color(0xFFCBD5E1);
  static const Color neutral400 = Color(0xFF94A3B8);
  static const Color neutral500 = Color(0xFF64748B);
  static const Color neutral600 = Color(0xFF475569);
  static const Color neutral700 = Color(0xFF334155);
  static const Color neutral800 = Color(0xFF1E293B);
  static const Color neutral900 = Color(0xFF0F172A);

  // Semantic Colors
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF8FAFC);
  static const Color onBackground = Color(0xFF0F172A);
  static const Color onSurface = Color(0xFF080E0F);
  static const Color onPrimary = Color(0xFFF8FAFC);
  static const Color buttonprimary = Color(0xFF25AFF4);

  // Text Colors
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textTertiary = Color(0xFF64748B);
  static const Color textDisabled = Color(0xFF94A3B8);
  static const Color textBlack = Color(0xFF000000);
  static const Color primaryforeground = Color(0xFFFFFFFF);
  static const Color mutedtext = Color(0xFF65758B);

  // Border Colors
  static const Color border = Color(0xFFD7E0EA);
  static const Color borderLight = Color(0xFFF1F5F9);
  static const Color borderMedium = Color(0xFFCBD5E1);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = sky500;

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [sky700, sky900],
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [sky200, sky50],
  );
  //defultshadow
  static const defaultShadow = BoxShadow(
    color: Colors.black12,
    blurRadius: 10,
    spreadRadius: 2,
    offset: Offset(0, 5),
  );
  // Shadow Colors
  static const Color shadowLight = Color(0x0F080E0F);
  static const Color shadowMedium = Color(0x26080E0F);
  static const Color shadowDark = Color(0x40080E0F);
}
