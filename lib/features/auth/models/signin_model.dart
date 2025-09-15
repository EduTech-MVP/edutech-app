import 'package:edutech_app/core/api/endpoints.dart';
import 'package:edutech_app/features/auth/models/user_model.dart';

class SigninModel {
  final String token;
  final UserModel user;

  SigninModel({required this.token, required this.user});

  factory SigninModel.fromJson(Map<String, dynamic> json) {
    return SigninModel(
      token: json[ApiKey.token],
      user: UserModel.fromJson(json[ApiKey.user]),
    );
  }
}
