import 'package:edutech_app/core/common/widgets/ai_tutor.dart';
import 'package:edutech_app/core/common/widgets/custom_appbar.dart';
import 'package:edutech_app/core/common/widgets/gradient_background.dart';
import 'package:edutech_app/core/common/widgets/great_job_card.dart';
import 'package:edutech_app/core/common/widgets/progress.dart';
import 'package:edutech_app/core/common/widgets/task_list.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class StudentHome extends StatelessWidget {
  const StudentHome({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold.main(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).padding.top * 2.5,
        ),
        child: const CustomAppbar.home(),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.pagePadding),
          child: Column(
            children: [
              const AiTutorCard(),
              const Progress(),
              const TaskList(),
              SizedBox(height: AppSpacing.lg),
              const GreatJobCard(),
              const SizedBox(height: 64),
            ],
          ),
        ),
      ),
    );
  }
}
