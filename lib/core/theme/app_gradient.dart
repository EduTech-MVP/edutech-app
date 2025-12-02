import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppGradients {
  //  Component gradients (icons, buttons, cards, etc.)
  static const LinearGradient iconBlue = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.buttonprimary, AppColors.buttonprimary],
  );

  static const LinearGradient buttonPrimary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.sky700, AppColors.sky900],
  );
  static const LinearGradient card = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.funsky, AppColors.funmint],
  );

  static const LinearGradient minttosky = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.funmint, AppColors.funsky],
  );
  static const LinearGradient grade = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.sky100, AppColors.sky50],
  );
  static const LinearGradient icongold = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.funyellow, AppColors.funcoral],
  );

  static const LinearGradient coraltoyellow = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.funcoral, AppColors.funyellow],
  );

  static const LinearGradient tapbar = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [AppColors.funsky, AppColors.buttonprimary],
  );

  static const LinearGradient red = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.topRight,
    colors: [Color(0XFFF87171), Color(0XFFEF4444)],
  );

  static const LinearGradient green = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.topRight,
    colors: [Color(0XFF4ADE80), Color(0XFF16A34A)],
  );
}
