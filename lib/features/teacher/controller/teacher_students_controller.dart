import 'package:edutech_app/features/teacher/model/student_model.dart';
import 'package:flutter/foundation.dart';

class TeacherStudentsController extends ChangeNotifier {
  Map<String, List<StudentModel>> _classStudents = {};

  List<StudentModel> getStudentsForClass(String classId) {
    return _classStudents[classId] ?? [];
  }

  int getStudentCountForClass(String classId) {
    return _classStudents[classId]?.length ?? 0;
  }

  TeacherStudentsController() {
    // Mock data for demonstration
    _loadStudents();
  }

  void _loadStudents() {
    _classStudents = {
      '1': [
        // Class M
        StudentModel(
          id: '1',
          name: 'Aubrey Graham',
          username: '@certifiedloverboy',
          completedLessons: 37,
          points: 67,
        ),
        StudentModel(
          id: '2',
          name: 'Kendrick Lamar',
          username: '@kdot',
          completedLessons: 42,
          points: 89,
        ),
        StudentModel(
          id: '3',
          name: 'Metro Boomin',
          username: '@metroboomin',
          completedLessons: 28,
          points: 54,
        ),
      ],
      '2': [
        // Class B
        StudentModel(
          id: '4',
          name: 'DJ Khaled',
          username: '@wethebestmusic',
          completedLessons: 19,
          points: 45,
        ),
        StudentModel(
          id: '5',
          name: 'Travis Scott',
          username: '@travisscott',
          completedLessons: 31,
          points: 72,
        ),
      ],
    };
    notifyListeners();
  }

  void addStudentToClass(String classId, String username) {
    // Create a mock student with the username
    final student = StudentModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: 'New Student',
      username: username,
      completedLessons: 0,
      points: 0,
    );

    if (_classStudents.containsKey(classId)) {
      _classStudents[classId]!.add(student);
    } else {
      _classStudents[classId] = [student];
    }
    notifyListeners();
  }

  void removeStudentFromClass(String classId, String studentId) {
    if (_classStudents.containsKey(classId)) {
      _classStudents[classId]!.removeWhere(
        (student) => student.id == studentId,
      );
      notifyListeners();
    }
  }

  void updateStudent(String classId, StudentModel updatedStudent) {
    if (_classStudents.containsKey(classId)) {
      final index = _classStudents[classId]!.indexWhere(
        (student) => student.id == updatedStudent.id,
      );

      if (index != -1) {
        _classStudents[classId]![index] = updatedStudent;
        notifyListeners();
      }
    }
  }
}
