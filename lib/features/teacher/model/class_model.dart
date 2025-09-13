class ClassModel {
  final String id;
  final String name;
  final String subject;
  final String grade;
  final int lessonCount;
  final int studentCount;

  ClassModel({
    required this.id,
    required this.name,
    required this.subject,
    required this.grade,
    required this.lessonCount,
    required this.studentCount,
  });

  ClassModel copyWith({
    String? id,
    String? name,
    String? subject,
    String? grade,
    int? lessonCount,
    int? studentCount,
  }) {
    return ClassModel(
      id: id ?? this.id,
      name: name ?? this.name,
      subject: subject ?? this.subject,
      grade: grade ?? this.grade,
      lessonCount: lessonCount ?? this.lessonCount,
      studentCount: studentCount ?? this.studentCount,
    );
  }
}
