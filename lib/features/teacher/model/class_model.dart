import 'package:edutech_app/core/api/endpoints.dart';

class ClassModel {
  final String id;
  final String name;
  final String subject;
  final String classCode;
  final int grade;
  final int lessonCount;
  final int studentCount;

  ClassModel({
    required this.id,
    required this.name,
    required this.subject,
    required this.grade,
    required this.lessonCount,
    required this.studentCount,
    required this.classCode,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      id: json[ApiKey.classId]?.toString() ?? '',
      name: json[ApiKey.className] ?? '',
      subject: json[ApiKey.classSubject] ?? '',
      grade: json[ApiKey.classGrade] ?? 0,
      lessonCount: json[ApiKey.lessonCount] ?? 0,
      studentCount: json[ApiKey.studentCount] ?? 0,
      classCode: json[ApiKey.classCode] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      ApiKey.classId: id,
      ApiKey.className: name,
      ApiKey.classSubject: subject,
      ApiKey.classGrade: grade,
      ApiKey.lessonCount: lessonCount,
      ApiKey.studentCount: studentCount,
      ApiKey.classCode: classCode,
    };
  }

  ClassModel copyWith({
    String? id,
    String? name,
    String? subject,
    int? grade,
    int? lessonCount,
    int? studentCount,
    String? classCode,
  }) {
    return ClassModel(
      id: id ?? this.id,
      name: name ?? this.name,
      subject: subject ?? this.subject,
      grade: grade ?? this.grade,
      lessonCount: lessonCount ?? this.lessonCount,
      studentCount: studentCount ?? this.studentCount,
      classCode: classCode ?? this.classCode,
    );
  }
}
