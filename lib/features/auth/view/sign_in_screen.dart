// ignore_for_file: use_build_context_synchronously

import 'package:edutech_app/core/api/endpoints.dart';
import 'package:edutech_app/core/common/widgets/custom_card.dart';
import 'package:edutech_app/core/common/widgets/custom_textformfeild.dart';
import 'package:edutech_app/core/common/widgets/elevated_bottom.dart';
import 'package:edutech_app/core/common/widgets/gradient_background.dart';
import 'package:edutech_app/core/common/widgets/logo.dart';
import 'package:edutech_app/core/routes/app_routes.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/auth/controllers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    return GradientScaffold.auth(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.spacing24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                // Logo Section
                const Logo(
                  firstText: "Welcome Back",
                  secondText: "Sign in to continue learning",
                ),

                const SizedBox(height: 40),

                // Form Card
                CustomCard(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.spacing24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Email Label
                          Text(
                            "Email Address/Username",
                            style: AppTypography.subtle.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),

                          // Email field
                          CustomTextFormField(
                            controller: userProvider.signInEmail,
                            hintText: "Enter your email or username",
                            enabled: !userProvider.loading,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),

                          // Password Label
                          Text(
                            "Password",
                            style: AppTypography.lead.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),

                          // Password field
                          CustomTextFormField(
                            controller: userProvider.signInPassword,
                            hintText: "Enter your password",
                            obscureText: true,
                            enabled: !userProvider.loading,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: AppSpacing.spacing56),

                          // Sign In Button
                          CustomElevatedButton(
                            text: userProvider.loading ? "" : "Sign in",
                            onTap: userProvider.loading
                                ? null
                                : () async {
                                    if (_formKey.currentState!.validate()) {
                                      final success = await userProvider
                                          .signin();

                                      if (success &&
                                          userProvider.profile != null) {
                                        // Get user type from profile
                                        final userType =
                                            userProvider.profile!.userType;

                                        // Navigate based on user type
                                        if (userType == ApiKey.student) {
                                          Navigator.pushReplacementNamed(
                                            context,
                                            AppRoutes.studentmainscreen,
                                          );
                                        } else if (userType == ApiKey.teacher) {
                                          Navigator.pushReplacementNamed(
                                            context,
                                            AppRoutes.teacherMainScreen,
                                          );
                                        } else if (userType == ApiKey.parent) {
                                          Navigator.pushReplacementNamed(
                                            context,
                                            AppRoutes.parentMainScreen,
                                          );
                                        } else {
                                          // Handle unknown user type
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Unknown user type. Please contact support.',
                                                style: AppTypography.paragrah
                                                    .copyWith(
                                                      color: Colors.white,
                                                    ),
                                              ),
                                              backgroundColor: AppColors.error,
                                            ),
                                          );
                                        }
                                      } else if (userProvider.error != null) {
                                        // Show error snackbar
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              userProvider.error!,
                                              style: AppTypography.paragrah
                                                  .copyWith(
                                                    color: Colors.white,
                                                  ),
                                            ),
                                            backgroundColor: AppColors.error,
                                            duration: const Duration(
                                              seconds: 4,
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                  },
                            width: double.infinity,
                            leadingIcon: userProvider.loading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : SvgPicture.asset(
                                    'assets/icons/login.svg',
                                    height: 16,
                                    width: 16,
                                  ),
                          ),

                          const SizedBox(height: AppSpacing.spacing16),

                          // Display error message from the provider
                          if (userProvider.error != null)
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.error.withAlpha(1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: AppColors.error.withAlpha(3),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    color: AppColors.error,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      userProvider.error!,
                                      style: AppTypography.paragrah.copyWith(
                                        color: AppColors.error,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          const SizedBox(height: AppSpacing.spacing16),

                          // Forgot Password Button
                          Center(
                            child: TextButton(
                              onPressed: () {
                                // TODO: Navigate to forgot password screen
                              },
                              child: Text(
                                "Forgot your password?",
                                style: AppTypography.paragrah.copyWith(
                                  color: AppColors.sky600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.spacing24),

                // Back to Sign Up Button
                TextButton.icon(
                  onPressed: userProvider.loading
                      ? null
                      : () {
                          // Clear form and errors
                          userProvider.signInEmail.clear();
                          userProvider.signInPassword.clear();
                          context.read<UserProvider>().error = null;
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.signUp,
                          );
                        },
                  icon: Icon(
                    Icons.arrow_back,
                    color: userProvider.loading
                        ? AppColors.neutral400
                        : AppColors.sky800,
                    size: 16,
                  ),
                  label: Text(
                    "Back to Sign up",
                    style: AppTypography.paragrah.copyWith(
                      color: userProvider.loading
                          ? AppColors.neutral400
                          : AppColors.sky800,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
