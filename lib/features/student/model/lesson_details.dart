class LessonDetail {
  final int lessonId;
  final String lessonName;
  final String tutorialVideoUrl;
  final String completionStatus;
  final List<LessonQuestion> questions;

  LessonDetail({
    required this.lessonId,
    required this.lessonName,
    required this.tutorialVideoUrl,
    required this.completionStatus,
    required this.questions,
  });

  factory LessonDetail.fromJson(Map<String, dynamic> json) {
    return LessonDetail(
      lessonId: json['lessonId'],
      lessonName: json['lessonName'],
      tutorialVideoUrl: json['tutorialVideoUrl'],
      completionStatus: json['completionStatus'],
      questions: (json['questions'] as List)
          .map((q) => LessonQuestion.fromJson(q))
          .toList(),
    );
  }
}

class LessonQuestion {
  final int lessonQuestionId;
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final int points;

  LessonQuestion({
    required this.lessonQuestionId,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.points,
  });

  factory LessonQuestion.fromJson(Map<String, dynamic> json) {
    return LessonQuestion(
      lessonQuestionId: json['lessonQuestionId'],
      question: json['question'],
      options: List<String>.from(json['options']),
      correctAnswerIndex: json['correctAnswerIndex'],
      points: json['points'],
    );
  }
}
