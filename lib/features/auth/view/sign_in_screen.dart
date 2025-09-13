import 'package:edutech_app/core/common/widgets/custom_card.dart';
import 'package:edutech_app/core/common/widgets/custom_textformfeild.dart';
import 'package:edutech_app/core/common/widgets/elevated_bottom.dart';
import 'package:edutech_app/features/auth/controllers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../core/common/widgets/gradient_background.dart';
import '../../../core/common/widgets/logo.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      gradientColors: [AppColors.sky100, AppColors.sky300],
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
                          CustomTextFormField(
                            controller: _emailController,
                            hintText: "Enter your email or username",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!value.contains('@')) {
                                return 'Please enter a valid email';
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
                          // Password Field
                          CustomTextFormField(
                            controller: _passwordController,
                            hintText: "Enter your password",
                            obscureText: !_isPasswordVisible,
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
                          Consumer<AuthProvider>(
                            builder: (context, authProvider, child) {
                              return CustomElevatedButton(
                                text: authProvider.isLoading ? " " : "Sign in",
                                onTap: authProvider.isLoading
                                    ? null
                                    : () async {
                                        if (_formKey.currentState!.validate()) {
                                          await authProvider.login(
                                            _emailController.text,
                                            _passwordController.text,
                                          );

                                          if (authProvider.isLoggedIn) {
                                            final role = authProvider.userType;
                                            switch (role) {
                                              case 'Teacher':
                                                Navigator.pushReplacementNamed(
                                                  context,
                                                  '/teacher-main',
                                                );
                                                break;
                                              case 'Parent':
                                                Navigator.pushReplacementNamed(
                                                  context,
                                                  '/homeparent',
                                                );
                                                break;
                                              case 'Student':
                                                Navigator.pushReplacementNamed(
                                                  context,
                                                  '/student-home',
                                                );
                                                break;
                                              default:
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Unknown user role: $role',
                                                      style: AppTypography
                                                          .paragrah
                                                          .copyWith(
                                                            color:
                                                                AppColors.error,
                                                          ),
                                                    ),
                                                  ),
                                                );
                                            }
                                          } else {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  authProvider.errorMessage ??
                                                      'Login failed',
                                                  style: AppTypography.paragrah
                                                      .copyWith(
                                                        color: AppColors.error,
                                                      ),
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                      },
                                width: double.infinity,
                                leadingIcon: authProvider.isLoading
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
                              );
                            },
                          ),
                          const SizedBox(height: AppSpacing.spacing16),
                          // Display error message from the provider
                          Consumer<AuthProvider>(
                            builder: (context, authProvider, child) {
                              if (authProvider.errorMessage != null) {
                                return Center(
                                  child: Text(
                                    authProvider.errorMessage!,
                                    style: AppTypography.paragrah.copyWith(
                                      color: AppColors.error,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                          const SizedBox(height: AppSpacing.spacing16),
                          // Forgot Password Button
                          Center(
                            child: TextButton(
                              onPressed: () {
                                // TODO: Implement forgot password
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
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColors.sky800,
                    size: 16,
                  ),
                  label: Text(
                    "Back to Sign up",
                    style: AppTypography.paragrah.copyWith(
                      color: AppColors.sky800,
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
