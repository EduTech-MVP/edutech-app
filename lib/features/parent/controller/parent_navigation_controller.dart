import 'package:edutech_app/features/parent/model/parent_navigation_model.dart';
import 'package:flutter/foundation.dart';

class ParentNavigationController extends ChangeNotifier {
  ParentNavigationModel _model = ParentNavigationModel(selectedIndex: 0);

  int get selectedIndex => _model.selectedIndex;

  void onItemTapped(int index) {
    _model = _model.copyWith(selectedIndex: index);
    notifyListeners();
  }
}
