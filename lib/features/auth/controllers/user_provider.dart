import 'package:dio/dio.dart';
import 'package:edutech_app/core/api/dio_consumer.dart';
import 'package:edutech_app/core/api/endpoints.dart';
import 'package:edutech_app/core/cache/cache_helper.dart';
import 'package:edutech_app/core/errors/exceptions.dart';
import 'package:edutech_app/features/auth/models/signin_model.dart';
import 'package:edutech_app/features/auth/models/signup_model.dart';
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
  SigninModel? _usersigned;
  Student? _student;
  final List<Student> _children = [];
  List<Student> get children => _children;

  Student? get student => _student;
  bool get loading => _loading;
  SigninModel? get usersigned => _usersigned;
  UserModel? get profile => _profile;

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

      _usersigned = SigninModel.fromJson(response);

      // Save token & userId
      CacheHelper().saveData(key: ApiKey.token, value: _usersigned!.token);
      CacheHelper().saveData(
        key: ApiKey.userType,
        value: _usersigned!.user.userType,
      );

      return true;
    } on ServerException catch (e) {
      error = e.errorModel.errorMessage;
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

      final response = await api.post(
        Endpoints.register,
        data: formData,
        isFormData: true,
      );
      final signupModel = SignupModel.fromJson(response);
      // Save token
      if (signupModel.token.isNotEmpty) {
        CacheHelper().saveData(key: ApiKey.token, value: signupModel.token);
        CacheHelper().saveData(
          key: ApiKey.userType,
          value: signupModel.user.userType,
        );

        return true;
      } else {
        error = "Signup failed: missing token";
        return false;
      }
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
    notifyListeners();
    try {
      final response = await api.get(Endpoints.profile);
      print('respoonseee $response');

      _profile = UserModel.fromJson(response);

      print('profilee: ${_profile!.firstName}');
    } on ServerException catch (e) {
      error = e.errorModel.errorMessage;
      print("Server Exception: $error");
    } on TypeError catch (e) {
      // This will catch the error if it's a type mismatch
      error = "Type error during parsing: $e";
      print("Type Error: $error");
    } on NoSuchMethodError catch (e) {
      // This will catch the error if a method is called on a null value
      error = "Method not found during parsing: $e";
      print("No Such Method Error: $error");
    } catch (e) {
      // Fallback for other unexpected errors
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
      // The response variable already contains the JSON data (Map<String, dynamic>)
      final response = await api.post(Endpoints.addStudent, data: request);

      _student = Student.fromJson(response['student']);

      print('ssssssssssssssssss${_student}');
      _children.add(_student!);
      print('ccccccccc${_children}');

      notifyListeners();
      return;
    } on ServerException catch (e) {
      error = e.errorModel.errorMessage;
      print("Server Exception: $error");
      return;
    } catch (e) {
      // This will now catch any other unexpected errors
      print("Parsing or other Unexpected error: $e");
      error = "Unexpected error: $e";
      return;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _usersigned = null;
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
    await CacheHelper.removeData(key: ApiKey.token);

    // Clear cached data
    await CacheHelper.removeData(key: ApiKey.token);
    await CacheHelper.removeData(key: ApiKey.id);
    await CacheHelper.removeData(key: ApiKey.user);

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
