import 'package:edutech_app/core/api/endpoints.dart';

class UserModel {
  final int? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? userType;
  final String? profileImageUrl;

  UserModel({
    required this.id,
    this.email,
    required this.firstName,
    required this.lastName,
    required this.userType,
    required this.profileImageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json[ApiKey.id],
      email: json[ApiKey.email],
      firstName: json[ApiKey.firstName],
      lastName: json[ApiKey.lastName],
      userType: (json[ApiKey.userType]).toString().trim(),
      profileImageUrl: json[ApiKey.profileImage],
    );
  }
}
