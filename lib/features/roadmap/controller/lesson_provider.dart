import 'package:edutech_app/features/roadmap/models/lesson_ui_model.dart';
import 'package:flutter/material.dart';

class LessonProvider extends ChangeNotifier {
  final List<Lesson> _lessons = [
    Lesson(
      id: 1,
      title: 'Introduction',
      isCompleted: false,
      isLocked: false,
      isActive: true,
    ),
    Lesson(
      id: 2,
      title: 'Basic Math',
      isCompleted: false,
      isLocked: true,
      isActive: false,
    ),
    Lesson(
      id: 3,
      title: 'Algebra',
      isCompleted: false,
      isLocked: true,
      isActive: false,
    ),
    Lesson(
      id: 4,
      title: 'Geometry',
      isCompleted: false,
      isLocked: true,
      isActive: false,
    ),
    Lesson(
      id: 5,
      title: 'Trigonometry',
      isCompleted: false,
      isLocked: true,
      isActive: false,
    ),
    Lesson(
      id: 6,
      title: 'Slavery',
      isCompleted: false,
      isLocked: true,
      isActive: false,
    ),
    Lesson(
      id: 7,
      title: 'Statistics',
      isCompleted: false,
      isLocked: true,
      isActive: false,
    ),
    Lesson(
      id: 8,
      title: 'Probability',
      isCompleted: false,
      isLocked: true,
      isActive: false,
    ),
    Lesson(
      id: 9,
      title: 'Advanced Topics',
      isCompleted: false,
      isLocked: true,
      isActive: false,
    ),
    Lesson(
      id: 10,
      title: 'Final Test',
      isCompleted: false,
      isLocked: true,
      isActive: false,
    ),
  ];

  List<Lesson> get lessons => _lessons;

  void completeLesson(int lessonId) {
    final index = _lessons.indexWhere((l) => l.id == lessonId);
    if (index != -1) {
      _lessons[index] = _lessons[index].copyWith(
        isCompleted: true,
        isActive: false,
      );

      // Unlock next lesson and make it active
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
