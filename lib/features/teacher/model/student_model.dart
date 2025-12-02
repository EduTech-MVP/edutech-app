import 'package:edutech_app/core/api/endpoints.dart';

class StudentModel {
  final String id;
  final String name;
  final String username;
  final int completedLessons;
  final int points;
  final String? profileImageUrl;

  StudentModel({
    required this.id,
    required this.name,
    required this.username,
    required this.completedLessons,
    required this.points,
    this.profileImageUrl,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    // Handle profile image path - convert relative to absolute URL
    String? profileImage =
        json['profileImagePath'] ??
        json[ApiKey.profileImageurl] ??
        json['profileImageUrl'];

    // If profile image is a relative path, convert to absolute URL
    if (profileImage != null &&
        profileImage.isNotEmpty &&
        profileImage.startsWith('/')) {
      profileImage = 'http://edutech.runasp.net$profileImage';
    }

    return StudentModel(
      id:
          json[ApiKey.studentId]?.toString() ??
          json['studentId']?.toString() ??
          json['id']?.toString() ??
          '',
      name:
          json['fullName'] ??
          json[ApiKey.studentName] ??
          json['name'] ??
          json['studentName'] ??
          '${json['firstName'] ?? ''} ${json['lastName'] ?? ''}'.trim(),
      username:
          json[ApiKey.userName] ??
          json['username'] ??
          json['userName'] ??
          json['Username'] ??
          '',
      completedLessons: json['completedLessons'] ?? 0,
      points: json['points'] ?? 0,
      profileImageUrl: profileImage,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKey.studentId: id,
      ApiKey.studentName: name,
      ApiKey.userName: username,
      'completedLessons': completedLessons,
      'points': points,
      if (profileImageUrl != null) ApiKey.profileImageurl: profileImageUrl,
    };
  }

  StudentModel copyWith({
    String? id,
    String? name,
    String? username,
    int? completedLessons,
    int? points,
    String? profileImageUrl,
  }) {
    return StudentModel(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      completedLessons: completedLessons ?? this.completedLessons,
      points: points ?? this.points,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }
}
