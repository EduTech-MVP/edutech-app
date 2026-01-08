import 'package:edutech_app/core/api/dio_consumer.dart';
import 'package:edutech_app/core/api/endpoints.dart';
import 'package:edutech_app/core/errors/exceptions.dart';
import 'package:edutech_app/core/models/ai_evaluation_model.dart';
import 'package:edutech_app/core/utils/teacher_ai_evaluation_generator.dart';
import 'package:edutech_app/features/teacher/model/student_profile_response.dart';
import 'package:flutter/foundation.dart';

class TeacherStudentProfileController extends ChangeNotifier {
  final DioConsumer api;

  TeacherStudentProfileController({required this.api});

  StudentProfileData? _studentProfile;
  bool _loading = false;
  String? _error;
  AIEvaluation? _aiEvaluation;

  StudentProfileData? get studentProfile => _studentProfile;
  bool get loading => _loading;
  String? get error => _error;
  AIEvaluation? get aiEvaluation => _aiEvaluation;

  Future<bool> fetchStudentProfile(int studentId) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final endpoint = Endpoints.studentProfile.replaceAll(
        '{studentId}',
        studentId.toString(),
      );
      final response = await api.get(endpoint);

      if (kDebugMode) {
        print('Fetch student profile response: $response');
      }

      final profileResponse = StudentProfileResponse.fromJson(response);

      if (profileResponse.success) {
        _studentProfile = profileResponse.data;
        
        // Generate AI evaluation based on student progress (teacher-specific)
        if (_studentProfile != null) {
          _aiEvaluation = TeacherAIEvaluationGenerator.generateEvaluation(
            studentId: _studentProfile!.studentId,
            studentName: _studentProfile!.fullName,
            completedLessons: _studentProfile!.completedLessons,
            totalLessons: _studentProfile!.totalLessons,
          );
        }
        
        if (kDebugMode) {
          print('Fetched student profile for studentId: $studentId');
          print(
            'Student: ${_studentProfile?.firstName} ${_studentProfile?.lastName}',
          );
          print('Grade: ${_studentProfile?.grade}');
          print(
            'Progress: ${_studentProfile?.overallProgressPercentage.toStringAsFixed(1)}%',
          );
        }
        return true;
      } else {
        _error = 'Failed to fetch student profile';
        return false;
      }
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

  void clearProfile() {
    _studentProfile = null;
    _error = null;
    _aiEvaluation = null;
    notifyListeners();
  }

  void refreshProfile(int studentId) {
    fetchStudentProfile(studentId);
  }
}
