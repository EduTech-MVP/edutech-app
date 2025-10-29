import 'package:edutech_app/core/api/endpoints.dart';

class CreateClassRequest {
  final String className;
  final String subject;
  final int grade;

  CreateClassRequest({
    required this.className,
    required this.subject,
    required this.grade,
  });

  Map<String, dynamic> toJson() {
    return {
      ApiKey.className: className,
      ApiKey.classSubject: subject,
      ApiKey.classGrade: grade,
    };
  }
}
