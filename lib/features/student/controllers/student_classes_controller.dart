import 'package:edutech_app/features/student/model/student_class_state.dart';
import 'package:edutech_app/features/student/model/subject_course.dart';
import 'package:edutech_app/features/student/repositories/student_repo.dart';
import 'package:flutter/material.dart';
import 'package:edutech_app/core/api/api_consumer.dart';

class StudentClassesController extends ChangeNotifier {
  final StudentRepository _repository;

  // Constructor
  StudentClassesController({required ApiConsumer apiConsumer})
    : _repository = StudentRepository(apiConsumer: apiConsumer);

  // Initialize State
  StudentClassesState _state = const StudentClassesState(isLoading: true);

  // Getters
  StudentClassesState get state => _state;
  List<SubjectCourse> get courses => _state.courses;
  bool get isLoading => _state.isLoading;

  Future<void> loadCourses() async {
    _updateState(_state.copyWith(isLoading: true));

    try {
      final data = await _repository.getStudentClasses();

      final List<SubjectCourse> loadedCourses = data.map((json) {
        return SubjectCourse(
          id: json['classId'],
          subject: json['subject'] ?? 'Unknown',
          detail: "${json['className']} - ${json['teacherName']}",
          progress: "Completed ${json['completedLessons']} lessons",
        );
      }).toList();

      _updateState(_state.copyWith(courses: loadedCourses, isLoading: false));
    } catch (e) {
      debugPrint("Error loading classes: $e");
      _updateState(_state.copyWith(isLoading: false));
    }
  }

  void _updateState(StudentClassesState newState) {
    _state = newState;
    notifyListeners();
  }
}
