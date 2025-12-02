import 'subject_course.dart';

class StudentClassesState {
  final List<SubjectCourse> courses;
  final bool isLoading;

  const StudentClassesState({this.courses = const [], this.isLoading = false});

  StudentClassesState copyWith({
    List<SubjectCourse>? courses,
    bool? isLoading,
  }) {
    return StudentClassesState(
      courses: courses ?? this.courses,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
