import 'package:edutech_app/core/api/dio_consumer.dart';
import 'package:edutech_app/core/api/endpoints.dart';
import 'package:edutech_app/core/cache/cache_helper.dart';
import 'package:edutech_app/core/errors/exceptions.dart';
import 'package:flutter/material.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  final DioConsumer api;
  ForgotPasswordProvider({required this.api});

  // Controllers
  final emailController = TextEditingController();
  final otpController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // State
  bool _loading = false;
  String? error;
  String? _resetToken;
  String? _successMessage;

  bool get loading => _loading;
  String? get resetToken => _resetToken;
  String? get successMessage => _successMessage;

  // Step 1: Request password reset (send OTP to email)
  Future<bool> requestPasswordReset() async {
    _loading = true;
    error = null;
    _successMessage = null;
    notifyListeners();

    try {
      final response = await api.post(
        Endpoints.forgotPassword,
        data: {ApiKey.email: emailController.text.trim()},
      );

      _successMessage =
          response[ApiKey.message] ??
          'If the email exists and is verified, a password reset code has been sent.';

      return true;
    } on ServerException catch (e) {
      error = e.errorModel.errorMessage;
      return false;
    } catch (e) {
      error = 'Unexpected error: $e';
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  // Step 2: Verify OTP code
  Future<bool> verifyResetCode() async {
    _loading = true;
    error = null;
    _successMessage = null;
    notifyListeners();

    try {
      final response = await api.post(
        Endpoints.verifyResetPassword,
        data: {
          ApiKey.email: emailController.text.trim(),
          ApiKey.resetCode: otpController.text.trim(),
        },
      );

      _successMessage =
          response[ApiKey.message] ?? 'Reset code verified successfully';
      _resetToken = response[ApiKey.resetToken];

      if (_resetToken == null || _resetToken!.isEmpty) {
        error = 'Invalid response: missing reset token';
        return false;
      }

      await CacheHelper.sharedPreferences.setString(
        ApiKey.resetToken,
        _resetToken!,
      );

      return true;
    } on ServerException catch (e) {
      error = e.errorModel.errorMessage;
      return false;
    } catch (e) {
      error = 'Unexpected error: $e';
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  // Step 3: Reset password
  Future<bool> resetPassword() async {
    _loading = true;
    error = null;
    _successMessage = null;
    notifyListeners();

    try {
      // Validate passwords match
      if (newPasswordController.text != confirmPasswordController.text) {
        error = 'Passwords do not match';
        _loading = false;
        notifyListeners();
        return false;
      }

      if (_resetToken == null || _resetToken!.isEmpty) {
        error = 'Reset token is missing. Please verify your code first.';
        _loading = false;
        notifyListeners();
        return false;
      }

      final response = await api.post(
        Endpoints.resetPassword,
        data: {
          ApiKey.newPassword: newPasswordController.text,
          ApiKey.confirmPassword: confirmPasswordController.text,
        },
      );

      _successMessage =
          response[ApiKey.message] ??
          'Password reset successfully. You can now sign in with your new password.';

      // Clear the reset token from cache after successful password reset
      await CacheHelper.removeData(key: ApiKey.resetToken);

      return true;
    } on ServerException catch (e) {
      error = e.errorModel.errorMessage;
      return false;
    } catch (e) {
      error = 'Unexpected error: $e';
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  // Clear all data
  void clear() {
    emailController.clear();
    otpController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
    _resetToken = null;
    error = null;
    _successMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    otpController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
