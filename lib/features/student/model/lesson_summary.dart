class LessonSummary {
  final int lessonId;
  final String lessonName;
  final String completionStatus; // "NotStarted", etc.
  final String? completedAt;

  LessonSummary({
    required this.lessonId,
    required this.lessonName,
    required this.completionStatus,
    this.completedAt,
  });

  factory LessonSummary.fromJson(Map<String, dynamic> json) {
    return LessonSummary(
      lessonId: json['lessonId'],
      lessonName: json['lessonName'],
      completionStatus: json['completionStatus'],
      completedAt: json['completedAt'],
    );
  }
}
