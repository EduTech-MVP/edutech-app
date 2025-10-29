import 'package:edutech_app/core/api/endpoints.dart';

class AddStudentResponse {
  final String message;
  final Enrollment enrollment;

  AddStudentResponse({required this.message, required this.enrollment});

  factory AddStudentResponse.fromJson(Map<String, dynamic> json) {
    return AddStudentResponse(
      message: json[ApiKey.addStudentMessage],
      enrollment: Enrollment.fromJson(json[ApiKey.enrollment]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKey.addStudentMessage: message,
      'enrollment': enrollment.toJson(),
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
      studentId: json['studentId'],
      username: json['username'],
      studentName: json['studentName'],
      classId: json['classId'],
      className: json['className'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'username': username,
      'studentName': studentName,
      'classId': classId,
      'className': className,
    };
  }
}
