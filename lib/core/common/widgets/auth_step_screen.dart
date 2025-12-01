import 'package:edutech_app/core/common/widgets/elevated_bottom.dart';
import 'package:edutech_app/core/common/widgets/futuristic_icon_circle.dart';
import 'package:edutech_app/core/common/widgets/gradient_background.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class AuthStepScreen extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget content;
  final String buttonText;
  final VoidCallback? onButtonTap;
  final bool isLoading;
  final Widget? footer;

  const AuthStepScreen({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.content,
    required this.buttonText,
    this.onButtonTap,
    this.isLoading = false,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
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
              FuturisticIconCircle(icon: icon),

              const SizedBox(height: AppSpacing.spacing32),

              // Title
              Text(
                title,
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
                  subtitle,
                  style: AppTypography.paragrah.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: AppSpacing.spacing56),

              // Main Content
              content,

              const SizedBox(height: AppSpacing.spacing32),

              // Button
              CustomElevatedButton(
                text: buttonText,
                onTap: isLoading ? null : onButtonTap,
                width: double.infinity,
              ),

              if (footer != null) ...[
                const SizedBox(height: AppSpacing.spacing24),
                footer!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

