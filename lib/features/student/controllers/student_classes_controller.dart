import 'package:flutter/material.dart';
import '../model/student_classes_state.dart';
import '../model/subject_course.dart';

class StudentClassesController extends ChangeNotifier {
  StudentClassesState _state = StudentClassesState.initial;

  StudentClassesState get state => _state;
  List<SubjectCourse> get courses => _state.courses;
  bool get isLoading => _state.isLoading;

  void onContinuePressed(String subject) {
    debugPrint("Continue pressed for: $subject");
  }

  void loadCourses() {
    _updateState(_state.copyWith(isLoading: true));

    Future.delayed(const Duration(milliseconds: 500), () {
      _updateState(_state.copyWith(isLoading: false));
    });
  }

  void _updateState(StudentClassesState newState) {
    _state = newState;
    notifyListeners();
  }
}
