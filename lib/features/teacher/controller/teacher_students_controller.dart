import 'package:edutech_app/core/api/dio_consumer.dart';
import 'package:edutech_app/core/api/endpoints.dart';
import 'package:edutech_app/core/errors/exceptions.dart';
import 'package:edutech_app/features/teacher/model/add_student_request.dart';
import 'package:edutech_app/features/teacher/model/add_student_response.dart';
import 'package:edutech_app/features/teacher/model/student_model.dart';
import 'package:flutter/foundation.dart';

class TeacherStudentsController extends ChangeNotifier {
  final DioConsumer api;

  TeacherStudentsController({required this.api});

  Map<String, List<StudentModel>> _classStudents = {};
  bool _loading = false;
  bool _addingStudent = false;
  String? _error;

  List<StudentModel> getStudentsForClass(String classId) {
    return _classStudents[classId] ?? [];
  }

  int getStudentCountForClass(String classId) {
    return _classStudents[classId]?.length ?? 0;
  }

  bool get loading => _loading;
  bool get addingStudent => _addingStudent;
  String? get error => _error;

  Future<void> fetchClassStudents(int classId) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final endpoint = Endpoints.classStudents.replaceAll(
        '{classId}',
        classId.toString(),
      );
      final response = await api.get(endpoint);

      if (kDebugMode) {
        print('Fetch class students response: $response');
      }

      List<StudentModel> students = [];
      if (response is List) {
        students = response.map((json) => StudentModel.fromJson(json)).toList();
      } else if (response is Map && response.containsKey('students')) {
        students = (response['students'] as List)
            .map((json) => StudentModel.fromJson(json))
            .toList();
      }

      _classStudents[classId.toString()] = students;

      if (kDebugMode) {
        print('Fetched ${students.length} students for class $classId');
      }
    } on ServerException catch (e) {
      _error = e.errorModel.errorMessage;
      if (kDebugMode) {
        print("Server Exception: $_error");
      }
    } catch (e) {
      _error = "Unexpected error: $e";
      if (kDebugMode) {
        print("Unexpected Error: $_error");
      }
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> addStudentToClass(AddStudentRequest request) async {
    _addingStudent = true;
    _error = null;
    notifyListeners();

    try {
      final response = await api.post(
        Endpoints.addStudentToClass,
        data: request.toJson(),
      );

      if (kDebugMode) {
        print('Add student response: $response');
      }

      final addStudentResponse = AddStudentResponse.fromJson(response);

      if (kDebugMode) {
        print('Student added: ${addStudentResponse.message}');
      }

      await fetchClassStudents(request.classId);

      return true;
    } on ServerException catch (e) {
      _error = e.errorModel.errorMessage;
      if (kDebugMode) {
        print("Server Exception: $_error");
      }
      return false;
    } catch (e) {
      _error = "Unexpected error: $e";
      if (kDebugMode) {
        print("Unexpected Error: $_error");
      }
      return false;
    } finally {
      _addingStudent = false;
      notifyListeners();
    }
  }

  void removeStudentFromClass(String classId, String studentId) {
    if (_classStudents.containsKey(classId)) {
      _classStudents[classId]!.removeWhere(
        (student) => student.id == studentId,
      );
      notifyListeners();
    }
  }

  void updateStudent(String classId, StudentModel updatedStudent) {
    if (_classStudents.containsKey(classId)) {
      final index = _classStudents[classId]!.indexWhere(
        (student) => student.id == updatedStudent.id,
      );

      if (index != -1) {
        _classStudents[classId]![index] = updatedStudent;
        notifyListeners();
      }
    }
  }
}
