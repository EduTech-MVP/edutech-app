import 'package:edutech_app/core/common/widgets/custom_textformfeild.dart';
import 'package:edutech_app/core/common/widgets/elevated_bottom.dart';
import 'package:edutech_app/core/common/widgets/gradient_background.dart';
import 'package:edutech_app/core/routes/app_routes.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_gradient.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/auth/controllers/forgot_password_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ForgotPasswordProvider>();

    return GradientScaffold.main(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.spacing24,
            vertical: AppSpacing.spacing56,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: AppSpacing.spacing32),

              // Futuristic Icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppGradients.icongold,
                  border: Border.all(
                    color: AppColors.borderLight.withOpacity(.5),
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.key_outlined,
                  size: 40,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: AppSpacing.spacing32),

              // Title
              Text(
                'Reset Password',
                style: AppTypography.heading2.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 32,
                ),
              ),

              const SizedBox(height: AppSpacing.spacing12),

              // Subtitle
              Text(
                'Create a strong password to secure your account',
                style: AppTypography.paragrah.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppSpacing.spacing56),

              // Form Fields - Align Left
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // New Password Field
                    Text(
                      'New Password',
                      style: AppTypography.subtle.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    CustomTextFormField(
                      controller: provider.newPasswordController,
                      hintText: 'Enter new password',
                      obscureText: true,
                    ),

                    const SizedBox(height: AppSpacing.spacing16),

                    // Confirm Password Field
                    Text(
                      'Confirm Password',
                      style: AppTypography.subtle.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    CustomTextFormField(
                      controller: provider.confirmPasswordController,
                      hintText: 'Confirm new password',
                      obscureText: true,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.spacing16),

              // Password Requirements
              Container(
                padding: const EdgeInsets.all(AppSpacing.spacing16),
                decoration: BoxDecoration(
                  color: AppColors.sky50.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
                  border: Border.all(color: AppColors.borderLight, width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Password must contain:',
                      style: AppTypography.subtle.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildRequirement('At least 9 characters'),
                    _buildRequirement('At least one uppercase letter'),
                    _buildRequirement('At least one number'),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.spacing56),

              // Reset Password Button
              CustomElevatedButton(
                text: provider.loading ? 'Resetting...' : 'Reset Password',
                onTap: provider.loading
                    ? null
                    : () async {
                        // Validate passwords
                        if (provider.newPasswordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please enter a new password'),
                              backgroundColor: AppColors.error,
                            ),
                          );
                          return;
                        }

                        if (provider.newPasswordController.text.length < 6) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Password must be at least 6 characters',
                              ),
                              backgroundColor: AppColors.error,
                            ),
                          );
                          return;
                        }

                        if (provider.newPasswordController.text !=
                            provider.confirmPasswordController.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Passwords do not match'),
                              backgroundColor: AppColors.error,
                            ),
                          );
                          return;
                        }

                        final success = await provider.resetPassword();

                        if (success && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                provider.successMessage ??
                                    'Password reset successfully!',
                              ),
                              backgroundColor: AppColors.success,
                              duration: const Duration(seconds: 3),
                            ),
                          );

                          // Clear provider data
                          provider.clear();

                          // Navigate to sign-in screen
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRoutes.signIn,
                            (route) => false,
                          );
                        } else if (provider.error != null && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(provider.error!),
                              backgroundColor: AppColors.error,
                            ),
                          );
                        }
                      },
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRequirement(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_outline,
            size: 16,
            color: AppColors.sky700,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: AppTypography.subtle.copyWith(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
