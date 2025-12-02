import 'package:edutech_app/features/roadmap/models/home_work_models.dart';
import 'package:edutech_app/features/student/repositories/student_repo.dart';
import 'package:flutter/material.dart';
import 'package:edutech_app/core/api/api_consumer.dart';

class LessonDetailsProvider extends ChangeNotifier {
  final StudentRepository _repository;

  LessonDetailsProvider({required ApiConsumer apiConsumer})
    : _repository = StudentRepository(apiConsumer: apiConsumer);

  bool isLoading = true;
  String? errorMessage;

  // Data Fields
  String? videoUrl;
  List<Question> questions = [];

  //   homework progress
  int currentQuestionIndex = 0;
  int? selectedAnswer;
  bool isAnswered = false;

  Future<void> loadLessonDetails(int classId, int lessonId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final data = await _repository.getLessonDetails(classId, lessonId);

      //  Parse Video URL
      videoUrl = data['tutorialVideoUrl'];

      //   Parse Questions
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
    } catch (e) {
      errorMessage = "Failed to load lesson details.";
      debugPrint("Error: $e");
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
    if (selectedAnswer != null) {
      isAnswered = true;
      notifyListeners();
    }
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      currentQuestionIndex++;
      selectedAnswer = null;
      isAnswered = false;
      notifyListeners();
    }
  }

  void finishHomework(
    BuildContext context,
    Function(int)? onComplete,
    int lessonId,
  ) {
    if (onComplete != null) {
      onComplete(lessonId);
    }
    Navigator.pop(context);
  }
}
