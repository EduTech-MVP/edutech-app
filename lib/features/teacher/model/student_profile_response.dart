import 'package:edutech_app/core/api/endpoints.dart';

class StudentProfileResponse {
  final bool success;
  final StudentProfileData data;

  StudentProfileResponse({required this.success, required this.data});

  factory StudentProfileResponse.fromJson(Map<String, dynamic> json) {
    return StudentProfileResponse(
      success: json[ApiKey.success] ?? json['success'] ?? false,
      data: StudentProfileData.fromJson(
        json[ApiKey.data] ?? json['data'] ?? {},
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {ApiKey.success: success, ApiKey.data: data.toJson()};
  }
}

class StudentProfileData {
  final int studentId;
  final String firstName;
  final String lastName;
  final int grade;
  final String? profileImagePath;
  final int completedLessons;
  final int totalLessons;
  final int weeklyAttendance;
  final List<SubjectProgress> subjectProgress;
  final List<RecentActivity> recentActivity;

  StudentProfileData({
    required this.studentId,
    required this.firstName,
    required this.lastName,
    required this.grade,
    this.profileImagePath,
    required this.completedLessons,
    required this.totalLessons,
    required this.weeklyAttendance,
    required this.subjectProgress,
    required this.recentActivity,
  });

  factory StudentProfileData.fromJson(Map<String, dynamic> json) {
    // Handle profile image path - convert relative to absolute URL
    String? profileImage =
        json[ApiKey.profileImagePath] ??
        json['profileImagePath'] ??
        json[ApiKey.profileImageurl];

    // If profile image is a relative path, convert to absolute URL
    if (profileImage != null &&
        profileImage.isNotEmpty &&
        profileImage.startsWith('/')) {
      profileImage = 'http://edutech.runasp.net$profileImage';
    }

    return StudentProfileData(
      studentId: json[ApiKey.studentId] ?? 0,
      firstName: json[ApiKey.firstName] ?? '',
      lastName: json[ApiKey.lastName] ?? '',
      grade: json[ApiKey.classGrade] ?? 0,
      profileImagePath: profileImage,
      completedLessons: json[ApiKey.completedLessons] ?? 0,
      totalLessons: json[ApiKey.totalLessons] ?? 0,
      weeklyAttendance: json[ApiKey.weeklyAttendance] ?? 0,
      subjectProgress: (json[ApiKey.subjectProgress] ?? [])
          .map<SubjectProgress>((item) => SubjectProgress.fromJson(item))
          .toList(),
      recentActivity: (json[ApiKey.recentActivity] ?? [])
          .map<RecentActivity>((item) => RecentActivity.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKey.studentId: studentId,
      ApiKey.firstName: firstName,
      ApiKey.lastName: lastName,
      ApiKey.classGrade: grade,
      if (profileImagePath != null) ApiKey.profileImagePath: profileImagePath,
      ApiKey.completedLessons: completedLessons,
      ApiKey.totalLessons: totalLessons,
      ApiKey.weeklyAttendance: weeklyAttendance,
      ApiKey.subjectProgress: subjectProgress
          .map((item) => item.toJson())
          .toList(),
      ApiKey.recentActivity: recentActivity
          .map((item) => item.toJson())
          .toList(),
    };
  }

  // Helper getter for full name
  String get fullName => '$firstName $lastName'.trim();

  // Helper getter for profile image URL
  String? get profileImageUrl => profileImagePath;

  // Helper getter for overall progress percentage
  double get overallProgressPercentage {
    if (totalLessons == 0) return 0.0;
    return (completedLessons / totalLessons) * 100;
  }
}

class SubjectProgress {
  final String subject;
  final int completedLessons;
  final int totalLessons;
  final double progressPercentage;

  SubjectProgress({
    required this.subject,
    required this.completedLessons,
    required this.totalLessons,
    required this.progressPercentage,
  });

  factory SubjectProgress.fromJson(Map<String, dynamic> json) {
    return SubjectProgress(
      subject:
          json[ApiKey.subject] ??
          json['subject'] ??
          json[ApiKey.classSubject] ??
          '',
      completedLessons: json[ApiKey.completedLessons] ?? 0,
      totalLessons: json[ApiKey.totalLessons] ?? 0,
      progressPercentage: (json[ApiKey.progressPercentage] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKey.subject: subject,
      ApiKey.completedLessons: completedLessons,
      ApiKey.totalLessons: totalLessons,
      ApiKey.progressPercentage: progressPercentage,
    };
  }

  SubjectProgress copyWith({
    String? subject,
    int? completedLessons,
    int? totalLessons,
    double? progressPercentage,
  }) {
    return SubjectProgress(
      subject: subject ?? this.subject,
      completedLessons: completedLessons ?? this.completedLessons,
      totalLessons: totalLessons ?? this.totalLessons,
      progressPercentage: progressPercentage ?? this.progressPercentage,
    );
  }
}

class RecentActivity {
  final Map<String, dynamic> data;

  RecentActivity({required this.data});

  factory RecentActivity.fromJson(Map<String, dynamic> json) {
    return RecentActivity(data: json);
  }

  Map<String, dynamic> toJson() {
    return data;
  }
}
