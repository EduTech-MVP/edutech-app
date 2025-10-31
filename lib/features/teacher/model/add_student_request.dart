import 'package:edutech_app/core/api/endpoints.dart';

class AddStudentRequest {
  final String username;
  final int classId;

  AddStudentRequest({required this.username, required this.classId});

  Map<String, dynamic> toJson() {
    return {ApiKey.studentUserName: username, ApiKey.classIdRequest: classId};
  }
}
