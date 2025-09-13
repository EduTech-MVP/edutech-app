class NavigationModel {
  final int selectedIndex;

  NavigationModel({required this.selectedIndex});

  NavigationModel copyWith({int? selectedIndex}) {
    return NavigationModel(selectedIndex: selectedIndex ?? this.selectedIndex);
  }
}
