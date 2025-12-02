import 'package:edutech_app/core/api/dio_consumer.dart';
import 'package:edutech_app/core/api/endpoints.dart';
import 'package:edutech_app/core/errors/exceptions.dart';
import 'package:edutech_app/features/roadmap/models/home_work_models.dart';
import 'package:flutter/foundation.dart';

class TeacherLessonDetailsController extends ChangeNotifier {
  final DioConsumer api;

  TeacherLessonDetailsController({required this.api});

  bool isLoading = false;
  String? errorMessage;

  // Data Fields
  String? videoUrl;
  List<Question> questions = [];
  int? _classId;
  int? _lessonId;

  // Homework progress
  int currentQuestionIndex = 0;
  int? selectedAnswer;
  bool isAnswered = false;

  Future<void> loadLessonDetails(int classId, int lessonId) async {
    _classId = classId;
    _lessonId = lessonId;
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final path = Endpoints.teacherLessonDetails
          .replaceAll('{classId}', classId.toString())
          .replaceAll('{lessonId}', lessonId.toString());

      if (kDebugMode) {
        print('Loading lesson details: classId=$classId, lessonId=$lessonId');
        print('Endpoint path: $path');
      }

      final data = await api.get(path);

      // Parse Video URL
      videoUrl = data['tutorialVideoUrl'];

      // Parse Questions
      if (data['questions'] != null) {
        questions = (data['questions'] as List).map((q) {
          return Question(
            id: q['lessonQuestionId'],
            text: q['question'],
            options: List<String>.from(q['options']),
            correctAnswer: q['correctAnswerIndex'],
          );
        }).toList();
      }
    } on ServerException catch (e) {
      errorMessage = e.errorModel.errorMessage;
      if (kDebugMode) {
        print("Server Exception: $errorMessage");
      }
    } catch (e) {
      errorMessage = "Failed to load lesson details.";
      if (kDebugMode) {
        print("Error loading lesson details: $e");
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Question get currentQuestion => questions[currentQuestionIndex];
  int get totalQuestions => questions.length;
  double get progress =>
      totalQuestions == 0 ? 0 : (currentQuestionIndex + 1) / totalQuestions;

  void selectAnswer(int index) {
    selectedAnswer = index;
    notifyListeners();
  }

  void submitAnswer() {
    if (selectedAnswer == null) return;
    isAnswered = true;
    notifyListeners();
  }

  void nextQuestion() {
    if (currentQuestionIndex < totalQuestions - 1) {
      currentQuestionIndex++;
      selectedAnswer = null;
      isAnswered = false;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex > 0) {
      currentQuestionIndex--;
      selectedAnswer = null;
      isAnswered = false;
      notifyListeners();
    }
  }

  void reset() {
    currentQuestionIndex = 0;
    selectedAnswer = null;
    isAnswered = false;
    questions = [];
    videoUrl = null;
    errorMessage = null;
    notifyListeners();
  }

  Future<void> updateVideoUrl(String url) async {
    if (_classId == null || _lessonId == null) {
      errorMessage = "Class ID or Lesson ID is missing";
      notifyListeners();
      throw Exception(errorMessage);
    }

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final path = Endpoints.updateVideoUrl
          .replaceAll('{classId}', _classId!.toString())
          .replaceAll('{lessonId}', _lessonId!.toString());

      if (kDebugMode) {
        print('Updating video URL: classId=$_classId, lessonId=$_lessonId');
        print('Endpoint path: $path');
        print('Video URL: $url');
      }

      await api.put(path, data: {'VideoUrl': url});

      // Update local state after successful API call
      videoUrl = url;
    } on ServerException catch (e) {
      errorMessage = e.errorModel.errorMessage;
      if (kDebugMode) {
        print("Server Exception: $errorMessage");
      }
      rethrow;
    } catch (e) {
      errorMessage = "Failed to update video URL.";
      if (kDebugMode) {
        print("Error updating video URL: $e");
      }
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
