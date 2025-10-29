import 'package:edutech_app/core/api/endpoints.dart';

class LoginModel {
  final String token;

  LoginModel({required this.token});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(token: json[ApiKey.token]);
  }
  Map<String, dynamic> toJson() {
    return {ApiKey.token: token};
  }
}
