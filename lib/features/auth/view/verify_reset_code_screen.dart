import 'package:edutech_app/core/common/widgets/elevated_bottom.dart';
import 'package:edutech_app/core/common/widgets/gradient_background.dart';
import 'package:edutech_app/core/routes/app_routes.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_gradient.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/auth/controllers/forgot_password_provider.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class VerifyResetCodeScreen extends StatelessWidget {
  const VerifyResetCodeScreen({super.key});

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
                  Icons.lock_outline,
                  size: 40,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: AppSpacing.spacing32),

              // Title
              Text(
                'Enter OTP',
                style: AppTypography.heading2.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 32,
                ),
              ),

              const SizedBox(height: AppSpacing.spacing12),

              // Subtitle
              Text(
                'Enter the 6-digit code sent to',
                style: AppTypography.paragrah.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.spacing4),
              Text(
                provider.emailController.text,
                style: AppTypography.paragrah.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppSpacing.spacing56),

              // OTP Field
              Pinput(
                controller: provider.otpController,
                length: 6,
                autofocus: true,
                keyboardType: TextInputType.number,
                defaultPinTheme: PinTheme(
                  width: 50,
                  height: 60,
                  textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: AppColors.border, width: 2),
                    ),
                  ),
                ),
                focusedPinTheme: PinTheme(
                  width: 50,
                  height: 60,
                  textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: AppColors.sky700, width: 3),
                    ),
                  ),
                ),
                submittedPinTheme: PinTheme(
                  width: 50,
                  height: 60,
                  textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: AppColors.success, width: 2),
                    ),
                  ),
                ),
                errorPinTheme: PinTheme(
                  width: 50,
                  height: 60,
                  textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.error,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: AppColors.error, width: 2),
                    ),
                  ),
                ),
                showCursor: true,
                cursor: Container(
                  width: 2,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppColors.sky700,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.spacing56),

              // Verify Button
              CustomElevatedButton(
                text: provider.loading ? 'Verifying...' : 'Verify Code',
                onTap: provider.loading
                    ? null
                    : () async {
                        final success = await provider.verifyResetCode();

                        if (success && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                provider.successMessage ??
                                    'Code verified! You can now reset your password.',
                              ),
                              backgroundColor: AppColors.success,
                            ),
                          );

                          // Navigate to reset password screen
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.resetPassword,
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

              const SizedBox(height: AppSpacing.spacing32),

              // Resend Code
              Center(
                child: Column(
                  children: [
                    Text(
                      'Didn\'t receive the code?',
                      style: AppTypography.paragrah.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                    GestureDetector(
                      onTap: provider.loading
                          ? null
                          : () async {
                              final success = await provider
                                  .requestPasswordReset();

                              if (success && context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'New code sent to your email!',
                                    ),
                                    backgroundColor: AppColors.success,
                                  ),
                                );
                              }
                            },
                      child: TextButton(
                        onPressed: provider.loading
                            ? null
                            : () async {
                                final success = await provider
                                    .requestPasswordReset();

                                if (success && context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'New code sent to your email!',
                                      ),
                                      backgroundColor: AppColors.success,
                                    ),
                                  );
                                }
                              },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.spacing16,
                            vertical: AppSpacing.spacing8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppSpacing.radiusLG,
                            ),
                          ),
                        ),
                        child: Text(
                          'Resend Code',
                          style: AppTypography.paragrah.copyWith(
                            color: AppColors.sky700,
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
