import 'package:edutech_app/features/onboarding/controller/onboarding_provider.dart';
import 'package:edutech_app/features/student/controllers/navigation_controller.dart';
import 'package:edutech_app/features/student/controllers/task_list_controller.dart';
import 'package:edutech_app/features/student/controllers/student_classes_controller.dart';
import 'package:edutech_app/features/parent/controller/parent_navigation_controller.dart';
import 'package:edutech_app/features/teacher/controller/teacher_navigation_controller.dart';
import 'package:edutech_app/features/teacher/controller/teacher_classes_controller.dart';
import 'package:edutech_app/features/teacher/controller/teacher_students_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'core/routes/app_routes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // Student providers
        ChangeNotifierProvider(create: (_) => NavigationController()),
        ChangeNotifierProvider(create: (_) => TaskListController()),
        ChangeNotifierProvider(create: (_) => StudentClassesController()),

        // Parent providers
        ChangeNotifierProvider(create: (_) => ParentNavigationController()),

        // Teacher providers
        ChangeNotifierProvider(create: (_) => TeacherNavigationController()),
        ChangeNotifierProvider(create: (_) => TeacherClassesController()),
        ChangeNotifierProvider(create: (_) => TeacherStudentsController()),

        // Common providers
        ChangeNotifierProvider(create: (_) => OnboardingProvider()),
      ],
      child: const EduTechApp(),
    ),
  );
}

class EduTechApp extends StatelessWidget {
  const EduTechApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduTech',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.teacherMainScreen,
      routes: AppRoutes.routes,
    );
  }
}
