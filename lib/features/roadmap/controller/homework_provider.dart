import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/features/roadmap/models/home_work_models.dart';
import 'package:edutech_app/features/roadmap/models/lesson_ui_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeworkProvider extends ChangeNotifier {
  final Lesson lesson;
  int currentQuestionIndex = 0;
  int? selectedAnswer;
  bool isAnswered = false;

  final List<Question> questions = [
    Question(
      id: 1,
      text: 'What year did the Civil War end?',
      options: ['1863', '1865', '1867', '1870'],
      correctAnswer: 1,
    ),
    Question(
      id: 2,
      text: 'Who was the president during the Civil War?',
      options: [
        'George Washington',
        'Abraham Lincoln',
        'Thomas Jefferson',
        'Andrew Jackson',
      ],
      correctAnswer: 1,
    ),
  ];

  HomeworkProvider(this.lesson);

  Question get currentQuestion => questions[currentQuestionIndex];

  int get totalQuestions => questions.length;

  double get progress => (currentQuestionIndex + 1) / totalQuestions;

  int get progressPercentage => (progress * 100).round();

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

  void finishHomework(BuildContext context, Function(int)? onComplete) {
    onComplete?.call(lesson.id);
    Get.back();
    Get.snackbar(
      'Congratulations!',
      'Homework completed successfully!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.neutral100,
      colorText: AppColors.neutral900,
      duration: const Duration(seconds: 2),
    );
  }
}
