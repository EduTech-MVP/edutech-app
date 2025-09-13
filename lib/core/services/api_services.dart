import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:file_picker/file_picker.dart';

class ApiService {
  static const String baseUrl = 'http://edutech.runasp.net/api/Auth';

  Future<void> register({
    required String fullName,
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
    required DateTime dateOfBirth,
    required String userType,
    PlatformFile? profileImage,
    String? bio,
    String? subject,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/register'),
      );
      request.fields.addAll({
        'FullName': fullName,
        'Username': username,
        'Email': email,
        'Password': password,
        'ConfirmPassword': confirmPassword,
        'DateOfBirth': dateOfBirth.toIso8601String(),
        'UserType': userType,
        if (bio != null) 'Bio': bio,
        if (subject != null) 'Subject': subject,
      });

      if (profileImage != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'ProfileImage',
            profileImage.path!,
            contentType: MediaType('image', 'jpeg'),
          ),
        );
      }

      print('Register request: ${request.fields}');
      final response = await request.send();
      print('Register response: ${response.statusCode}');
      if (response.statusCode != 201) {
        final body = await response.stream.bytesToString();
        throw Exception('Registration failed: $body');
      }
    } catch (e) {
      throw Exception('Registration error: $e');
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      print('Login request: email=$email');
      print('Login response: ${response.statusCode}');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['token'] == null) {
          throw Exception('Login failed: No token returned');
        }
        return {
          'token': data['token'],
          'userType': data['userType'] ?? data['UserType'] ?? 'Parent',
        };
      } else {
        final body = jsonDecode(response.body);
        throw Exception(
          'Login failed: ${body['message'] ?? response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Login error: $e');
    }
  }
}
