import 'package:edutech_app/core/api/endpoints.dart';

class Teacher {
  final String fullName;
  final String picUrl;
  final int students;
  final int totalClasses;
  final List<dynamic> classes;
  Teacher({
    required this.fullName,
    required this.picUrl,
    required this.students,
    required this.totalClasses,
    required this.classes,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      fullName: json[ApiKey.teacherFullName],
      picUrl: json[ApiKey.teacherPic],
      students: json[ApiKey.teacherStudents],
      totalClasses: json[ApiKey.teachertotalClasses],
      classes: List<dynamic>.from(json[ApiKey.teacherClasses]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKey.teacherFullName: fullName,
      ApiKey.teacherPic: picUrl,
      ApiKey.teacherStudents: students,
      ApiKey.teachertotalClasses: totalClasses,
      ApiKey.teacherClasses: classes,
    };
  }
}
