import 'package:edutech_app/core/api/api_consumer.dart';
import 'package:edutech_app/core/api/endpoints.dart';

class StudentRepository {
  final ApiConsumer apiConsumer;

  StudentRepository({required this.apiConsumer});

  Future<List<dynamic>> getStudentClasses() async {
    try {
      final response = await apiConsumer.get(Endpoints.studentClasses);
      return response as List<dynamic>;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<dynamic>> getLessonsForClass(int classId) async {
    try {
      final path = Endpoints.studentClassLessons.replaceAll(
        '{classId}',
        classId.toString(),
      );
      final response = await apiConsumer.get(path);
      return response as List<dynamic>;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getLessonDetails(
    int classId,
    int lessonId,
  ) async {
    try {
      String path = Endpoints.studentLessonDetails
          .replaceAll('{classId}', classId.toString())
          .replaceAll('{lessonId}', lessonId.toString());

      final response = await apiConsumer.get(path);
      return response as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> joinClass(String classCode) async {
    final path = '/Student/join-class/$classCode';
    final response = await apiConsumer.post(path);
    return response as Map<String, dynamic>;
  }
}
