class Student {
  final int studentId;
  final String firstName;
  final String lastName;
  final String fullName;
  final int grade;
  final String learningLevel;
  final int clusterId;
  final String profileImagePath;
  final int completedLessons;
  final int totalLessons;

  Student({
    required this.studentId,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.grade,
    required this.learningLevel,
    required this.clusterId,
    required this.profileImagePath,
    required this.completedLessons,
    required this.totalLessons,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      studentId: json['studentId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      fullName: json['fullName'],
      grade: json['grade'],
      learningLevel: json['learningLevel'],
      clusterId: json['clusterId'],
      profileImagePath: json['profileImagePath'],
      completedLessons: json['completedLessons'],
      totalLessons: json['totalLessons'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'firstName': firstName,
      'lastName': lastName,
      'fullName': fullName,
      'grade': grade,
      'learningLevel': learningLevel,
      'clusterId': clusterId,
      'profileImagePath': profileImagePath,
      'completedLessons': completedLessons,
      'totalLessons': totalLessons,
    };
  }
}
