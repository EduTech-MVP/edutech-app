import 'package:edutech_app/features/child/views/child_home.dart';
import 'package:edutech_app/features/child/views/main_screen.dart';
import 'package:flutter/material.dart';
import '../../features/onboarding/view/onboarding_screen.dart';
import '../../features/auth/view/sign_up_screen.dart';
import '../../features/auth/view/sign_in_screen.dart';

class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String signUp = '/signup';
  static const String signIn = '/signin';
  static const String childhome = '/home';
  static const String mainscreen = '/mainscreen';

  static Map<String, WidgetBuilder> get routes {
    return {
      onboarding: (context) => const OnboardingScreen(),
      signUp: (context) => const SignUpScreen(),
      signIn: (context) => const SignInScreen(),
      childhome: (context) => const ChildHome(),
      mainscreen: (context) => const MainScreen(),
    };
  }
}
