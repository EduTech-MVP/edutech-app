import 'dart:math' as math;
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_gradient.dart';
import 'package:edutech_app/features/teacher/model/lesson_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class TeacherLessonNode extends StatelessWidget {
  final TeacherLesson lesson;
  final int index;
  final VoidCallback onTap;

  const TeacherLessonNode({
    super.key,
    required this.lesson,
    required this.index,
    required this.onTap,
  });

  double _getHorizontalOffset(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return (screenWidth * .35) + (screenWidth * .18) * math.sin(index * .5);
  }

  // Updated gradients to match Figma design - fun-sky to fun-mint
  Gradient get _borderGradient => lesson.isLocked
      ? const LinearGradient(colors: [Color(0xff949698), Color(0xff949698)])
      : AppGradients.card; // fun-sky to fun-mint

  Gradient get _backgroundGradient => lesson.isLocked
      ? const LinearGradient(colors: [Color(0xff4E5661), Color(0xff4E5661)])
      : AppGradients.card; // fun-sky to fun-mint

  BoxShadow get _nodeShadow => BoxShadow(
    color: lesson.isLocked
        ? const Color(0xff43474C)
        : AppColors.funmint.withOpacity(0.5),
    spreadRadius: 2,
    offset: const Offset(0, 8),
  );

  Widget get _nodeIcon => SvgPicture.asset(
    lesson.isLocked ? 'assets/icons/lock.svg' : 'assets/icons/book.svg',
    colorFilter: ColorFilter.mode(
      lesson.isLocked ? const Color(0xff949698) : Colors.white,
      BlendMode.srcIn,
    ),
    width: 32,
    height: 32,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: _getHorizontalOffset(context)),
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: 90,
          height: 80,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: GradientBoxBorder(width: 5, gradient: _borderGradient),
            borderRadius: BorderRadius.circular(55),
            gradient: _backgroundGradient,
            boxShadow: [_nodeShadow],
          ),
          child: _nodeIcon,
        ),
      ),
    );
  }
}
