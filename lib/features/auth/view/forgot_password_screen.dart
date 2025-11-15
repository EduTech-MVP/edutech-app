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

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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

              // Icon
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
                  Icons.email_outlined,
                  size: 40,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: AppSpacing.spacing32),

              // Title
              Text(
                'Forgot Password?',
                style: AppTypography.heading2.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 32,
                ),
              ),

              const SizedBox(height: AppSpacing.spacing12),

              // Subtitle
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.spacing16,
                ),
                child: Text(
                  'Enter your email address and we\'ll send you a code to reset your password',
                  style: AppTypography.paragrah.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: AppSpacing.spacing56),

              // Form Card
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.spacing16,
                ),
                decoration: BoxDecoration(
                  color: AppColors.sky50.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
                  border: Border.all(color: AppColors.borderLight, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Email Field
                    Text(
                      'Email Address',
                      style: AppTypography.subtle.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    CustomTextFormField(
                      controller: provider.emailController,
                      hintText: 'Enter your email',
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.spacing32),

              // Send Code Button
              CustomElevatedButton(
                text: provider.loading ? 'Sending...' : 'Send Reset Code',
                onTap: provider.loading
                    ? null
                    : () async {
                        final success = await provider.requestPasswordReset();

                        if (success && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                provider.successMessage ??
                                    'Reset code sent! Please check your email.',
                              ),
                              backgroundColor: AppColors.success,
                            ),
                          );

                          // Navigate to verify OTP screen
                          Navigator.pushNamed(
                            context,
                            AppRoutes.verifyResetCode,
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

              const SizedBox(height: AppSpacing.spacing24),

              // Back to Sign In
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    'Back to Sign In',
                    style: AppTypography.paragrah.copyWith(
                      color: AppColors.sky700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
