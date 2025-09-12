import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String _baseUrl = 'http://edutech.runasp.net/api/Auth';

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final url = Uri.parse('$_baseUrl/login');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      if (response.body.isEmpty) {
        throw Exception('Server returned an empty response.');
      }

      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        try {
          final errorData = json.decode(response.body);
          final errorMessage =
              errorData['message'] ?? 'Login failed. Please check credentials.';
          throw Exception(errorMessage);
        } catch (_) {
          throw Exception('  ${response.body}');
        }
      }
    } catch (e) {
      throw Exception('An error occurred: ${e.toString()}');
    }
  }
}
