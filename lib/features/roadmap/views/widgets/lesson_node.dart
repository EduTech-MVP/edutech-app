import 'dart:math' as math;
import 'package:edutech_app/features/roadmap/models/lesson_ui_model.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class LessonNode extends StatelessWidget {
  final Lesson lesson;
  final int index;
  final int totalLessons;
  final VoidCallback onTap;

  const LessonNode({
    Key? key,
    required this.lesson,
    required this.index,
    required this.totalLessons,
    required this.onTap,
  }) : super(key: key);

  // FIX: Tuned offset calculation to start with a left bias and follow a gentle curve.
  double _getHorizontalOffset(BuildContext context, int index) {
    final screenWidth = MediaQuery.of(context).size.width;
    final centerX = screenWidth * .4;

    // Amplitude: Controls how wide the path is.
    final amplitude = screenWidth * 0.18;

    // Frequency: Controls how often the path changes direction (smoother curve)
    final frequency = 0.5;

    // Phase Shift: Forces the sine wave to start at a negative value (left bias) when index is 0.
    //final phaseShift = -6;

    final offset = amplitude * math.sin((index * frequency));

    return centerX + offset - 40.0; // 47.5 is half of node width (95/2)
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: _getHorizontalOffset(context, index)),
        child: GestureDetector(
          onTap: () {
            print('Node tapped: ${lesson.title}');
            print(
              'isActive: ${lesson.isActive}, isLocked: ${lesson.isLocked}, isCompleted: ${lesson.isCompleted}',
            );
            onTap();
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: 90,
            height: 80,
            decoration: BoxDecoration(
              // shape: BoxShape.circle,
              border: GradientBoxBorder(
                width: 5,
                gradient: lesson.isLocked
                    ? LinearGradient(
                        colors: [Color(0xff949698), Color(0xff949698)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )
                    : lesson.isCompleted
                    ? const LinearGradient(
                        colors: [Color(0xFF8FE5E0), Color(0xFF89D9F0)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    // FIX: Updated gradient colors to brighter yellow/orange for active nodes
                    : const LinearGradient(
                        colors: [Color(0xffF8AD7F), Color(0xffFCCA6F)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
              ),
              borderRadius: BorderRadius.circular(55),
              gradient: lesson.isLocked
                  ? LinearGradient(
                      colors: [Color(0xff4E5661), Color(0xff4E5661)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )
                  : lesson.isCompleted
                  ? const LinearGradient(
                      colors: [Color(0xFF89D9F0), Color(0xFF8FE5E0)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  // FIX: Updated gradient colors to brighter yellow/orange for active nodes
                  : const LinearGradient(
                      colors: [Color(0xffFCCA6F), Color(0xffF8AD7F)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
              boxShadow: [
                BoxShadow(
                  color: lesson.isLocked
                      ? Color(0xff43474C)
                      : lesson.isCompleted
                      ? const Color(0xff00C8B3)
                      : const Color(0xFFF2735A),
                  spreadRadius: 2,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: lesson.isLocked
                ? Image.asset('assets/icons/lock.svg', color: Color(0xff949698))
                : lesson.isCompleted
                ? Image.asset('assets/icons/task.svg', color: Colors.white)
                : Image.asset('assets/icons/enter.svg', color: Colors.white),
          ),
        ),
      ),
    );
  }
}
