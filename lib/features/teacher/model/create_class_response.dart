import 'package:edutech_app/core/api/endpoints.dart';

class CreateClassResponse {
  final String message;
  final int classId;

  CreateClassResponse({required this.message, required this.classId});

  factory CreateClassResponse.fromJson(Map<String, dynamic> json) {
    return CreateClassResponse(
      message: json[ApiKey.createClassMessage],
      classId: json[ApiKey.classId],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKey.createClassMessage: message,
      ApiKey.createClassMessage: classId,
    };
  }
}
