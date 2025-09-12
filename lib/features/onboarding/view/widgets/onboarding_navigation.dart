import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/common/widgets/elevated_bottom.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../controller/onboarding_provider.dart';

class OnboardingNavigation extends StatelessWidget {
  final OnboardingProvider provider;
  final BuildContext parentContext;

  const OnboardingNavigation({
    super.key,
    required this.provider,
    required this.parentContext,
  });

  @override
  Widget build(BuildContext context) {
    final isLastStep = provider.currentStep == provider.totalSteps - 1;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.spacing24),
      child: CustomElevatedButton(
        text: isLastStep ? "Get Started" : "Continue",
        onTap: () {
          final bool success = isLastStep
              ? provider.completeOnboarding(parentContext)
              : provider.nextStep();
          if (!success) {
            _showValidationError();
          }
        },
        width: double.infinity,
        trailingIcon: SvgPicture.asset(
          'assets/icons/arrow.svg',
          height: 16,
          width: 16,
        ),
      ),
    );
  }

  void _showValidationError() {
    ScaffoldMessenger.of(parentContext).showSnackBar(
      const SnackBar(
        content: Text('Please fill in all required fields correctly'),
        backgroundColor: AppColors.error,
      ),
    );
  }
}
