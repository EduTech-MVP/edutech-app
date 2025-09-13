class ParentNavigationModel {
  final int selectedIndex;

  ParentNavigationModel({required this.selectedIndex});

  ParentNavigationModel copyWith({int? selectedIndex}) {
    return ParentNavigationModel(selectedIndex: selectedIndex ?? this.selectedIndex);
  }
}
