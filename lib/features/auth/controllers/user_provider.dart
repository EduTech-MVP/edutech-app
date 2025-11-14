import 'package:dio/dio.dart';
import 'package:edutech_app/core/api/dio_consumer.dart';
import 'package:edutech_app/core/api/endpoints.dart';
import 'package:edutech_app/core/cache/cache_helper.dart';
import 'package:edutech_app/core/errors/exceptions.dart';
import 'package:edutech_app/features/auth/models/token_response_model.dart';
import 'package:edutech_app/features/auth/models/student_model.dart';
import 'package:edutech_app/features/auth/models/user_model.dart';
import 'package:edutech_app/features/parent/model/add_student_request.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  final DioConsumer api;
  UserProvider({required this.api});

  // Controllers
  final signInEmail = TextEditingController();
  final signInPassword = TextEditingController();

  final signupFullName = TextEditingController();
  final signupEmail = TextEditingController();
  final signupUserName = TextEditingController();
  final bio = TextEditingController();
  final dateOfBirth = TextEditingController();
  final signupPassword = TextEditingController();
  final signupConfirmPassword = TextEditingController();

  // State
  bool _loading = false;
  UserModel? _profile;
  String? error;
  String? _token;
  Student? _student;
  final List<Student> _children = [];

  List<Student> get children => _children;
  Student? get student => _student;
  bool get loading => _loading;
  String? get token => _token;
  UserModel? get profile => _profile;
  bool get isAuthenticated => _token != null;

  Future<bool> signin() async {
    _loading = true;
    error = null;
    notifyListeners();

    try {
      final response = await api.post(
        Endpoints.signin,
        data: {
          ApiKey.email: signInEmail.text,
          ApiKey.password: signInPassword.text,
        },
      );

      final tokenResponse = TokenResponseModel.fromJson(response);
      _token = tokenResponse.token;

      // Save token
      await CacheHelper().saveData(key: ApiKey.token, value: _token!);

      // Fetch profile after successful signin to get user details
      await getProfile();

      return true;
    } on ServerException catch (e) {
      error = e.errorModel.errorMessage;
      return false;
    } catch (e) {
      error = "Unexpected error: $e";
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> signUp({String? profilePicturePath, String? userType}) async {
    _loading = true;
    error = null;
    notifyListeners();

    try {
      // Prepare form data
      final formData = FormData.fromMap({
        ApiKey.fullName: signupFullName.text,
        ApiKey.signupEmail: signupEmail.text,
        ApiKey.userName: signupUserName.text,
        ApiKey.signupPassword: signupPassword.text,
        ApiKey.confirmPassword: signupConfirmPassword.text,
        ApiKey.dateofBirth: dateOfBirth.text,
        ApiKey.bio: bio.text,
        ApiKey.signupUserType: userType,
        if (profilePicturePath != null)
          ApiKey.profileImage: await MultipartFile.fromFile(profilePicturePath),
      });

      await api.post(Endpoints.register, data: formData, isFormData: true);
      // User must verify email before signing in
      return true;
    } on ServerException catch (e) {
      error = e.errorModel.errorMessage;
      return false;
    } catch (e) {
      error = "Unexpected error: $e";
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> getProfile() async {
    _loading = true;
    error = null;
    notifyListeners();

    try {
      final response = await api.get(Endpoints.profile);
      print('Response: $response');

      _profile = UserModel.fromJson(response);

      // Save user type from profile
      if (_profile?.userType != null) {
        await CacheHelper().saveData(
          key: ApiKey.userType,
          value: _profile!.userType,
        );
      }

      print('Profile: ${_profile!.firstName} ${_profile!.lastName}');
    } on ServerException catch (e) {
      error = e.errorModel.errorMessage;
      print("Server Exception: $error");
    } catch (e) {
      error = "Unexpected error: $e";
      print("Unexpected Error: $error");
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> addStudent(AddStudentRequest request) async {
    _loading = true;
    error = null;
    notifyListeners();

    try {
      final response = await api.post(Endpoints.addStudent, data: request);

      _student = Student.fromJson(response['student']);
      _children.add(_student!);

      print('Student added: $_student');
      print('Children count: ${_children.length}');
    } on ServerException catch (e) {
      error = e.errorModel.errorMessage;
      print("Server Exception: $error");
    } catch (e) {
      error = "Unexpected error: $e";
      print("Unexpected Error: $e");
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _token = null;
    _profile = null;
    _student = null;
    _children.clear();

    // Clear controllers
    signInEmail.clear();
    signInPassword.clear();
    signupFullName.clear();
    signupEmail.clear();
    signupUserName.clear();
    bio.clear();
    dateOfBirth.clear();
    signupPassword.clear();
    signupConfirmPassword.clear();

    // Clear cached data
    await CacheHelper.removeData(key: ApiKey.token);
    await CacheHelper.removeData(key: ApiKey.id);
    await CacheHelper.removeData(key: ApiKey.user);
    await CacheHelper.removeData(key: ApiKey.userType);

    notifyListeners();
  }

  @override
  void dispose() {
    signInEmail.dispose();
    signInPassword.dispose();
    signupFullName.dispose();
    signupEmail.dispose();
    signupUserName.dispose();
    bio.dispose();
    dateOfBirth.dispose();
    signupPassword.dispose();
    signupConfirmPassword.dispose();
    super.dispose();
  }
}
