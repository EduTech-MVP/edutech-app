import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

class OnboardingModel {
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
}
