import 'package:edutech_app/features/student/repositories/student_repo.dart';
import 'package:flutter/material.dart';
import 'package:edutech_app/core/api/api_consumer.dart';
import 'package:edutech_app/features/roadmap/models/lesson_ui_model.dart';
import 'package:get/get.dart';

class LessonProvider extends ChangeNotifier {
  final StudentRepository _repository;

  LessonProvider({required ApiConsumer apiConsumer})
    : _repository = StudentRepository(apiConsumer: apiConsumer);

  List<Lesson> _lessons = [];
  bool _isLoading = false;

  List<Lesson> get lessons => _lessons;
  bool get isLoading => _isLoading;

  Future<void> loadLessons(int classId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = await _repository.getLessonsForClass(classId);

      List<Lesson> loadedLessons = [];

      for (int i = 0; i < data.length; i++) {
        final json = data[i];
        final bool isCompleted = json['completionStatus'] == 'Completed';

        bool isLocked = false;
        if (i > 0) {
          final prevJson = data[i - 1];
          if (prevJson['completionStatus'] != 'Completed') {
            isLocked = true;
          }
        }

        bool isActive = !isLocked && !isCompleted;

        loadedLessons.add(
          Lesson(
            id: json['lessonId'],
            title: json['lessonName'],
            isCompleted: isCompleted,
            isLocked: isLocked,
            isActive: isActive,
          ),
        );
      }

      _lessons = loadedLessons;
    } catch (e) {
      debugPrint("Error loading lessons: $e");
      Get.snackbar(
        "Error",
        "Failed to load roadmap",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void completeLesson(int lessonId) {
    final index = _lessons.indexWhere((l) => l.id == lessonId);
    if (index != -1) {
      _lessons[index] = _lessons[index].copyWith(
        isCompleted: true,
        isActive: false,
      );

      if (index + 1 < _lessons.length) {
        _lessons[index + 1] = _lessons[index + 1].copyWith(
          isLocked: false,
          isActive: true,
        );
      }

      notifyListeners();
    }
  }
}
