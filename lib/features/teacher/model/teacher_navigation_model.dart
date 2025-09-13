class TeacherNavigationModel {
  final int selectedIndex;

  TeacherNavigationModel({required this.selectedIndex});

  TeacherNavigationModel copyWith({int? selectedIndex}) {
    return TeacherNavigationModel(selectedIndex: selectedIndex ?? this.selectedIndex);
  }
}
