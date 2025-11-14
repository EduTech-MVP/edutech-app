// ignore_for_file: deprecated_member_use

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../core/common/widgets/custom_iconbox.dart';
import '../../../../core/common/widgets/custom_textformfeild.dart';
import '../../../../core/common/widgets/elevated_bottom.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../controller/onboarding_provider.dart';
import '../../model/onboarding_model.dart' as ui_model;

class OnboardingPage extends StatefulWidget {
  final ui_model.OnboardingData data;

  const OnboardingPage({super.key, required this.data});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  // Controllers for each field type
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();

    if (widget.data.fields.isNotEmpty) {
      for (var field in widget.data.fields) {
        _controllers[field.label] = TextEditingController();
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setInitialValues();
    });
  }

  @override
  void dispose() {
    // Dispose all controllers
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _setInitialValues() {
    final provider = Provider.of<OnboardingProvider>(context, listen: false);

    if (widget.data.title == "Personal Information") {
      if (provider.data.fullName != null &&
          _controllers.containsKey("Full Name")) {
        _controllers["Full Name"]!.text = provider.data.fullName!;
      }
      if (provider.data.email != null &&
          _controllers.containsKey("Email Address")) {
        _controllers["Email Address"]!.text = provider.data.email!;
      }
    } else if (widget.data.title == "Account Security") {
      if (provider.data.username != null &&
          _controllers.containsKey("Username")) {
        _controllers["Username"]!.text = provider.data.username!;
      }
      if (provider.data.password != null &&
          _controllers.containsKey("Password")) {
        _controllers["Password"]!.text = provider.data.password!;
      }
      if (provider.data.confirmPassword != null &&
          _controllers.containsKey("Confirm Password")) {
        _controllers["Confirm Password"]!.text = provider.data.confirmPassword!;
      }
    } else if (widget.data.title == "Additional Details") {
      if (provider.data.bio != null && _controllers.containsKey("Bio")) {
        _controllers["Bio"]!.text = provider.data.bio!;
      }
      if (provider.data.dateOfBirth != null &&
          _controllers.containsKey("Date of Birth")) {
        _controllers["Date of Birth"]!.text =
            "${provider.data.dateOfBirth!.month}/${provider.data.dateOfBirth!.day}/${provider.data.dateOfBirth!.year}";
      }
    }
  }

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
              color: AppColors.background,
              borderRadius: BorderRadius.circular(AppSpacing.radiusXXL),
              border: Border.all(color: AppColors.border),
              boxShadow: [AppColors.shadowMedium],
            ),
            child: Column(
              children: [
                // Header Section
                Column(
                  children: [
                    // Icon
                    CustomIconBox(icon: widget.data.icon, size: 72),

                    const SizedBox(height: AppSpacing.spacing16),

                    // Title
                    Text(
                      widget.data.title,
                      style: AppTypography.heading2.copyWith(
                        color: AppColors.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: AppSpacing.spacing8),

                    // Subtitle
                    Text(
                      widget.data.subtitle,
                      style: AppTypography.paragrah.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.spacing24),

                // Fields Section
                if (widget.data.fields.isNotEmpty) ...[
                  ...widget.data.fields.map(
                    (field) => Padding(
                      padding: const EdgeInsets.only(
                        bottom: AppSpacing.spacing12,
                      ),
                      child: _buildField(context, field),
                    ),
                  ),
                ] else if (widget.data.title == "Profile Picture") ...[
                  // Photo Upload Section
                  _buildPhotoUploadSection(context),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField(BuildContext context, ui_model.OnboardingField field) {
    final provider = Provider.of<OnboardingProvider>(context);
    final controller = _controllers[field.label]!;

    // Get error message based on field
    String? errorText;
    if (widget.data.title == "Personal Information") {
      if (field.label == "Full Name") {
        errorText = provider.fullNameError;
      } else if (field.label == "Email Address") {
        errorText = provider.emailError;
      }
    } else if (widget.data.title == "Account Security") {
      if (field.label == "Username") {
        errorText = provider.usernameError;
      } else if (field.label == "Password") {
        errorText = provider.passwordError;
      } else if (field.label == "Confirm Password") {
        errorText = provider.confirmPasswordError;
      }
    } else if (widget.data.title == "Additional Details") {
      if (field.label == "Bio") {
        errorText = provider.bioError;
      } else if (field.label == "Date of Birth") {
        errorText = provider.dateOfBirthError;
      }
    }

    // Check if field is optional
    bool isOptional =
        (widget.data.title == "Additional Details" && field.label == "Bio");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              field.label,
              style: AppTypography.subtle.copyWith(
                color: AppColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (isOptional)
              Text(
                " (Optional)",
                style: AppTypography.subtle.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
          ],
        ),
        CustomTextFormField(
          controller: controller,
          hintText: field.hint,
          obscureText: field.isPassword,
          maxlines: field.isTextarea ? 3 : 1,
          prefixIcon: field.isDate ? const Icon(Icons.calendar_today) : null,
          fillColor: AppColors.background,
          onChanged: (value) {
            if (widget.data.title == "Personal Information") {
              if (field.label == "Full Name") {
                provider.updateFullName(value);
              } else if (field.label == "Email Address") {
                provider.updateEmail(value);
              }
            } else if (widget.data.title == "Account Security") {
              if (field.label == "Username") {
                provider.updateUsername(value);
              } else if (field.label == "Password") {
                provider.updatePassword(value);
              } else if (field.label == "Confirm Password") {
                provider.updateConfirmPassword(value);
              }
            } else if (widget.data.title == "Additional Details") {
              if (field.label == "Bio") {
                provider.updateBio(value);
              } else if (field.label == "Date of Birth") {
                try {
                  final parts = value.split('/');
                  if (parts.length == 3) {
                    final month = int.parse(parts[0]);
                    final day = int.parse(parts[1]);
                    final year = int.parse(parts[2]);
                    provider.updateDateOfBirth(DateTime(year, month, day));
                  }
                } catch (e) {
                  // Handle date parsing errors
                }
              }
            }
          },
        ),

        //error message if there is
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 8.0),
            child: Text(
              errorText,
              style: TextStyle(color: AppColors.error, fontSize: 12),
            ),
          ),
      ],
    );
  }

  Widget _buildPhotoUploadSection(BuildContext context) {
    final provider = Provider.of<OnboardingProvider>(context);

    return Column(
      children: [
        Text(
          "Profile Picture (Optional)",
          style: AppTypography.subtle.copyWith(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppSpacing.spacing12),
        Container(
          width: 138,
          height: 138,
          decoration: BoxDecoration(
            color: AppColors.background,
            border: Border.all(
              color: provider.profilePictureError != null
                  ? AppColors.error
                  : AppColors.neutral300,
              style: BorderStyle.solid,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(69),
          ),
          child: provider.data.profilePicturePath != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(69),
                  child: Image.asset(
                    provider.data.profilePicturePath!,
                    fit: BoxFit.cover,
                  ),
                )
              : Center(
                  child: SvgPicture.asset(
                    'assets/icons/upload.svg',
                    width: 32,
                    height: 32,
                    color: provider.profilePictureError != null
                        ? AppColors.error
                        : null,
                  ),
                ),
        ),

        const SizedBox(height: AppSpacing.spacing16),

        CustomElevatedButton(
          text: "Upload Photo",
          onTap: () async {
            final result = await FilePicker.platform.pickFiles(
              type: FileType.image,
            );
            if (result != null && result.files.single.path != null) {
              provider.updateProfilePicture(result.files.single.path!);
            }
          },
          gradient: LinearGradient(
            colors: [AppColors.background, AppColors.background],
          ),
          textColor: AppColors.sky700,
          borderColor: provider.profilePictureError != null
              ? AppColors.error
              : AppColors.primary700,
          leadingIcon: SvgPicture.asset(
            'assets/icons/upload.svg',
            width: 16,
            height: 16,
          ),
          width: 151,
        ),
      ],
    );
  }
}
