class StudentModel {
  final String id;
  final String name;
  final String username;
  final int completedLessons;
  final int points;
  final String? profileImageUrl;

  StudentModel({
    required this.id,
    required this.name,
    required this.username,
    required this.completedLessons,
    required this.points,
    this.profileImageUrl,
  });

  StudentModel copyWith({
    String? id,
    String? name,
    String? username,
    int? completedLessons,
    int? points,
    String? profileImageUrl,
  }) {
    return StudentModel(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      completedLessons: completedLessons ?? this.completedLessons,
      points: points ?? this.points,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }
}
