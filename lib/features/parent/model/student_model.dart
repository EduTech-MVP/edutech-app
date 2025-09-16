class Student {
  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final int grade;
  final String learningLevel;
  final int clusterId;
  final String profileImagePath;

  Student({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.grade,
    required this.learningLevel,
    required this.clusterId,
    required this.profileImagePath,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      username: json['username'],
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      grade: json['grade'],
      learningLevel: json['learningLevel'],
      clusterId: json['clusterId'],
      profileImagePath: json['profileImagePath'],
    );
  }
}
