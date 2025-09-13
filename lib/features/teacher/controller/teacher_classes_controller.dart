import 'package:edutech_app/features/teacher/model/class_model.dart';
import 'package:flutter/foundation.dart';

class TeacherClassesController extends ChangeNotifier {
  List<ClassModel> _classes = [];

  List<ClassModel> get classes => _classes;

  int get classCount => _classes.length;
  int get totalStudents =>
      _classes.fold(0, (sum, cls) => sum + cls.studentCount);

  TeacherClassesController() {
    // Mock data for demonstration
    _loadClasses();
  }

  void _loadClasses() {
    _classes = [
      ClassModel(
        id: '1',
        name: 'Class M',
        subject: 'English',
        grade: '4th grade',
        lessonCount: 18,
        studentCount: 7,
      ),
      ClassModel(
        id: '2',
        name: 'Class B',
        subject: 'English',
        grade: '4th grade',
        lessonCount: 22,
        studentCount: 7,
      ),
    ];
    notifyListeners();
  }

  void addClass(ClassModel newClass) {
    _classes.add(newClass);
    notifyListeners();
  }

  void updateClass(String id, ClassModel updatedClass) {
    final index = _classes.indexWhere((cls) => cls.id == id);
    if (index != -1) {
      _classes[index] = updatedClass;
      notifyListeners();
    }
  }

  void deleteClass(String id) {
    _classes.removeWhere((cls) => cls.id == id);
    notifyListeners();
  }
}
