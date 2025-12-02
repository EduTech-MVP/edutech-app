import 'package:edutech_app/features/teacher/model/student_model.dart';
import 'package:edutech_app/features/teacher/view/widgets/student_card.dart';
import 'package:edutech_app/features/teacher/view/student_profile_screen.dart';
import 'package:edutech_app/features/teacher/controller/teacher_student_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentsList extends StatelessWidget {
  final List<StudentModel> students;

  const StudentsList({super.key, required this.students});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: students.map((student) {
        return StudentCard(
          student: student,
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
