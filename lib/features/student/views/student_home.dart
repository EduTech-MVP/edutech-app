import 'package:edutech_app/core/common/widgets/ai_tutor.dart';
import 'package:edutech_app/core/common/widgets/great_job_card.dart';
import 'package:edutech_app/core/common/widgets/progress.dart';
import 'package:edutech_app/core/common/widgets/task_list.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/features/student/views/widgets/student_appbar.dart';
import 'package:flutter/material.dart';

class StudentHome extends StatelessWidget {
  const StudentHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            StudentAppbar(),
            Expanded(
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsetsGeometry.all(AppSpacing.pagePadding),
                  child: Column(
                    children: [
                      AiTutorCard(),
                      Progress(),
                      TaskList(),
                      SizedBox(height: AppSpacing.lg),

                      GreatJobCard(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
