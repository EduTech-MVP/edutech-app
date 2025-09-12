import 'package:flutter/material.dart';
import '../model/onboarding_data_model.dart';
import '../model/onboarding_model.dart' as ui_model;

class OnboardingProvider extends ChangeNotifier {
  final OnboardingData _data = OnboardingData();
  int _currentStep = 0;

  final PageController pageController = PageController();

  final ui_model.OnboardingModel _uiModel = ui_model.OnboardingModel();

  // Validation error messages
  String? _fullNameError;
  String? _emailError;
  String? _usernameError;
  String? _passwordError;
  String? _confirmPasswordError;
  String? _profilePictureError;
  String? _bioError;
  String? _dateOfBirthError;

  // Getters
  OnboardingData get data => _data;
  int get currentStep => _currentStep;
  ui_model.OnboardingModel get uiModel => _uiModel;
  int get totalSteps => _uiModel.onboardingData.length;

  // Validation error getters
  String? get fullNameError => _fullNameError;
  String? get emailError => _emailError;
  String? get usernameError => _usernameError;
  String? get passwordError => _passwordError;
  String? get confirmPasswordError => _confirmPasswordError;
  String? get profilePictureError => _profilePictureError;
  String? get bioError => _bioError;
  String? get dateOfBirthError => _dateOfBirthError;

  bool nextStep() {
    if (!validateCurrentStep()) {
      return false;
    }

    if (_currentStep < totalSteps - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      return true;
    }
    return false;
  }

  void previousStep() {
    if (_currentStep > 0) {
      clearValidationErrors();

      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void updateCurrentStep(int step) {
    _currentStep = step;
    clearValidationErrors();
    notifyListeners();
  }

  void updateFullName(String value) {
    _data.fullName = value;
    _fullNameError = null;
    notifyListeners();
  }

  void updateEmail(String value) {
    _data.email = value;
    _emailError = null;
    notifyListeners();
  }

  void updateUsername(String value) {
    _data.username = value;
    _usernameError = null;
    notifyListeners();
  }

  void updatePassword(String value) {
    _data.password = value;
    _passwordError = null;
    if (_data.confirmPassword != null && _data.confirmPassword == value) {
      _confirmPasswordError = null;
    }
    notifyListeners();
  }

  void updateConfirmPassword(String value) {
    _data.confirmPassword = value;
    _confirmPasswordError = null;
    notifyListeners();
  }

  void updateProfilePicture(String path) {
    _data.profilePicturePath = path;
    // Clear error when user uploads
    _profilePictureError = null;
    notifyListeners();
  }

  void updateBio(String value) {
    _data.bio = value;
    _bioError = null;
    notifyListeners();
  }

  void updateDateOfBirth(DateTime value) {
    _data.dateOfBirth = value;
    _dateOfBirthError = null;
    notifyListeners();
  }

  // Validation methods
  bool validateCurrentStep() {
    switch (_currentStep) {
      case 0:
        return validatePersonalInfo();
      case 1:
        return validateAccountSecurity();
      case 2:
        return validateProfilePicture();
      case 3:
        return validateAdditionalDetails();
      default:
        return true;
    }
  }

  bool validatePersonalInfo() {
    bool isValid = true;

    // Validate full name
    if (_data.fullName == null || _data.fullName!.isEmpty) {
      _fullNameError = "Full name is required";
      isValid = false;
    } else if (_data.fullName!.length < 3) {
      _fullNameError = "Full name must be at least 3 characters";
      isValid = false;
    } else {
      _fullNameError = null;
    }

    // Validate email
    if (_data.email == null || _data.email!.isEmpty) {
      _emailError = "Email is required";
      isValid = false;
    } else if (!RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    ).hasMatch(_data.email!)) {
      _emailError = "Please enter a valid email address";
      isValid = false;
    } else {
      _emailError = null;
    }

    notifyListeners();
    return isValid;
  }

  bool validateAccountSecurity() {
    bool isValid = true;

    // Validate username
    if (_data.username == null || _data.username!.isEmpty) {
      _usernameError = "Username is required";
      isValid = false;
    } else if (_data.username!.length < 4) {
      _usernameError = "Username must be at least 4 characters";
      isValid = false;
    } else {
      _usernameError = null;
    }

    // Validate password
    if (_data.password == null || _data.password!.isEmpty) {
      _passwordError = "Password is required";
      isValid = false;
    } else if (_data.password!.length < 6) {
      _passwordError = "Password must be at least 6 characters";
      isValid = false;
    } else {
      _passwordError = null;
    }

    // Validate confirm password
    if (_data.confirmPassword == null || _data.confirmPassword!.isEmpty) {
      _confirmPasswordError = "Please confirm your password";
      isValid = false;
    } else if (_data.confirmPassword != _data.password) {
      _confirmPasswordError = "Passwords do not match";
      isValid = false;
    } else {
      _confirmPasswordError = null;
    }

    notifyListeners();
    return isValid;
  }

  bool validateProfilePicture() {
    _profilePictureError = null;
    notifyListeners();
    return true;
  }

  bool validateAdditionalDetails() {
    bool isValid = true;

    if (_data.bio != null && _data.bio!.isNotEmpty && _data.bio!.length < 10) {
      _bioError = "Bio must be at least 10 characters";
      isValid = false;
    } else {
      _bioError = null;
    }

    // Validate date of birth
    if (_data.dateOfBirth == null) {
      _dateOfBirthError = "Date of birth is required";
      isValid = false;
    } else {
      final now = DateTime.now();
      final minimumAge = DateTime(now.year - 5, now.month, now.day);

      if (_data.dateOfBirth!.isAfter(now)) {
        _dateOfBirthError = "Date of birth cannot be in the future";
        isValid = false;
      } else if (_data.dateOfBirth!.isAfter(minimumAge)) {
        _dateOfBirthError = "You must be at least 5 years old";
        isValid = false;
      } else {
        _dateOfBirthError = null;
      }
    }
    notifyListeners();
    return isValid;
  }

  void clearValidationErrors() {
    _fullNameError = null;
    _emailError = null;
    _usernameError = null;
    _passwordError = null;
    _confirmPasswordError = null;
    _profilePictureError = null;
    _bioError = null;
    _dateOfBirthError = null;
    notifyListeners();
  }

  bool completeOnboarding(BuildContext context) {
    if (!validateCurrentStep()) {
      return false;
    }
    Navigator.pushReplacementNamed(context, '/mainscreen');
    return true;
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
