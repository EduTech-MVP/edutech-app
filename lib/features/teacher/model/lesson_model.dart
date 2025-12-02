class TeacherLesson {
  final int id;
  final String title;
  final bool isCompleted;
  final bool isLocked;
  final bool isActive;

  TeacherLesson({
    required this.id,
    required this.title,
    required this.isCompleted,
    required this.isLocked,
    required this.isActive,
  });

  factory TeacherLesson.fromJson(
    Map<String, dynamic> json,
    int index,
    List<dynamic> allLessons,
  ) {
    // API returns 'status' field with values like "Pending", "Completed", etc.
    final String status =
        json['status'] ?? json['completionStatus'] ?? 'Pending';
    final bool isCompleted = status == 'Completed' || status == 'completed';

    // For teachers, all lessons are unlocked - they can view/manage all lessons
    const bool isLocked = false;
    final bool isActive = !isCompleted;

    return TeacherLesson(
      id: json['lessonId'] ?? json['id'] ?? 0,
      title: json['lessonName'] ?? json['title'] ?? '',
      isCompleted: isCompleted,
      isLocked: isLocked,
      isActive: isActive,
    );
  }

  TeacherLesson copyWith({bool? isCompleted, bool? isLocked, bool? isActive}) {
    return TeacherLesson(
      id: id,
      title: title,
      isCompleted: isCompleted ?? this.isCompleted,
      isLocked: isLocked ?? this.isLocked,
      isActive: isActive ?? this.isActive,
    );
  }
}
