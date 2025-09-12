class OnboardingData {
  String? fullName;
  String? email;
  String? username;
  String? password;
  String? confirmPassword;
  String? profilePicturePath;
  String? bio;
  DateTime? dateOfBirth;

  OnboardingData({
    this.fullName,
    this.email,
    this.username,
    this.password,
    this.confirmPassword,
    this.profilePicturePath,
    this.bio,
    this.dateOfBirth,
  });

  bool get isPersonalInfoComplete =>
      fullName != null &&
      fullName!.isNotEmpty &&
      email != null &&
      email!.isNotEmpty;

  bool get isAccountSecurityComplete =>
      username != null &&
      username!.isNotEmpty &&
      password != null &&
      password!.isNotEmpty &&
      confirmPassword != null &&
      confirmPassword!.isNotEmpty &&
      password == confirmPassword;

  bool get isAdditionalDetailsComplete => dateOfBirth != null;

  bool get isComplete =>
      isPersonalInfoComplete &&
      isAccountSecurityComplete &&
      isAdditionalDetailsComplete;

  @override
  String toString() {
    return 'OnboardingData(fullName: $fullName, email: $email, username: $username, '
        'password: ${password != null ? "****" : null}, '
        'confirmPassword: ${confirmPassword != null ? "****" : null}, '
        'profilePicturePath: $profilePicturePath, bio: $bio, dateOfBirth: $dateOfBirth)';
  }
}
