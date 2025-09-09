import 'package:edutech_app/core/common/widgets/custom_iconbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/common/widgets/gradient_background.dart';
import '../../../core/common/widgets/elevated_bottom.dart';
import '../../../core/common/widgets/custom_textformfeild.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0;
  final PageController _pageController = PageController();

  final List<OnboardingData> onboardingData = [
    OnboardingData(
      title: "Personal Information",
      subtitle: "Tell us about yourself",
      description: "",
      imagePath: "assets/images/onboarding_1.png",
      icon: SvgPicture.asset('assets/icons/profile.svg', width: 24, height: 24),
      fields: [
        OnboardingField(label: "Full Name", hint: "Enter your full name"),
        OnboardingField(label: "Email Address", hint: "Enter your email"),
      ],
    ),
    OnboardingData(
      title: "Account Security",
      subtitle: "Create your login credentials",
      description: "",
      imagePath: "assets/images/onboarding_2.png",
      icon: Icon(Icons.lock_outline),
      fields: [
        OnboardingField(label: "Username", hint: "Choose a username"),
        OnboardingField(
          label: "Password",
          hint: "Create a password",
          isPassword: true,
        ),
        OnboardingField(
          label: "Confirm Password",
          hint: "Confirm your password",
          isPassword: true,
        ),
      ],
    ),
    OnboardingData(
      title: "Profile Picture",
      subtitle: "Add a photo to personalize your profile",
      description: "",
      imagePath: "assets/images/onboarding_3.png",
      icon: Icon(Icons.camera_alt_outlined),
      fields: [],
    ),
    OnboardingData(
      title: "Additional Details",
      subtitle: "Complete your profile",
      description: "",
      imagePath: "assets/images/onboarding_4.png",
      icon: SvgPicture.asset('assets/icons/info.svg', width: 24, height: 24),
      fields: [
        OnboardingField(
          label: "Bio",
          hint: "Tell us about yourself as a parent/teacher...",
          isTextarea: true,
        ),
        OnboardingField(
          label: "Date of Birth",
          hint: "mm/dd/yyyy",
          isDate: true,
        ),
      ],
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header with Back Button and Progress
            Padding(
              padding: const EdgeInsets.all(AppSpacing.spacing24),
              child: Column(
                children: [
                  // Back Button and Progress Text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (currentPage > 0)
                        GestureDetector(
                          onTap: () {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
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
                        const SizedBox.shrink(),

                      Text(
                        "${currentPage + 1} of ${onboardingData.length}",
                        style: AppTypography.subtle.copyWith(
                          color: AppColors.sky900,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.spacing16),

                  // Progress Bar
                  LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(10),
                    value: (currentPage + 1) / onboardingData.length,
                    backgroundColor: AppColors.primary50,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.sky700,
                    ),
                    minHeight: 8,
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.spacing16),

            // PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemCount: onboardingData.length,
                itemBuilder: (context, index) {
                  return OnboardingPage(data: onboardingData[index]);
                },
              ),
            ),

            // Bottom Continue Button
            Padding(
              padding: const EdgeInsets.all(AppSpacing.spacing24),
              child: CustomElevatedButton(
                text: currentPage == onboardingData.length - 1
                    ? "Get Started"
                    : "Continue",
                onTap: () {
                  if (currentPage == onboardingData.length - 1) {
                    Navigator.pushReplacementNamed(context, '/signin');
                  } else {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
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

class OnboardingPage extends StatelessWidget {
  final OnboardingData data;

  const OnboardingPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Content Container
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: AppSpacing.spacing24,
            ),
            padding: const EdgeInsets.all(AppSpacing.spacing24),
            decoration: BoxDecoration(
              color: AppColors.sky100,
              borderRadius: BorderRadius.circular(AppSpacing.radiusXXL),
              border: Border.all(color: AppColors.border),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowMedium,
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                // Header Section
                Column(
                  children: [
                    // Icon
                    CustomIconBox(icon: data.icon, size: 72),

                    const SizedBox(height: AppSpacing.spacing16),

                    // Title
                    Text(
                      data.title,
                      style: AppTypography.heading2.copyWith(
                        color: AppColors.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: AppSpacing.spacing8),

                    // Subtitle
                    Text(
                      data.subtitle,
                      style: AppTypography.paragrah.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.spacing24),

                // Fields Section
                if (data.fields.isNotEmpty) ...[
                  ...data.fields.map(
                    (field) => Padding(
                      padding: const EdgeInsets.only(
                        bottom: AppSpacing.spacing12,
                      ),
                      child: _buildField(field),
                    ),
                  ),
                ] else if (data.title == "Profile Picture") ...[
                  // Photo Upload Section
                  Column(
                    children: [
                      Container(
                        width: 138,
                        height: 138,
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          border: Border.all(
                            color: AppColors.neutral300,
                            style: BorderStyle.solid,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(69),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/upload.svg',
                            width: 32,
                            height: 32,
                          ),
                        ),
                      ),

                      const SizedBox(height: AppSpacing.spacing16),

                      CustomElevatedButton(
                        text: "Upload Photo",
                        onTap: () {
                          // Handle photo upload
                        },
                        gradient: LinearGradient(
                          colors: [AppColors.background, AppColors.background],
                        ),
                        textColor: AppColors.sky700,
                        borderColor: AppColors.primary700,
                        leadingIcon: SvgPicture.asset(
                          'assets/icons/upload.svg',
                          width: 16,
                          height: 16,
                        ),
                        width: 151,
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField(OnboardingField field) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          field.label,
          style: AppTypography.subtle.copyWith(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        CustomTextFormField(
          controller: null,
          hintText: field.hint,
          obscureText: field.isPassword,
          maxlines: field.isTextarea ? 3 : 1,
          prefixIcon: field.isDate ? const Icon(Icons.calendar_today) : null,
          fillColor: AppColors.background,
        ),
      ],
    );
  }
}

class OnboardingData {
  final String title;
  final String subtitle;
  final String description;
  final String imagePath;
  final Widget icon;
  final List<OnboardingField> fields;

  OnboardingData({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imagePath,
    required this.icon,
    required this.fields,
  });
}

class OnboardingField {
  final String label;
  final String hint;
  final bool isPassword;
  final bool isTextarea;
  final bool isDate;

  OnboardingField({
    required this.label,
    required this.hint,
    this.isPassword = false,
    this.isTextarea = false,
    this.isDate = false,
  });
}
