import 'package:edutech_app/core/api/endpoints.dart';

class StudentInClass {
  final int studentId;
  final String firstName;
  final String lastName;
  final String fullName;
  final int grade;
  final String learningLevel;
  final int clusterId;
  final String? profileImagePath;
  final int completedLessons;
  final int totalLessons;

  StudentInClass({
    required this.studentId,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.grade,
    required this.learningLevel,
    required this.clusterId,
    this.profileImagePath,
    required this.completedLessons,
    required this.totalLessons,
  });

  factory StudentInClass.fromJson(Map<String, dynamic> json) {
    String? profileImage = json[ApiKey.profileImagePath] ?? '';

    // If profile image is a relative path, convert to absolute URL
    if (profileImage != null &&
        profileImage.isNotEmpty &&
        profileImage.startsWith('/')) {
      profileImage = 'http://edutech.runasp.net$profileImage';
    }

    return StudentInClass(
      studentId: json[ApiKey.studentId] ?? 0,
      firstName: json[ApiKey.firstName] ?? '',
      lastName: json[ApiKey.lastName] ?? '',
      fullName: json[ApiKey.fullName] ?? '',
      grade: json[ApiKey.classGrade] ?? 0,
      learningLevel: json[ApiKey.learningLevel] ?? '',
      clusterId: json[ApiKey.clusterid] ?? 0,
      profileImagePath: profileImage,
      completedLessons: json[ApiKey.completedLessons] ?? 0,
      totalLessons: json[ApiKey.totalLessons] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKey.studentId: studentId,
      ApiKey.firstName: firstName,
      ApiKey.lastName: lastName,
      'fullName': fullName,
      ApiKey.classGrade: grade,
      ApiKey.learningLevel: learningLevel,
      ApiKey.clusterid: clusterId,
      if (profileImagePath != null) 'profileImagePath': profileImagePath,
      'completedLessons': completedLessons,
      'totalLessons': totalLessons,
    };
  }

  StudentInClass copyWith({
    int? studentId,
    String? firstName,
    String? lastName,
    String? fullName,
    int? grade,
    String? learningLevel,
    int? clusterId,
    String? profileImagePath,
    int? completedLessons,
    int? totalLessons,
  }) {
    return StudentInClass(
      studentId: studentId ?? this.studentId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      fullName: fullName ?? this.fullName,
      grade: grade ?? this.grade,
      learningLevel: learningLevel ?? this.learningLevel,
      clusterId: clusterId ?? this.clusterId,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      completedLessons: completedLessons ?? this.completedLessons,
      totalLessons: totalLessons ?? this.totalLessons,
    );
  }

  // Helper getter for profile image URL (for consistency with StudentModel)
  String? get profileImageUrl => profileImagePath;

  // Helper getter to get progress percentage
  double get progressPercentage {
    if (totalLessons == 0) return 0.0;
    return (completedLessons / totalLessons) * 100;
  }
}
