import 'package:edutech_app/features/teacher/model/student_model.dart';
import 'package:edutech_app/features/teacher/view/widgets/student_card.dart';
import 'package:flutter/material.dart';

class StudentsList extends StatelessWidget {
  final List<StudentModel> students;

  const StudentsList({super.key, required this.students});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: students.map((student) {
        return StudentCard(
          student: student,
          onTap: () {
            // Navigate to student detail or show student options
          },
        );
      }).toList(),
    );
  }
}
