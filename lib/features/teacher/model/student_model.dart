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
    return StudentModel(
      id: json[ApiKey.studentId]?.toString() ?? json['id']?.toString() ?? '',
      name:
          json[ApiKey.studentName] ?? json['name'] ?? json['studentName'] ?? '',
      username: json[ApiKey.userName] ?? json['username'] ?? '',
      completedLessons: json['completedLessons'] ?? 0,
      points: json['points'] ?? 0,
      profileImageUrl: json[ApiKey.profileImageurl] ?? json['profileImageUrl'],
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
