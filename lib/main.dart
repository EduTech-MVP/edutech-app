import 'package:edutech_app/features/chatbot/controllers/chat_controller.dart';
import 'package:edutech_app/features/student/controllers/navigation_controller.dart';
import 'package:edutech_app/features/student/controllers/task_list_controller.dart';
import 'package:edutech_app/features/student/controllers/student_classes_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'core/routes/app_routes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationController()),
        ChangeNotifierProvider(create: (_) => TaskListController()),
        ChangeNotifierProvider(create: (_) => StudentClassesController()),
        ChangeNotifierProvider(
          create: (_) => ChatController(
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjI5IiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvZW1haWxhZGRyZXNzIjoiIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZSI6IkFobWVkIEdwZXIiLCJVc2VyVHlwZSI6IlN0dWRlbnQiLCJGaXJzdE5hbWUiOiJBaG1lZCIsIkxhc3ROYW1lIjoiR3BlciIsImV4cCI6MTc1Nzc4MzQwNCwiaXNzIjoiRWR1VGVjaEFwaSIsImF1ZCI6IkVkdVRlY2hBcGlVc2VycyJ9.QsYvO3YVFyBRINkvIsNfURwVq-F4ikakUkWvgt4Rp_4",
          ),
        ),
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
      initialRoute: AppRoutes.mainscreen,
      routes: AppRoutes.routes,
    );
  }
}
