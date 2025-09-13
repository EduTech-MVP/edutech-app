import 'package:edutech_app/features/auth/view/sign_in_screen.dart';
import 'package:edutech_app/features/auth/views/sign_in_screen.dart';
import 'package:edutech_app/features/parent/view/children_screen.dart';
import 'package:edutech_app/features/student/views/student_home.dart';
import 'package:edutech_app/features/student/views/main_screen.dart';
import 'package:edutech_app/features/parent/view/parent_main_screen.dart';
import 'package:edutech_app/features/teacher/view/teacher_home_screen.dart';
import 'package:edutech_app/features/teacher/view/teacher_main_screen.dart';
import 'package:flutter/material.dart';
import '../../features/onboarding/view/onboarding_screen.dart';
import '../../features/auth/views/sign_up_screen.dart';

class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String signUp = '/signup';
  static const String signIn = '/signin';
  static const String studenthome = '/home';
  static const String mainscreen = '/mainscreen';
  static const String parenthome = '/homeparent';
  static const String childrescreen = '/children';
  static const String parentMainScreen = '/parent-main';
  static const String teacherHome = '/teacher-home';
  static const String teacherMainScreen = '/teacher-main';
  static const String teacherClassDetails = '/teacher-class-details';
  static const String student = '/student-home';

  static Map<String, WidgetBuilder> get routes {
    return {
      onboarding: (context) => const OnboardingScreen(),
      student: (context) => const StudentHome(),

      signUp: (context) => const SignUpScreen(),
      signIn: (context) => const SignInScreen(),
      studenthome: (context) => const StudentHome(),
      mainscreen: (context) => const MainScreen(),
      childrescreen: (context) => const ChildrenScreen(),
      parentMainScreen: (context) => const ParentMainScreen(),
      teacherHome: (context) => const TeacherHomeScreen(),
      teacherMainScreen: (context) => const TeacherMainScreen(),
    };
  }
}
