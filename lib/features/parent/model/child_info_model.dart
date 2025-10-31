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
    return PersonalInfo(
      studentId: json['studentId'],
      fullName: json['fullName'],
      grade: json['grade'],
      learningLevel: json['learningLevel'],
      clusterId: json['clusterId'],
      profileImageUrl: json['profileImageUrl'],
      totalCompletedLessons: json['totalCompletedLessons'],
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
