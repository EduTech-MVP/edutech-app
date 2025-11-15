import 'package:edutech_app/features/auth/view/forgot_password_screen.dart';
import 'package:edutech_app/features/auth/view/reset_password_screen.dart';
import 'package:edutech_app/features/auth/view/sign_in_screen.dart';
import 'package:edutech_app/features/auth/view/sign_up_screen.dart';
import 'package:edutech_app/features/auth/view/splash_screen.dart';
import 'package:edutech_app/features/auth/view/verify_reset_code_screen.dart';
import 'package:edutech_app/features/parent/view/children_screen.dart';
import 'package:edutech_app/features/roadmap/views/roadmap_screen.dart';
import 'package:edutech_app/features/student/views/student_home.dart';
import 'package:edutech_app/features/student/views/main_screen.dart';
import 'package:edutech_app/features/parent/view/parent_main_screen.dart';
import 'package:edutech_app/features/teacher/view/teacher_classes_screen.dart';
import 'package:edutech_app/features/teacher/view/teacher_home_screen.dart';
import 'package:edutech_app/features/teacher/view/teacher_main_screen.dart';
import 'package:flutter/material.dart';
import '../../features/onboarding/view/onboarding_screen.dart';

class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String signUp = '/signup';
  static const String signIn = '/signin';
  static const String forgotPassword = '/forgot-password';
  static const String verifyResetCode = '/verify-reset-code';
  static const String resetPassword = '/reset-password';
  static const String studenthome = '/home';
  static const String studentmainscreen = '/mainscreen';
  static const String parenthome = '/homeparent';
  static const String childrescreen = '/children';
  static const String parentMainScreen = '/parent-main';
  static const String teacherHome = '/teacher-home';
  static const String teacherMainScreen = '/teacher-main';
  static const String teacherClassDetails = '/teacher-class-details';
  static const String teacherClasses = '/teacher-classes';
  static const String splashScreen = '/splash_screen';
  static const String student = '/student-home';
  static const String roadmap = '/road-map';

  static Map<String, WidgetBuilder> get routes {
    return {
      onboarding: (context) => const OnboardingScreen(),
      student: (context) => const StudentHome(),
      splashScreen: (context) => const SplashScreen(),

      signUp: (context) => const SignUpScreen(),
      signIn: (context) => SignInScreen(),
      forgotPassword: (context) => const ForgotPasswordScreen(),
      verifyResetCode: (context) => const VerifyResetCodeScreen(),
      resetPassword: (context) => const ResetPasswordScreen(),

      studenthome: (context) => const StudentHome(),
      studentmainscreen: (context) => const MainScreen(),
      childrescreen: (context) => const ChildrenScreen(),
      parentMainScreen: (context) => const ParentMainScreen(),
      teacherHome: (context) => const TeacherHomeScreen(),
      teacherMainScreen: (context) => const TeacherMainScreen(),
      teacherClasses: (context) => const TeacherClassesScreen(),
      roadmap: (context) => const RoadmapScreen(),
    };
  }
}
