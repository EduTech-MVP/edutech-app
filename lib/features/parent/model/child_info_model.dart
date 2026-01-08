class ChildInfoModel {
  final PersonalInfo personalInfo;
  final List<dynamic> enrolledClasses;

  ChildInfoModel({required this.personalInfo, required this.enrolledClasses});

  factory ChildInfoModel.fromJson(Map<String, dynamic> json) {
    return ChildInfoModel(
      personalInfo: PersonalInfo.fromJson(json['personalInfo']),
      enrolledClasses: List<dynamic>.from(json['enrolledClasses']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'personalInfo': personalInfo.toJson(),
      'enrolledClasses': enrolledClasses,
    };
  }
}

class PersonalInfo {
  final int studentId;
  final String fullName;
  final int grade;
  final String learningLevel;
  final int clusterId;
  final String profileImageUrl;
  final int totalCompletedLessons;

  PersonalInfo({
    required this.studentId,
    required this.fullName,
    required this.grade,
    required this.learningLevel,
    required this.clusterId,
    required this.profileImageUrl,
    required this.totalCompletedLessons,
  });

  factory PersonalInfo.fromJson(Map<String, dynamic> json) {
    // Handle profile image path - convert relative to absolute URL
    String? profileImage = json['profileImageUrl'];
    if (profileImage != null && profileImage.isNotEmpty) {
      // Convert relative path to absolute URL
      if (profileImage.startsWith('/') && !profileImage.startsWith('//')) {
        profileImage = 'http://edutech.runasp.net$profileImage';
      }
      // If it's already a full URL, keep it as is
    } else {
      profileImage = null; // Set to null if empty
    }

    return PersonalInfo(
      studentId: json['studentId'] ?? 0,
      fullName: json['fullName'] ?? '',
      grade: json['grade'] ?? 0,
      learningLevel: json['learningLevel'] ?? '',
      clusterId: json['clusterId'] ?? 0,
      profileImageUrl: profileImage ?? '',
      totalCompletedLessons: json['totalCompletedLessons'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'fullName': fullName,
      'grade': grade,
      'learningLevel': learningLevel,
      'clusterId': clusterId,
      'profileImageUrl': profileImageUrl,
      'totalCompletedLessons': totalCompletedLessons,
    };
  }
}
