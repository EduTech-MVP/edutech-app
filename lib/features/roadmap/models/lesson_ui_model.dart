class Lesson {
  final int id;
  final String title;
  final bool isCompleted;
  final bool isLocked;
  final bool isActive;

  Lesson({
    required this.id,
    required this.title,
    required this.isCompleted,
    required this.isLocked,
    required this.isActive,
  });

  Lesson copyWith({bool? isCompleted, bool? isLocked, bool? isActive}) {
    return Lesson(
      id: id,
      title: title,
      isCompleted: isCompleted ?? this.isCompleted,
      isLocked: isLocked ?? this.isLocked,
      isActive: isActive ?? this.isActive,
    );
  }
}
