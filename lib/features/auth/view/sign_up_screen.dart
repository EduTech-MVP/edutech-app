import 'package:flutter/material.dart';
import '../../../core/common/widgets/gradient_background.dart';
import '../../../core/common/widgets/logo.dart';
import '../../../core/common/widgets/role_card.dart';
import '../../../core/common/widgets/custom_iconbox.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold.auth(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.spacing24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: AppSpacing.spacing64),

                // Logo Section
                const Logo(
                  firstText: "EduTech",
                  secondText: "Choose your role to get started",
                ),

                const SizedBox(height: AppSpacing.spacing32),

                // Role Selection
                Rolecard(
                  leadingIcon: const CustomIconBox(
                    icon: Icon(Icons.people_outline, color: AppColors.sky50),
                  ),
                  titleText: "Parent",
                  subtitleText: "Monitor your child's learning progress",
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/onboarding',
                      arguments: {'userType': 'Parent'},
                    );
                  },
                ),

                const SizedBox(height: AppSpacing.spacing16),

                Rolecard(
                  leadingIcon: const CustomIconBox(
                    icon: Icon(Icons.school_outlined, color: AppColors.sky50),
                  ),
                  titleText: "Teacher",
                  subtitleText: "Create and manage learning plan",
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/onboarding',
                      arguments: {'userType': 'Teacher'},
                    );
                  },
                ),

                const SizedBox(height: 86),

                // Sign In Link
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: AppTypography.paragrah,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/signin');
                      },
                      child: Text(
                        "Sign in",
                        style: AppTypography.paragrah.copyWith(
                          color: AppColors.sky700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
