import 'subject_course.dart';

class StudentClassesState {
  final List<SubjectCourse> courses;
  final bool isLoading;

  const StudentClassesState({required this.courses, this.isLoading = false});

  StudentClassesState copyWith({
    List<SubjectCourse>? courses,
    bool? isLoading,
  }) {
    return StudentClassesState(
      courses: courses ?? this.courses,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  static StudentClassesState get initial => const StudentClassesState(
    courses: [
      SubjectCourse(
        subject: "Math",
        detail: "Class B -",
        progress: "Completed 8 lessons",
      ),
      SubjectCourse(
        subject: "Science",
        detail: "Class A - Metro Boomin",
        progress: "Completed 12 lessons",
      ),
      SubjectCourse(
        subject: "English",
        detail: "Class M - Kendrick Lamar",
        progress: "Completed 10 lessons",
      ),
      SubjectCourse(
        subject: "Arabic",
        detail: "Class C - DJ Khalid",
        progress: "Completed 7 lessons",
      ),
    ],
  );
}
