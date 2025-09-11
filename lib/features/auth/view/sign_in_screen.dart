import 'package:edutech_app/core/common/widgets/custom_card.dart';
import 'package:edutech_app/core/common/widgets/custom_textformfeild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/common/widgets/gradient_background.dart';
import '../../../core/common/widgets/logo.dart';
import '../../../core/common/widgets/elevated_bottom.dart';
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
  final bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                          CustomElevatedButton(
                            text: "Sign in",
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                // Navigate to home or dashboard
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/home',
                                );
                              }
                            },
                            width: double.infinity,
                            leadingIcon: SvgPicture.asset(
                              'assets/icons/login.svg',
                              height: 16,
                              width: 16,
                            ),
                          ),

                          const SizedBox(height: AppSpacing.spacing16),

                          // Forgot Password Button
                          Center(
                            child: TextButton(
                              onPressed: () {
                                // Handle forgot password
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

                // Back to Sign Up Button (Outside the card)
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
