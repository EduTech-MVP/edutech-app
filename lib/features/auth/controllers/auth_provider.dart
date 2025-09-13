import 'package:edutech_app/features/auth/services/auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  String? _errorMessage;
  String? _token;
  String? _userType;
  bool get isLoggedIn =>
      _token != null &&
      _token!.isNotEmpty &&
      _userType != null &&
      _userType!.isNotEmpty;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get token => _token;
  String? get userType => _userType;

  // login
  Future<void> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _authService.login(
        email: email,
        password: password,
      );

      if (response.containsKey('token')) {
        _token = response['token'];
        _userType = response["userType"] ?? response["UserType"];
        debugPrint('Login successful. Token: $_token');
        debugPrint('UserType: $_userType');

        // Save token to local storage
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', _token!);
        await prefs.setString('userType', _userType!);
      } else {
        _errorMessage = 'Something went wrong. Please try again.';
      }
    } catch (e) {
      // Convert technical error messages into user-friendly text
      final error = e.toString().replaceFirst('Exception: ', '');
      _errorMessage = _mapErrorMessage(error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //logout
  Future<void> logout() async {
    _token = null;
    _errorMessage = null;
    _userType = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("authToken");
    await prefs.remove("userType");

    notifyListeners();
  }

  /// Load token at app start
  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString("authToken");
    _userType = prefs.getString("userType");

    // If token or role is missing, reset everything
    if (_token == null ||
        _token!.isEmpty ||
        _userType == null ||
        _userType!.isEmpty) {
      _token = null;
      _userType = null;
    }

    notifyListeners();
  }

  // Maps raw backend messages to friendly UI text
  String _mapErrorMessage(String error) {
    if (error.toLowerCase().contains("invalid") &&
        error.toLowerCase().contains("credential")) {
      return "Incorrect email or password. Please try again.";
    } else if (error.toLowerCase().contains("network")) {
      return "Network issue. Please check your internet connection.";
    } else if (error.toLowerCase().contains("timeout")) {
      return "Request timed out. Please try again.";
    } else {
      return "An unexpected error occurred. Please try again.";
    }
  }
}
