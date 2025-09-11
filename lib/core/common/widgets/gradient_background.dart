import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class GradientScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;
  final List<Color> gradientColors;
  final AlignmentGeometry? begin;
  final AlignmentGeometry? end;

  const GradientScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.bottomNavigationBar,
    required this.gradientColors,
    this.begin,
    this.end,
  });

  GradientScaffold.auth({
    super.key,
    this.appBar,
    required this.body,
    this.bottomNavigationBar,
    this.begin,
    this.end,
  }) : gradientColors = [AppColors.gradientStart, AppColors.gradientEnd];

  // for all other app screens
  const GradientScaffold.main({
    super.key,
    this.appBar,
    required this.body,
    this.bottomNavigationBar,
    this.begin,
    this.end,
  }) : gradientColors = const [
         Color(0xFFE0F2FE),
         Color(0xFFE4F4FE),
         Color(0xFFF0F9FF),
       ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin ?? Alignment.topCenter,
          end: end ?? Alignment.bottomCenter,
          colors: gradientColors,
        ),
      ),
      child: Scaffold(
        appBar: appBar,
        body: body,
        bottomNavigationBar: bottomNavigationBar,
        backgroundColor: Colors.transparent, // Ensure transparency
      ),
    );
  }
}
