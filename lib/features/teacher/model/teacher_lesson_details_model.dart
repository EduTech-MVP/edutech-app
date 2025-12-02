class TeacherLessonDetails {
  final int lessonId;
  final String lessonName;
  final String status;
  final String date;
  final String tutorialVideoUrl;
  final List<TeacherLessonQuestion> questions;

  TeacherLessonDetails({
    required this.lessonId,
    required this.lessonName,
    required this.status,
    required this.date,
    required this.tutorialVideoUrl,
    required this.questions,
  });

  factory TeacherLessonDetails.fromJson(Map<String, dynamic> json) {
    return TeacherLessonDetails(
      lessonId: json['lessonId'] ?? 0,
      lessonName: json['lessonName'] ?? '',
      status: json['status'] ?? 'Pending',
      date: json['date'] ?? '',
      tutorialVideoUrl: json['tutorialVideoUrl'] ?? '',
      questions: json['questions'] != null
          ? (json['questions'] as List)
                .map((q) => TeacherLessonQuestion.fromJson(q))
                .toList()
          : [],
    );
  }
}

class TeacherLessonQuestion {
  final int lessonQuestionId;
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final int points;

  TeacherLessonQuestion({
    required this.lessonQuestionId,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.points,
  });

  factory TeacherLessonQuestion.fromJson(Map<String, dynamic> json) {
    return TeacherLessonQuestion(
      lessonQuestionId: json['lessonQuestionId'] ?? 0,
      question: json['question'] ?? '',
      options: json['options'] != null
          ? List<String>.from(json['options'])
          : [],
      correctAnswerIndex: json['correctAnswerIndex'] ?? 0,
      points: json['points'] ?? 0,
    );
  }
}
