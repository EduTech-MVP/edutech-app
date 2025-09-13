class User {
  final String? fullName;
  final String? username;
  final String? email;
  final String? password;
  final String? confirmPassword;
  final String? dateOfBirth;
  final String? userType;
  final String? bio;
  final String? subject;
  final String? profileImagePath;

  User({
    this.fullName,
    this.username,
    this.email,
    this.password,
    this.confirmPassword,
    this.dateOfBirth,
    this.userType,
    this.bio,
    this.subject,
    this.profileImagePath,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullName: json['fullName'] ?? json['FullName'],
      username: json['username'] ?? json['Username'],
      email: json['email'] ?? json['Email'],
      dateOfBirth: json['dateOfBirth'] ?? json['DateOfBirth'],
      userType: json['userType'] ?? json['UserType'],
      bio: json['bio'] ?? json['Bio'],
      subject: json['subject'] ?? json['Subject'],
      profileImagePath:
          json['profileImageUrl'] ??
          json['profileImagePath'] ??
          json['ProfileImagePath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'username': username,
      'email': email,
      'dateOfBirth': dateOfBirth,
      'userType': userType,
      'bio': bio,
      'subject': subject,
      'profileImagePath': profileImagePath,
    };
  }

  /// Validates required fields for registration.
  bool validateForRegistration() {
    return email != null &&
        email!.isNotEmpty &&
        password != null &&
        password!.isNotEmpty &&
        confirmPassword != null &&
        confirmPassword!.isNotEmpty &&
        password == confirmPassword &&
        userType != null &&
        ['Parent', 'Teacher'].contains(userType);
  }
}
