class Endpoints {
  static const String staticBaseUrl = 'http://edutech.runasp.net';
  static String profile = '/Auth/profile';
  static String signin = '/Auth/login';
  static String register = '/Auth/signup';
  static String uploadProfileImage = '/Auth/upload-profile-image';
  static String deleteProfileImage = '/Auth/delete-profile-image';
  static String addStudent = '/Auth/parent/add-student';
  static String forgotPassword = '/Auth/forgot-password';
  static String verifyResetPassword = '/Auth/verify-reset-code';
  static String resetPassword = '/Auth/reset-password';

  static String createSession = '/ChatBot/create-session';
  static String sendMessage = '/ChatBot/send-message';
  static String getSessions = '/ChatBot/sessions';
  static String sessionsHistory = '/ChatBot/history';
  static String deletesession = '/ChatBot/session';

  static String parentHome = '/Parent/home';
  static String parentChildren = '/Parent/children';
  static String childInfo = '/Parent/child/{childId}';
  static String childSessions = '/Parent/child/{childId}/sessions';

  // Teacher endpoints
  static String classes = '/Teacher/classes';
  static String createClass = '/Teacher/create-class';
  static String classStudents = '/Teacher/classes/{classId}/students';
  static String addStudentToClass = '/Teacher/add-student-to-class';
  static String studentProfile = '/Teacher/students/{studentId}/profile';

  // Student endpoints
  static const String studentClasses = '/Student/classes';
  static const String studentClassLessons =
      '/Student/classes/{classId}/lessons';
  static const String studentLessonDetails =
      '/Student/classes/{classId}/lessons/{lessonId}';
}

class ApiKey {
  //signup apikeys
  static String fullName = "FullName";
  static String userName = "Username";
  static String signupEmail = "Email";
  static String signupPassword = "Password";
  static String confirmPassword = "ConfirmPassword";
  static String dateofBirth = "DateOfBirth";
  static String signupUserType = "UserType";
  static String bio = 'Bio';
  static String refreshToken = "refreshToken";
  static String profileImage = "ProfileImage";

  // signin apikeys
  static String email = "email";
  static String password = "password";
  static String userType = "userType";
  static const String student = "Student";
  static const String teacher = "Teacher";
  static const String parent = "Parent";

  static String profileImageurl = "profileImageUrl";
  static String profileImagePath = "profileImagePath";
  static String token = "token";
  static String user = "user";
  static String id = "id";
  static String firstName = "firstName";
  static String lastName = "lastName";
  //image
  static String imageurl = "imageUrl";

  //forgot password
  static String resetCode = "code";
  static String newPassword = "newPassword";
  static String resetToken = "resetToken";
  //chat bot apikeys
  static String sessionid = "sessionId";
  static String createdat = "createdAt";
  static String clusterid = "clusterId";
  static String response = "response";
  static String message = "message";
  static String choices = "choices";
  static String timestamp = "timestamp";
  static String userId = "userId";
  static String lastActivityAt = "lastActivityAt";
  static String items = "items";
  static String isActive = "isActive";
  static String messageId = "messageId";
  static String content = "content";
  static String isFromUser = "isFromUser";
  static String sentAt = "sentAt";
  //teacher apikeys
  static String teacherFullName = "fullName";
  static String teacherPic = "picUrl";
  static String teacherStudents = "students";
  static String teachertotalClasses = "totalClasses";
  static String teacherClasses = "classes";
  static String createClassMessage = "message";
  static String classId = "classId";
  static String className = "className";
  static String classSubject = "subject";
  static String classGrade = "grade";
  static String addStudentMessage = "message";
  static String enrollment = "enrollment";
  static String studentId = "studentId";
  static String studentUserName = "username";
  static String studentName = "studentName";
  static String classIdRequest = "ClassId";
  // Teacher API keys
  static String classCode = "classCode";
  static String lessonCount = "lessons";
  static String studentsCount = "studentsCount";
  static String learningLevel = "learningLevel";
  static String completedLessons = "completedLessons";
  static String totalLessons = "totalLessons";
  static String weeklyAttendance = "weeklyAttendance";
  static String subjectProgress = "subjectProgress";
  static String recentActivity = "recentActivity";
  static String progressPercentage = "progressPercentage";
  static String subject = "subject";
  static String success = "success";
  static String data = "data";
  // Student API keys
  static const String completionStatus = 'completionStatus';
  static const String lessonId = 'lessonId';
  static const String lessonName = 'lessonName';
  static const String completed = 'Completed';
}
