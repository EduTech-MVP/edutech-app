import 'package:edutech_app/core/models/student_flag.dart';
import 'package:edutech_app/features/teacher/model/student_model.dart';
import 'package:edutech_app/features/teacher/view/widgets/student_card.dart';
import 'package:edutech_app/features/teacher/view/student_profile_screen.dart';
import 'package:edutech_app/features/teacher/controller/teacher_student_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentsList extends StatelessWidget {
  final List<StudentModel> students;

  const StudentsList({super.key, required this.students});

  // Calculate student flags based on performance
  Map<String, StudentFlag> _calculateStudentFlags() {
    if (students.isEmpty) return {};

    // Sort students by performance (completed lessons, then points)
    final sortedStudents = List<StudentModel>.from(students)
      ..sort((a, b) {
        // Primary sort by completed lessons
        final lessonComparison = b.completedLessons.compareTo(a.completedLessons);
        if (lessonComparison != 0) return lessonComparison;
        // Secondary sort by points
        return b.points.compareTo(a.points);
      });

    final flags = <String, StudentFlag>{};
    final totalStudents = sortedStudents.length;

    if (totalStudents == 0) return flags;

    // Calculate thresholds for different levels
    // Excellent: Top 20%
    final excellentCount = (totalStudents * 0.2).ceil();
    final excellentCountFinal = excellentCount < 1 ? 1 : excellentCount;
    for (int i = 0; i < excellentCountFinal && i < totalStudents; i++) {
      flags[sortedStudents[i].id] = StudentFlag.excellent;
    }

    // Good: Next 30%
    final goodStart = excellentCountFinal;
    final goodCount = (totalStudents * 0.3).ceil();
    final goodEnd = (goodStart + goodCount).clamp(0, totalStudents);
    for (int i = goodStart; i < goodEnd && i < totalStudents; i++) {
      if (!flags.containsKey(sortedStudents[i].id)) {
        flags[sortedStudents[i].id] = StudentFlag.good;
      }
    }

    // Average: Next 30%
    final averageStart = goodEnd;
    final averageCount = (totalStudents * 0.3).ceil();
    final averageEnd = (averageStart + averageCount).clamp(0, totalStudents);
    for (int i = averageStart; i < averageEnd && i < totalStudents; i++) {
      if (!flags.containsKey(sortedStudents[i].id)) {
        flags[sortedStudents[i].id] = StudentFlag.average;
      }
    }

    // Needs assistance: Bottom 20%
    final needsAssistanceCount = (totalStudents * 0.2).ceil();
    final needsAssistanceStart = (totalStudents - needsAssistanceCount).clamp(0, totalStudents);
    for (int i = needsAssistanceStart; i < totalStudents; i++) {
      if (!flags.containsKey(sortedStudents[i].id)) {
        flags[sortedStudents[i].id] = StudentFlag.needsAssistance;
      }
    }

    // All others are normal (default)
    for (final student in students) {
      if (!flags.containsKey(student.id)) {
        flags[student.id] = StudentFlag.normal;
      }
    }

    return flags;
  }

  @override
  Widget build(BuildContext context) {
    final studentFlags = _calculateStudentFlags();

    return Column(
      children: students.map((student) {
        return StudentCard(
          student: student,
          flag: studentFlags[student.id] ?? StudentFlag.normal,
          onTap: () async {
            final studentIdInt = int.tryParse(student.id);
            if (studentIdInt != null) {
              final controller = context.read<TeacherStudentProfileController>();
              await controller.fetchStudentProfile(studentIdInt);
            }
            if (context.mounted) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => StudentProfileScreen(
                    studentId: student.id,
                    studentName: student.name,
                  ),
                ),
              );
            }
          },
        );
      }).toList(),
    );
  }
}
