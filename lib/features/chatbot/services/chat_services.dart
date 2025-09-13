import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatService {
  final String token;

  ChatService(this.token);

  Future<String> createSession(String lesson) async {
    final url = 'http://edutech.runasp.net/api/ChatBot/create-session';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'lesson': lesson}),
    );
    print(
      'Create session - Status: ${response.statusCode}, Body: ${response.body}',
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['sessionId'] as String;
    } else {
      throw Exception(
        'Failed to create session: ${response.statusCode} - ${response.body}',
      );
    }
  }

  Future<Map<String, dynamic>> sendMessage(
    String sessionId,
    String text,
  ) async {
    final url = 'http://edutech.runasp.net/api/ChatBot/send-message';
    final body = jsonEncode({
      'sessionId': sessionId,
      'message': text,
      'mode': 'TutorAsks',
    });
    print('Sending: $body');
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: body,
    );
    print('Status: ${response.statusCode}, Body: ${response.body}');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('API failed: ${response.statusCode}, ${response.body}');
    }
  }
}
