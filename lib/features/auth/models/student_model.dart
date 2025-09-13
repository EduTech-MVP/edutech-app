class Student {
  final String fullName;
  final String username;
  final DateTime dateOfBirth;
  final int grade;

  Student({
    required this.fullName,
    required this.username,
    required this.dateOfBirth,
    required this.grade,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'username': username,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'grade': grade,
    };
  }
}
