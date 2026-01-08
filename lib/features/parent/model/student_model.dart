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
    // Handle profile image path - convert relative to absolute URL
    String? profilePicture = json['profilePicture'];
    if (profilePicture != null && profilePicture.isNotEmpty) {
      // Convert relative path to absolute URL
      if (profilePicture.startsWith('/') && !profilePicture.startsWith('//')) {
        profilePicture = 'http://edutech.runasp.net$profilePicture';
      }
      // If it's already a full URL, keep it as is
    } else {
      profilePicture = ''; // Set to empty string if null
    }

    return Student(
      studentId: json['studentId'] ?? 0,
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      fullName: json['fullName'] ?? '',
      grade: json['grade'] ?? 0,
      profilePicture: profilePicture,
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

  // Make sure this method exists
  static List<Student> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => Student.fromJson(json)).toList();
  }
}
