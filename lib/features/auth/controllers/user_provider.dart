import 'package:edutech_app/core/api/dio_consumer.dart';
import 'package:edutech_app/core/api/endpoints.dart';
import 'package:edutech_app/core/cache/cache_helper.dart';
import 'package:edutech_app/core/errors/exceptions.dart';
import 'package:edutech_app/features/auth/models/signin_model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  final DioConsumer api;
  UserProvider({required this.api});

  // Controllers
  final signInEmail = TextEditingController();
  final signInPassword = TextEditingController();

  final signupFullName = TextEditingController();
  final signupEmail = TextEditingController();
  final signupUserName = TextEditingController();
  final bio = TextEditingController();
  final dateOfBirth = TextEditingController();
  final signupPassword = TextEditingController();
  final signupConfirmPassword = TextEditingController();

  // State
  bool _loading = false;
  String? _error;
  SigninModel? _usersigned;

  bool get loading => _loading;
  String? get error => _error;
  SigninModel? get usersigned => _usersigned;

  Future<bool> signin() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await api.post(
        UserEndpoints.signin,
        data: {
          ApiKey.email: signInEmail.text,
          ApiKey.password: signInPassword.text,
        },
      );

      _usersigned = SigninModel.fromJson(response);

      // Save token & userId
      CacheHelper().saveData(key: ApiKey.token, value: _usersigned!.token);
      CacheHelper().saveData(key: ApiKey.id, value: _usersigned!.user.userType);

      return true;
    } on ServerException catch (e) {
      _error = e.errorModel.errorMessage;
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  // dispose controllers when provider is removed
  @override
  void dispose() {
    signInEmail.dispose();
    signInPassword.dispose();
    signupFullName.dispose();
    signupEmail.dispose();
    signupUserName.dispose();
    bio.dispose();
    dateOfBirth.dispose();
    signupPassword.dispose();
    signupConfirmPassword.dispose();
    super.dispose();
  }
}
