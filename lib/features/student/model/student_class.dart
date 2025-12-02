class StudentClass {
  final int classId;
  final String className;
  final String subject;
  final int grade;
  final String teacherName;
  final int completedLessons;

  StudentClass({
    required this.classId,
    required this.className,
    required this.subject,
    required this.grade,
    required this.teacherName,
    required this.completedLessons,
  });

  factory StudentClass.fromJson(Map<String, dynamic> json) {
    return StudentClass(
      classId: json['classId'],
      className: json['className'],
      subject: json['subject'],
      grade: json['grade'],
      teacherName: json['teacherName'],
      completedLessons: json['completedLessons'],
    );
  }
}
