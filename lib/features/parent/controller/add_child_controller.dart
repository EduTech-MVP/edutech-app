import 'package:edutech_app/core/errors/exceptions.dart';
import 'package:edutech_app/features/auth/controllers/user_provider.dart';
import 'package:edutech_app/features/parent/controller/parent_controller.dart';
import 'package:edutech_app/features/parent/model/add_student_request.dart';
import 'package:flutter/material.dart';

/// Controller for managing add child functionality
/// Separates business logic from UI
class AddChildController extends ChangeNotifier {
  final UserProvider userProvider;
  final ParentProvider parentProvider;

  AddChildController({
    required this.userProvider,
    required this.parentProvider,
  });

  // Form controllers
  final fullNameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final dateController = TextEditingController();

  // Form state
  final formKey = GlobalKey<FormState>();
  String? _selectedGrade;
  bool _isLoading = false;
  String? _error;
  String? _successMessage;

  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get successMessage => _successMessage;
  String? get selectedGrade => _selectedGrade;

  static const List<String> grades = ['Grade 4', 'Grade 5', 'Grade 6'];

  void setSelectedGrade(String? grade) {
    _selectedGrade = grade;
    notifyListeners();
  }

  /// Maps grade string to number
  int mapGradeToNumber(String grade) {
    if (grade == 'Kindergarten') return 0;
    return int.tryParse(grade.replaceAll('Grade ', '')) ?? 0;
  }

  /// Validates form data
  String? validateForm({
    required String? fullName,
    required String? username,
    required String? password,
    required String? confirmPassword,
    required String? dateOfBirth,
    required String? grade,
  }) {
    if (fullName == null || fullName.trim().isEmpty) {
      return 'Please enter your child\'s full name';
    }

    if (username == null || username.trim().isEmpty) {
      return 'Please choose a username';
    }

    if (password == null || password.isEmpty) {
      return 'Please create a password';
    }

    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }

    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm the password';
    }

    if (password != confirmPassword) {
      return 'Passwords do not match';
    }

    if (dateOfBirth == null || dateOfBirth.trim().isEmpty) {
      return 'Please enter date of birth';
    }

    if (grade == null || grade.isEmpty) {
      return 'Please select a grade';
    }

    return null;
  }

  /// Adds a new child account
  Future<bool> addChild() async {
    // Validate form first
    if (!formKey.currentState!.validate()) {
      return false;
    }

    if (_selectedGrade == null) {
      _error = 'Please select a grade';
      _successMessage = null;
      notifyListeners();
      return false;
    }

    // Validate form data
    final validationError = validateForm(
      fullName: fullNameController.text,
      username: usernameController.text,
      password: passwordController.text,
      confirmPassword: confirmPasswordController.text,
      dateOfBirth: dateController.text,
      grade: _selectedGrade!,
    );

    if (validationError != null) {
      _error = validationError;
      _successMessage = null;
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _error = null;
    _successMessage = null;
    notifyListeners();

    try {
      // Create request
      final request = AddStudentRequest(
        fullName: fullNameController.text.trim(),
        username: usernameController.text.trim(),
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
        dateOfBirth: dateController.text.trim(),
        grade: mapGradeToNumber(_selectedGrade!),
      );

      // Call API through UserProvider
      await userProvider.addStudent(request);

      // Check if there was an error from UserProvider
      if (userProvider.error != null) {
        _error = userProvider.error;
        _successMessage = null;
        _isLoading = false;
        notifyListeners();
        return false;
      }

      // Refresh parent data after adding child
      await parentProvider.refreshAllChildren();

      // Set success message
      final studentName =
          userProvider.student?.firstName ??
          fullNameController.text.split(' ').first;
      _successMessage = 'Child $studentName added successfully!';
      _error = null;
      _isLoading = false;
      notifyListeners();

      return true;
    } on ServerException catch (e) {
      _error = e.errorModel.errorMessage;
      _successMessage = null;
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _error = 'Failed to create child: $e';
      _successMessage = null;
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Clears error and success messages
  void clearMessages() {
    _error = null;
    _successMessage = null;
    notifyListeners();
  }

  /// Resets controller state
  void reset() {
    fullNameController.clear();
    usernameController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    dateController.clear();
    _selectedGrade = null;
    _isLoading = false;
    _error = null;
    _successMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    dateController.dispose();
    super.dispose();
  }
}
