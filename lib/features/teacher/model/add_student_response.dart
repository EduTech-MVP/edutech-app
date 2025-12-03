import 'package:edutech_app/core/api/endpoints.dart';

class AddStudentResponse {
  final String message;
  final Enrollment? enrollment;

  AddStudentResponse({required this.message, this.enrollment});

  factory AddStudentResponse.fromJson(Map<String, dynamic> json) {
    return AddStudentResponse(
      message:
          json[ApiKey.addStudentMessage] ??
          json[ApiKey.message] ??
          json['message'] ??
          'Student added successfully',
      enrollment: json[ApiKey.enrollment] != null
          ? Enrollment.fromJson(json[ApiKey.enrollment])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKey.addStudentMessage: message,
      if (enrollment != null) ApiKey.enrollment: enrollment!.toJson(),
    };
  }
}

class Enrollment {
  final int studentId;
  final String username;
  final String studentName;
  final int classId;
  final String className;

  Enrollment({
    required this.studentId,
    required this.username,
    required this.studentName,
    required this.classId,
    required this.className,
  });

  factory Enrollment.fromJson(Map<String, dynamic> json) {
    return Enrollment(
      studentId: json[ApiKey.studentId] ?? 0,
      username: json[ApiKey.userName] ?? json['username'] ?? '',
      studentName: json[ApiKey.studentName] ?? json['studentName'] ?? '',
      classId: json[ApiKey.classId] ?? 0,
      className: json[ApiKey.className] ?? json['className'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKey.studentId: studentId,
      ApiKey.userName: username,
      ApiKey.studentName: studentName,
      ApiKey.classId: classId,
      ApiKey.className: className,
    };
  }
}
