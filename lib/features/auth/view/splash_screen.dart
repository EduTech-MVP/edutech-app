import 'package:edutech_app/core/api/endpoints.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:edutech_app/core/cache/cache_helper.dart';
import 'package:edutech_app/core/routes/app_routes.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 2));

    final token = CacheHelper().getData(key: ApiKey.token);
    final role = CacheHelper().getData(key: ApiKey.userType);

    if (token == null) {
      Navigator.pushReplacementNamed(context, AppRoutes.signUp);
    } else {
      switch (role) {
        case ApiKey.student:
          Navigator.pushReplacementNamed(context, AppRoutes.studentmainscreen);
          break;
        case ApiKey.teacher:
          Navigator.pushReplacementNamed(context, AppRoutes.teacherMainScreen);
          break;
        case ApiKey.parent:
          Navigator.pushReplacementNamed(context, AppRoutes.parentMainScreen);
          break;
        default:
          Navigator.pushReplacementNamed(context, AppRoutes.signUp);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          'assets/images/logo.svg',
          height: AppSpacing.iconXXXL * 2,
        ),
      ),
    );
  }
}
