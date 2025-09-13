import 'package:edutech_app/features/teacher/model/teacher_navigation_model.dart';
import 'package:flutter/foundation.dart';

class TeacherNavigationController extends ChangeNotifier {
  TeacherNavigationModel _model = TeacherNavigationModel(selectedIndex: 0);

  int get selectedIndex => _model.selectedIndex;

  void onItemTapped(int index) {
    _model = _model.copyWith(selectedIndex: index);
    notifyListeners();
  }
}
