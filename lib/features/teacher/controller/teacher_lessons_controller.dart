import 'package:edutech_app/core/api/api_consumer.dart';
import 'package:edutech_app/core/api/endpoints.dart';
import 'package:edutech_app/features/teacher/model/lesson_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class TeacherLessonsController extends ChangeNotifier {
  final ApiConsumer apiConsumer;

  TeacherLessonsController({required this.apiConsumer});

  List<TeacherLesson> _lessons = [];
  bool _isLoading = false;
  String? _error;

  List<TeacherLesson> get lessons => _lessons;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadLessons(int classId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final path = Endpoints.teacherLessons.replaceAll(
        '{classId}',
        classId.toString(),
      );
      final data = await apiConsumer.get(path);

      List<TeacherLesson> loadedLessons = [];

      if (data is List) {
        for (int i = 0; i < data.length; i++) {
          final json = data[i];
          loadedLessons.add(TeacherLesson.fromJson(json, i, data));
        }
      }

      _lessons = loadedLessons;
    } catch (e) {
      _error = "Failed to load lessons: $e";
      if (kDebugMode) {
        print("Error loading lessons: $e");
      }
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
    final index = _lessons.indexWhere((lesson) => lesson.id == lessonId);
    if (index != -1) {
      _lessons[index] = _lessons[index].copyWith(
        isCompleted: true,
        isLocked: false,
        isActive: false,
      );
      // Unlock next lesson if exists
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
