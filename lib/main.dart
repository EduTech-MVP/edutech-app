import 'package:edutech_app/features/student/controllers/navigation_controller.dart';
import 'package:edutech_app/features/student/controllers/task_list_controller.dart';
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
