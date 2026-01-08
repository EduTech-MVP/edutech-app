import 'package:edutech_app/core/api/endpoints.dart';

////user profile
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
    // Handle profile image path - convert relative to absolute URL
    String? profileImage = json[ApiKey.profileImageurl];
    if (profileImage != null && profileImage.isNotEmpty) {
      // Convert relative path to absolute URL
      if (profileImage.startsWith('/') && !profileImage.startsWith('//')) {
        profileImage = 'http://edutech.runasp.net$profileImage';
      }
      // If it's already a full URL, keep it as is
    } else {
      profileImage = null; // Set to null if empty
    }

    return UserModel(
      id: json[ApiKey.id],
      email: json[ApiKey.email],
      firstName: json[ApiKey.firstName],
      lastName: json[ApiKey.lastName],
      userType: (json[ApiKey.userType]).toString().trim(),
      profileImageUrl: profileImage,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      ApiKey.id: id,
      ApiKey.email: email,
      ApiKey.firstName: firstName,
      ApiKey.lastName: lastName,
      ApiKey.userType: userType,
      ApiKey.profileImageurl: profileImageUrl,
    };
  }
}
