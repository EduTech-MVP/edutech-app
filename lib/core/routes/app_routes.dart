import 'package:edutech_app/features/home/view/student_classes_screen.dart';
import 'package:flutter/material.dart';
import '../../features/onboarding/view/onboarding_screen.dart';
import '../../features/auth/view/sign_up_screen.dart';
import '../../features/auth/view/sign_in_screen.dart';

class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String signUp = '/signup';
  static const String signIn = '/signin';
  static const String home = '/home';
  static const String classes = '/classes';

  static Map<String, WidgetBuilder> get routes {
    return {
      onboarding: (context) => const OnboardingScreen(),
      signUp: (context) => const SignUpScreen(),
      signIn: (context) => const SignInScreen(),
      // home: (context) => const HomeScreen(), // TODO: Create home screen
      classes: (context) => const StudentClassesScreen(),
    };
  }
}
