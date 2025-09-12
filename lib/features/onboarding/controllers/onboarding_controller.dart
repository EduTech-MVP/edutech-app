import 'dart:io';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:edutech_app/features/auth/controllers/auth_controller.dart';
import 'package:edutech_app/features/auth/models/user_model.dart';
import 'package:edutech_app/parent.dart';
import 'package:edutech_app/teacher.dart';

class OnboardingController extends ChangeNotifier {
  final PageController pageController = PageController();
  int currentPage = 0;
  String? profileImagePath;
  bool _initialized = false;
  final Map<int, Map<String, TextEditingController>> controllers = {
    0: {
      'Full Name': TextEditingController(),
      'Email Address': TextEditingController(),
    },
    1: {
      'Username': TextEditingController(),
      'Password': TextEditingController(),
      'Confirm Password': TextEditingController(),
    },
    3: {
      'Bio': TextEditingController(),
      'Date of Birth': TextEditingController(),
    },
  };

  // Initialize once
  void init(BuildContext context) {
    if (_initialized) return;
    _initialized = true;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final authController = Provider.of<AuthController>(
        context,
        listen: false,
      );
      try {
        final previousUser = await authController.loadPreviousUserData();
        if (previousUser != null) {
          controllers[0]!['Full Name']!.text = previousUser.fullName ?? '';
          controllers[0]!['Email Address']!.text = previousUser.email ?? '';
          controllers[1]!['Username']!.text = previousUser.username ?? '';
          controllers[3]!['Bio']!.text = previousUser.bio ?? '';
          controllers[3]!['Date of Birth']!.text =
              previousUser.dateOfBirth ?? '';
          profileImagePath = previousUser.profileImagePath;
          notifyListeners();
        }
      } catch (e) {
        // Preserve original behavior
      }
    });
  }

  void setCurrentPage(int index) {
    currentPage = index;
    notifyListeners();
  }

  void goToPrevious() {
    if (currentPage > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      currentPage--;
      notifyListeners();
    }
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackbar(
    context,
    text,
  ) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.sky100,
        content: Text(style: TextStyle(color: AppColors.sky700), text),
      ),
    );
  }

  // Validation per screen with proper format checks
  bool validateCurrentPage(BuildContext context) {
    switch (currentPage) {
      case 0: // Full Name & Email
        final fullName = controllers[0]!['Full Name']!.text.trim();
        final email = controllers[0]!['Email Address']!.text.trim();
        if (fullName.isEmpty || email.isEmpty) {
          snackbar(context, '*enter Full Name and Email');
          return false;
        }
        // Email format validation
        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
        if (!emailRegex.hasMatch(email)) {
          snackbar(context, '*enter a valid email');
          return false;
        }
        break;

      case 1: // Username & Password
        final username = controllers[1]!['Username']!.text.trim();
        final password = controllers[1]!['Password']!.text;
        final confirmPassword = controllers[1]!['Confirm Password']!.text;
        if (username.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
          snackbar(context, 'Please fill all fields');
          return false;
        }
        if (password != confirmPassword) {
          snackbar(context, 'Passwords do not match');
          return false;
        }
        if (password.length < 6) {
          snackbar(context, 'Password must be at least 6 characters');
          return false;
        }
        break;

      case 2: // Image page (skippable)
        return true;

      case 3: // Bio & Date of Birth
        final bio = controllers[3]!['Bio']!.text.trim();
        final dob = controllers[3]!['Date of Birth']!.text.trim();
        if (dob.isEmpty || bio.isEmpty) {
          snackbar(context, 'Please fill Bio and Date of Birth');
          return false;
        }
        // Date format validation (YYYY-MM-DD)
        final dobRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
        if (!dobRegex.hasMatch(dob)) {
          snackbar(context, 'Date of Birth must be in YYYY-MM-DD format');
          return false;
        }
        break;
    }
    return true;
  }

  void goToNext(BuildContext context) {
    if (validateCurrentPage(context)) {
      if (currentPage < 3) {
        pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        currentPage++;
        notifyListeners();
      }
    }
  }

  Future<void> pickImage(BuildContext context) async {
    try {
      final result = await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null && result.files.isNotEmpty) {
        profileImagePath = result.files.single.path;
        notifyListeners();
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error picking image: $e')));
    }
  }

  Future<void> submitRegistration(
    BuildContext context,
    String selectedRole,
  ) async {
    final authController = Provider.of<AuthController>(context, listen: false);
    final user = User(
      fullName: controllers[0]!['Full Name']!.text,
      username: controllers[1]!['Username']!.text,
      email: controllers[0]!['Email Address']!.text,
      password: controllers[1]!['Password']!.text,
      confirmPassword: controllers[1]!['Confirm Password']!.text,
      dateOfBirth: controllers[3]!['Date of Birth']!.text,
      userType: selectedRole,
      bio: controllers[3]!['Bio']!.text,
      subject: '',
      profileImagePath: profileImagePath,
    );

    // if (!user.validateForRegistration()) {
    //   snackbar(context, 'Please fill all required fields correctly');
    //   return;
    // }

    await authController.register(user);

    if (authController.error == null && authController.user != null) {
      final userType = authController.user!.userType;
      if (userType == 'Parent') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ParentHomeScreen()),
        );
      } else if (userType == 'Teacher') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const TeacherHomeScreen()),
        );
      }
    } else {
      snackbar(context, Text(authController.error ?? 'Registration failed '));
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    controllers.values.forEach((map) => map.values.forEach((c) => c.dispose()));
    super.dispose();
  }
}
