import 'package:edutech_app/core/common/widgets/ai_tutor.dart';
import 'package:edutech_app/core/common/widgets/custom_appbar.dart';
import 'package:edutech_app/core/common/widgets/gradient_background.dart';
import 'package:edutech_app/core/common/widgets/great_job_card.dart';
import 'package:edutech_app/core/common/widgets/progress.dart';
import 'package:edutech_app/core/common/widgets/task_list.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/features/student/controllers/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({super.key});

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NavigationController>().onItemTapped(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold.main(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80 + MediaQuery.of(context).padding.top),
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
