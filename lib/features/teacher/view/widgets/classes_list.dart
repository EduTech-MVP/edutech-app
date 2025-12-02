import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/features/teacher/controller/teacher_students_controller.dart';
import 'package:edutech_app/features/teacher/model/class_model.dart';
import 'package:edutech_app/features/teacher/view/class_details_screen.dart';
import 'package:edutech_app/features/teacher/view/widgets/class_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClassesList extends StatelessWidget {
  final List<ClassModel> classes;

  const ClassesList({super.key, required this.classes});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: classes.map((classData) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.spacing16),
          child: ClassCard(
            classData: classData,
            onTap: () async {
              final classId = int.tryParse(classData.id);
              if (classId != null) {
                await context
                    .read<TeacherStudentsController>()
                    .fetchClassStudents(classId);
              }
              if (context.mounted) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ClassDetailsScreen(classData: classData),
                  ),
                );
              }
            },
          ),
        );
      }).toList(),
    );
  }
}
