class Endpoints {
  static const String baseUrl = 'http://edutech.runasp.net/api';
  static String profile = '/Auth/profile';
  static String signin = '/Auth/login';
  static String register = '/Auth/register';
  static String uploadProfileImage = '/Auth/upload-profile-image';
  static String deleteProfileImage = '/Auth/delete-profile-image';
  static String addStudent = '/Auth/parent/add-student';

  static String createSession = '/ChatBot/create-session';
  static String sendMessage = '/ChatBot/send-message';
  static String getSessions = '/ChatBot/sessions';
  static String sessionsHistory = '/ChatBot/history/{sessionId}';
}

class ApiKey {
  static String fullName = "FullName";
  static String userName = "Username";
  static String signupEmail = "Email";
  static String signupPassword = "Password";
  static String confirmPassword = "ConfirmPassword";
  static String dateofBirth = "DateOfBirth";
  static String signupUserType = "UserType";
  static String bio = 'Bio';
  static String bio = 'Bio';

  static String email = "email";
  static String password = "password";
  static String userType = "userType";
  static const String student = "Student";
  static const String teacher = "Teacher";
  static const String parent = "Parent";

  static String profileImage = "ProfileImage";
  static String token = "token";
  static String user = "user";
  static String id = "id";
  static String firstName = "firstName";
  static String lastName = "lastName";
}
