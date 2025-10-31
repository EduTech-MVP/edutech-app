class Student {
  final int studentId;
  final String firstName;
  final String lastName;
  final String fullName;
  final int grade;
  final String profilePicture;

  Student({
    required this.studentId,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.grade,
    required this.profilePicture,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      studentId: json['studentId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      fullName: json['fullName'],
      grade: json['grade'],
      profilePicture: json['profilePicture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'firstName': firstName,
      'lastName': lastName,
      'fullName': fullName,
      'grade': grade,
      'profilePicture': profilePicture,
    };
  }

  static List<Student> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => Student.fromJson(json)).toList();
  }
}
