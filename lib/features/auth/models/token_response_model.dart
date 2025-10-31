import 'package:edutech_app/core/api/endpoints.dart';

class TokenResponseModel {
  final String token;

  TokenResponseModel({required this.token});

  factory TokenResponseModel.fromJson(Map<String, dynamic> json) {
    return TokenResponseModel(token: json[ApiKey.token]);
  }
  Map<String, dynamic> toJson() {
    return {ApiKey.token: token};
  }
}
