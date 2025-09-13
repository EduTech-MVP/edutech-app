import 'package:edutech_app/features/auth/controllers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final authProvider = context.read<AuthProvider>();
    await authProvider.loadToken(); // load token & role from SharedPreferences

    await Future.delayed(const Duration(seconds: 1)); // splash delay

    if (!mounted) return;

    if (authProvider.isLoggedIn) {
      final role = authProvider.userType;

      if (role == "Teacher") {
        Navigator.pushReplacementNamed(context, '/teacher');
      } else if (role == "Parent") {
        Navigator.pushReplacementNamed(context, '/parent');
      }
    } else {
      Navigator.pushReplacementNamed(context, '/signup');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'edu tech',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
