import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../core/common/widgets/gradient_background.dart';
import '../../../core/common/widgets/elevated_bottom.dart';
import '../../../core/common/widgets/linear_progress.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../controller/onboarding_provider.dart';
import 'widgets/onboarding_page.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve userType from route arguments
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final userType = args?['userType'] as String?;

    // Set userType in provider
    final provider = Provider.of<OnboardingProvider>(context, listen: false);
    if (userType != null && provider.data.userType == null) {
      provider.updateUserType(userType);
    }

    return GradientScaffold.auth(
      body: SafeArea(
        child: Column(
          children: [
            // Header with Back Button and Progress
            Padding(
              padding: const EdgeInsets.all(AppSpacing.spacing24),
              child: Column(
                children: [
                  Consumer<OnboardingProvider>(
                    builder: (context, provider, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (provider.currentStep > 0)
                            GestureDetector(
                              onTap: () {
                                provider.previousStep();
                              },
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.arrow_back,
                                    color: AppColors.sky800,
                                    size: 20,
                                  ),
                                  const SizedBox(width: AppSpacing.spacing8),
                                  Text(
                                    "Back",
                                    style: AppTypography.paragrah.copyWith(
                                      color: AppColors.sky800,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          else
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.arrow_back,
                                    color: AppColors.sky800,
                                    size: 20,
                                  ),
                                  const SizedBox(width: AppSpacing.spacing8),
                                  Text(
                                    "Back",
                                    style: AppTypography.paragrah.copyWith(
                                      color: AppColors.sky800,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          Text(
                            "${provider.currentStep + 1} of ${provider.totalSteps}",
                            style: AppTypography.subtle.copyWith(
                              color: AppColors.sky900,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: AppSpacing.spacing16),

                  // Progress Bar
                  LinearProgress(
                    value: (provider.currentStep + 1) / provider.totalSteps,
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.spacing16),

            // PageView
            Expanded(
              child: PageView.builder(
                controller: provider.pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  provider.updateCurrentStep(index);
                },
                itemCount: provider.totalSteps,
                itemBuilder: (context, index) {
                  return OnboardingPage(
                    data: provider.uiModel.onboardingData[index],
                  );
                },
              ),
            ),

            // Bottom Continue Button
            Padding(
              padding: const EdgeInsets.all(AppSpacing.spacing24),
              child: CustomElevatedButton(
                text: provider.currentStep == provider.totalSteps - 1
                    ? "Get Started"
                    : "Continue",
                onTap: () {
                  if (provider.currentStep == provider.totalSteps - 1) {
                    provider.completeOnboarding(context);
                  } else {
                    provider.nextStep();
                  }
                },
                width: double.infinity,
                trailingIcon: SvgPicture.asset(
                  'assets/icons/arrow.svg',
                  height: 16,
                  width: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
