import 'package:edutech_app/core/routes/app_routes.dart';
import 'package:edutech_app/features/auth/controllers/user_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/onboarding_data_model.dart';
import '../model/onboarding_model.dart' as ui_model;

class OnboardingProvider extends ChangeNotifier {
  final OnboardingData _data = OnboardingData();
  int _currentStep = 0;
  final UserProvider _userProvider;

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
  String? _userTypeError;
  String? _errorMessage;

  // Getters
  OnboardingData get data => _data;
  int get currentStep => _currentStep;
  ui_model.OnboardingModel get uiModel => _uiModel;
  int get totalSteps => _uiModel.onboardingData.length;
  String? get errorMessage => _errorMessage;

  String? get fullNameError => _fullNameError;
  String? get emailError => _emailError;
  String? get usernameError => _usernameError;
  String? get passwordError => _passwordError;
  String? get confirmPasswordError => _confirmPasswordError;
  String? get profilePictureError => _profilePictureError;
  String? get bioError => _bioError;
  String? get dateOfBirthError => _dateOfBirthError;
  String? get userTypeError => _userTypeError;

  OnboardingProvider({required UserProvider userProvider})
    : _userProvider = userProvider;

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

  void updateUserType(String value) {
    _data.userType = value;
    _userTypeError = null;
    if (kDebugMode) {
      print('UserType updated: $value');
    }
    notifyListeners();
  }

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

    if (_data.fullName == null || _data.fullName!.isEmpty) {
      _fullNameError = "Full name is required";
      isValid = false;
    } else if (_data.fullName!.length < 3) {
      _fullNameError = "Full name must be at least 3 characters";
      isValid = false;
    } else {
      _fullNameError = null;
    }

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

    if (_data.username == null || _data.username!.isEmpty) {
      _usernameError = "Username is required";
      isValid = false;
    } else if (_data.username!.length < 4) {
      _usernameError = "Username must be at least 4 characters";
      isValid = false;
    } else {
      _usernameError = null;
    }

    if (_data.password == null || _data.password!.isEmpty) {
      _passwordError = "Password is required";
      isValid = false;
    } else if (_data.password!.length < 6) {
      _passwordError = "Password must be at least 6 characters";
      isValid = false;
    } else {
      _passwordError = null;
    }

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

    if (_data.userType == null || _data.userType!.isEmpty) {
      _userTypeError = "User type is required";
      isValid = false;
    } else if (!['Teacher', 'Parent'].contains(_data.userType)) {
      _userTypeError = "User type must be Teacher or Parent";
      isValid = false;
    } else {
      _userTypeError = null;
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
    _userTypeError = null;
    _errorMessage = null;
    notifyListeners();
  }

  Future<bool> completeOnboarding(BuildContext context) async {
    if (!validateCurrentStep()) {
      return false;
    }

    try {
      // Format dateOfBirth as MM/dd/yyyy
      final formattedDateOfBirth = _data.dateOfBirth != null
          ? DateFormat('MM/dd/yyyy').format(_data.dateOfBirth!)
          : '';
      if (kDebugMode) {
        print('Formatted DateOfBirth: $formattedDateOfBirth');
        print('UserType: ${_data.userType}');
      }

      // Populate UserProvider TextEditingControllers
      _userProvider.signupFullName.text = _data.fullName ?? '';
      _userProvider.signupEmail.text = _data.email ?? '';
      _userProvider.signupUserName.text = _data.username ?? '';
      _userProvider.signupPassword.text = _data.password ?? '';
      _userProvider.signupConfirmPassword.text = _data.confirmPassword ?? '';
      _userProvider.bio.text = _data.bio ?? '';
      _userProvider.dateOfBirth.text = formattedDateOfBirth;

      // Call UserProvider.signUp with profile picture path and userType
      final success = await _userProvider.signUp(
        profilePicturePath: _data.profilePicturePath,
        userType: _data.userType,
      );

      if (success) {
        switch (_data.userType) {
          case 'Teacher':
            Navigator.pushReplacementNamed(
              context,
              AppRoutes.teacherMainScreen,
            );
          case 'Parent':
            Navigator.pushReplacementNamed(context, AppRoutes.parentMainScreen);
        }
        return true;
      } else {
        _errorMessage = _userProvider.error ?? 'Registration failed';
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(_errorMessage!)));
        return false;
      }
    } catch (e) {
      _errorMessage = 'Registration failed: $e';
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(_errorMessage!)));
      notifyListeners();
      return false;
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
