class AddStudentRequest {
  final String fullName;
  final String username;
  final String password;
  final String confirmPassword;
  final String dateOfBirth;
  final int grade;

  AddStudentRequest({
    required this.fullName,
    required this.username,
    required this.password,
    required this.confirmPassword,
    required this.dateOfBirth,
    required this.grade,
  });

  Map<String, dynamic> toJson() {
    return {
      "fullName": fullName,
      "username": username,
      "password": password,
      "confirmPassword": confirmPassword,
      "dateOfBirth": dateOfBirth,
      "grade": grade,
    };
  }
}
