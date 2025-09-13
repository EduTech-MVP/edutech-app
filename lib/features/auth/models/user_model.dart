class User {
  final String id;
  final String fullName;
  final String username;
  final String email;
  final String userType;
  final String profileImage;
  final String? bio;
  final String? subject;
  final DateTime dateOfBirth;

  User({
    required this.id,
    required this.fullName,
    required this.username,
    required this.email,
    required this.userType,
    required this.profileImage,
    this.bio,
    this.subject,
    required this.dateOfBirth,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    // Normalize userType to handle variations (e.g., 'role', 'UserType', case differences)
    String? rawUserType = json['UserType'] ?? json['userType'] ?? json['role'];
    String normalizedUserType = 'Unknown';
    if (rawUserType != null) {
      // Convert to title case and match expected values
      String lowerType = rawUserType.toLowerCase();
      if (lowerType == 'teacher') {
        normalizedUserType = 'Teacher';
      } else if (lowerType == 'parent') {
        normalizedUserType = 'Parent';
      } else if (lowerType == 'student') {
        normalizedUserType = 'Student';
      } else {
        print('Unexpected userType: $rawUserType');
      }
    }

    return User(
      id: json['nameidentifier'] ?? '',
      fullName: json['name'] ?? '',
      username: json['username'] ?? '',
      email: json['emailaddress'] ?? '',
      userType: normalizedUserType,
      profileImage: json['profileImage'] ?? '',
      bio: json['bio'],
      subject: json['subject'],
      dateOfBirth: DateTime.parse(
        json['dateOfBirth'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }
}
