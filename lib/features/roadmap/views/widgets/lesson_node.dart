import 'dart:math' as math;
import 'package:edutech_app/features/roadmap/models/lesson_ui_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // <--- Import this
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class LessonNode extends StatelessWidget {
  final Lesson lesson;
  final int index;
  final VoidCallback onTap;

  const LessonNode({
    super.key,
    required this.lesson,
    required this.index,
    required this.onTap,
  });

  double _getHorizontalOffset(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return (screenWidth * .35) + (screenWidth * .18) * math.sin(index * .5);
  }

  Gradient get _borderGradient => lesson.isLocked
      ? const LinearGradient(colors: [Color(0xff949698), Color(0xff949698)])
      : lesson.isCompleted
      ? const LinearGradient(colors: [Color(0xFF8FE5E0), Color(0xFF89D9F0)])
      : const LinearGradient(colors: [Color(0xffF8AD7F), Color(0xffFCCA6F)]);

  Gradient get _backgroundGradient => lesson.isLocked
      ? const LinearGradient(colors: [Color(0xff4E5661), Color(0xff4E5661)])
      : lesson.isCompleted
      ? const LinearGradient(colors: [Color(0xFF89D9F0), Color(0xFF8FE5E0)])
      : const LinearGradient(colors: [Color(0xffFCCA6F), Color(0xffF8AD7F)]);

  BoxShadow get _nodeShadow => BoxShadow(
    color: lesson.isLocked
        ? const Color(0xff43474C)
        : lesson.isCompleted
        ? const Color(0xff00C8B3)
        : const Color(0xFFF2735A),
    spreadRadius: 2,
    offset: const Offset(0, 8),
  );

  Widget get _nodeIcon => SvgPicture.asset(
    lesson.isLocked
        ? 'assets/icons/lock.svg'
        : lesson.isCompleted
        ? 'assets/icons/task.svg'
        : 'assets/icons/enter.svg',
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
