import 'package:edutech_app/core/api/endpoints.dart';
import 'package:edutech_app/features/auth/models/user_model.dart';

class SignupModel {
  final String token;
  final UserModel user;
  final String refreshToken;

  SignupModel({
    required this.token,
    required this.user,
    required this.refreshToken,
  });

  factory SignupModel.fromJson(Map<String, dynamic> json) {
    return SignupModel(
      token: json[ApiKey.token],
      user: UserModel.fromJson(json[ApiKey.user]),
      refreshToken: json[ApiKey.refreshToken],
    );
  }
}
