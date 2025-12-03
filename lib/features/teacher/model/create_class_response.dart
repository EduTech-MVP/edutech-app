import 'package:edutech_app/core/api/endpoints.dart';

class CreateClassResponse {
  final String message;
  final String classCode;

  CreateClassResponse({required this.message, required this.classCode});

  factory CreateClassResponse.fromJson(Map<String, dynamic> json) {
    return CreateClassResponse(
      message: json[ApiKey.createClassMessage],
      classCode: json[ApiKey.classCode],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKey.createClassMessage: message,
      ApiKey.createClassMessage: classCode,
    };
  }
}
