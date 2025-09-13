import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppGradients {
  //  Component gradients (icons, buttons, cards, etc.)
  static const LinearGradient iconBlue = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.sky700, AppColors.sky900],
  );

  static const LinearGradient buttonPrimary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.sky700, AppColors.sky900],
  );
  static const LinearGradient card = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.sky200, AppColors.sky100],
  );

  static const LinearGradient grade = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.sky100, AppColors.sky50],
  );
}
