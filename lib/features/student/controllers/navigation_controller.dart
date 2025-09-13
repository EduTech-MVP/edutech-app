import 'package:edutech_app/features/student/models/navigation_model.dart';
import 'package:flutter/foundation.dart';

class NavigationController extends ChangeNotifier {
  NavigationModel _model = NavigationModel(selectedIndex: 0);

  int get selectedIndex => _model.selectedIndex;

  void onItemTapped(int index) {
    _model = _model.copyWith(selectedIndex: index);
    notifyListeners();
  }
}
