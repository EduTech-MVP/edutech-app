import 'package:dio/dio.dart';
import 'package:edutech_app/core/api/dio_consumer.dart';
import 'package:edutech_app/features/auth/controllers/forgot_password_provider.dart';
import 'package:edutech_app/features/auth/controllers/user_provider.dart';
import 'package:edutech_app/features/parent/controller/parent_controller.dart';
import 'package:edutech_app/features/roadmap/controller/lesson_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:edutech_app/features/onboarding/controller/onboarding_provider.dart';
import 'package:edutech_app/features/chatbot/controllers/chat_controller.dart';
import 'package:edutech_app/features/student/controllers/navigation_controller.dart';
import 'package:edutech_app/features/student/controllers/task_list_controller.dart';
import 'package:edutech_app/features/student/controllers/student_classes_controller.dart';
import 'package:edutech_app/features/parent/controller/parent_navigation_controller.dart';
import 'package:edutech_app/features/teacher/controller/teacher_navigation_controller.dart';
import 'package:edutech_app/features/teacher/controller/teacher_classes_controller.dart';
import 'package:edutech_app/features/teacher/controller/teacher_students_controller.dart';

List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider(
    create: (_) => UserProvider(api: DioConsumer(dio: Dio())),
  ),
  ChangeNotifierProvider(
    create: (_) => ForgotPasswordProvider(api: DioConsumer(dio: Dio())),
  ),
  ChangeNotifierProvider(create: (_) => NavigationController()),
  ChangeNotifierProvider(create: (_) => TaskListController()),
  ChangeNotifierProvider(create: (_) => StudentClassesController()),

  // Parent providers
  ChangeNotifierProvider(create: (_) => ParentNavigationController()),
  ChangeNotifierProvider(
    create: (_) => ParentProvider(api: DioConsumer(dio: Dio())),
  ),

  // Teacher providers
  ChangeNotifierProvider(create: (_) => TeacherNavigationController()),
  ChangeNotifierProvider(create: (_) => TeacherClassesController()),
  ChangeNotifierProvider(create: (_) => TeacherStudentsController()),
  //sstudent
  ChangeNotifierProvider(create: (_) => LessonProvider()),
  //ChangeNotifierProvider(create: (_) => HomeworkProvider()),

  // Common providers
  ChangeNotifierProvider(
    create: (_) => OnboardingProvider(
      userProvider: UserProvider(api: DioConsumer(dio: Dio())),
    ),
  ),
  ChangeNotifierProvider(
    create: (_) => ChatController(api: DioConsumer(dio: Dio())),
  ),
];
