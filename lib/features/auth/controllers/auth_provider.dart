import 'package:edutech_app/core/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  final ApiService _authService = ApiService();
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

  Future<void> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final response = await _authService.login(email, password);
      _token = response['token'];
      _userType = response['userType'];
      if (_token == null || _userType == null) {
        _errorMessage = 'Login failed: Invalid response from server';
      } else {
        debugPrint('Login successful. Token: $_token');
        debugPrint('UserType: $_userType');
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', _token!);
        await prefs.setString('userType', _userType!);
      }
    } catch (e) {
      final error = e.toString().replaceFirst('Exception: ', '');
      _errorMessage = _mapErrorMessage(error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _token = null;
    _errorMessage = null;
    _userType = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
    await prefs.remove('userType');
    notifyListeners();
  }

  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('authToken');
    _userType = prefs.getString('userType');
    if (_token == null ||
        _token!.isEmpty ||
        _userType == null ||
        _userType!.isEmpty) {
      _token = null;
      _userType = null;
    }
    notifyListeners();
  }

  String _mapErrorMessage(String error) {
    if (error.toLowerCase().contains('invalid') &&
        error.toLowerCase().contains('credential')) {
      return 'Incorrect email or password. Please try again.';
    } else if (error.toLowerCase().contains('network')) {
      return 'Network issue. Please check your internet connection.';
    } else if (error.toLowerCase().contains('timeout')) {
      return 'Request timed out. Please try again.';
    } else {
      return 'An unexpected error occurred. Please try again.';
    }
  }
}
