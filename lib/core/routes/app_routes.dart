import 'package:edutech_app/features/auth/views/home.dart';
import 'package:edutech_app/features/auth/views/parent_home.dart';
import 'package:edutech_app/features/auth/views/splash_screen.dart';
import 'package:edutech_app/features/auth/views/teacher_home.dart';
import 'package:flutter/material.dart';
import '../../features/onboarding/view/onboarding_screen.dart';
import '../../features/auth/views/sign_up_screen.dart';
import '../../features/auth/views/sign_in_screen.dart';

class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String signUp = '/signup';
  static const String signIn = '/signin';
  static const String splashScreen = '/splashscreen';
  static const String home = '/home';
  static const String parentHome = '/parent';
  static const String teacherHome = '/teacher';

  static Map<String, WidgetBuilder> get routes {
    return {
      onboarding: (context) => const OnboardingScreen(),
      signUp: (context) => const SignUpScreen(),
      signIn: (context) => const SignInScreen(),
      splashScreen: (context) => const SplashScreen(),
      home: (context) => const Home(),
      parentHome: (context) => const ParentHome(),
      teacherHome: (context) => const TeacherHome(),
    };
  }
}
