import 'package:edutech_app/core/api/dio_consumer.dart';
import 'package:edutech_app/core/api/endpoints.dart';
import 'package:edutech_app/core/errors/exceptions.dart';
import 'package:edutech_app/features/teacher/model/add_student_request.dart';
import 'package:edutech_app/features/teacher/model/add_student_response.dart';
import 'package:edutech_app/features/teacher/model/class_model.dart';
import 'package:edutech_app/features/teacher/model/create_class_request.dart';
import 'package:edutech_app/features/teacher/model/create_class_response.dart';
import 'package:flutter/foundation.dart';

class TeacherClassesController extends ChangeNotifier {
  final DioConsumer api;

  TeacherClassesController({required this.api}) {
    // Real data
    fetchClasses();
  }

  List<ClassModel> _classes = [];
  bool _loading = false;
  bool _creatingClass = false;
  String? _error;
  CreateClassResponse? _lastCreatedClass;

  List<ClassModel> get classes => _classes;
  bool get loading => _loading;
  bool get creatingClass => _creatingClass;
  String? get error => _error;
  CreateClassResponse? get lastCreatedClass => _lastCreatedClass;
  int get classCount => _classes.length;
  int get totalStudents =>
      _classes.fold(0, (sum, cls) => sum + cls.studentCount);

  Future<void> fetchClasses() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await api.get(Endpoints.classes);

      if (kDebugMode) {
        print('fetch calsses response: $response');
      }
      if (response is List) {
        _classes = response.map((json) => ClassModel.fromJson(json)).toList();
      } else if (response is Map) {
        final classList =
            response[ApiKey.teacherClasses] ?? response['classes'] ?? [];
        _classes = (classList as List)
            .map((json) => ClassModel.fromJson(json))
            .toList();
      }

      if (kDebugMode) {
        print('Fetched ${_classes.length} classes');
      }
    } on ServerException catch (e) {
      _error = e.errorModel.errorMessage;
      if (kDebugMode) {
        print(" Server Exception: $_error");
      }
    } catch (e) {
      _error = "Unexpected error: $e";
      if (kDebugMode) {
        print(" Unexpected Error: $_error");
      }
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> createClass(CreateClassRequest request) async {
    _creatingClass = true;
    _error = null;
    _lastCreatedClass = null;
    notifyListeners();

    try {
      final response = await api.post(
        Endpoints.createClass,
        data: request.toJson(),
      );
      if (kDebugMode) {
        print("Create class response: $response");
      }
      _lastCreatedClass = CreateClassResponse.fromJson(response);

      if (kDebugMode) {
        print(' Class created: ${_lastCreatedClass?.message}');
      }

      await fetchClasses();

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
      _creatingClass = false;
      notifyListeners();
    }
  }

  Future<bool> addStudentToClass(AddStudentRequest request) async {
    _loading = true;
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

      // Refresh classes
      await fetchClasses();

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
      _loading = false;
      notifyListeners();
    }
  }

  // Helper methods
  Future<void> refreshClasses() async {
    await fetchClasses();
  }

  ClassModel? getClassById(String id) {
    try {
      return _classes.firstWhere((cls) => cls.id == id);
    } catch (e) {
      return null;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
