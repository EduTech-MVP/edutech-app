import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:edutech_app/core/api/dio_consumer.dart';
import 'package:edutech_app/core/api/endpoints.dart';
import 'package:edutech_app/core/errors/error_model.dart';
import 'package:edutech_app/core/errors/exceptions.dart';
import 'package:edutech_app/features/chatbot/models/messege.dart';
import 'package:edutech_app/features/chatbot/models/send_messege_model.dart';
import 'package:edutech_app/features/chatbot/models/session_response.dart';
import 'package:flutter/foundation.dart';

class ChatController with ChangeNotifier {
  final List<Message> _messages = [];
  String? _sessionId;
  bool _isLoading = false;
  final DioConsumer _api;
  String? _error;

  String? get sessionId => _sessionId;
  String? get error => _error;
  List<Message> get messages => List.unmodifiable(_messages);
  bool get isLoading => _isLoading;

  ChatController({required DioConsumer api}) : _api = api {
    _initializeChat();
  }

  Future<SessionResponse> _createSession() async {
    try {
      final response = await _api.post(
        Endpoints.createSession,
        data: {'clusterId': 1},
      );

      if (kDebugMode) {
        print("Create session response: $response");
      }

      final sessionResponse = SessionResponse.fromJson(response);
      if (kDebugMode) {
        print("Created session ID: ${sessionResponse.sessionId}");
      }

      return sessionResponse;
    } catch (e) {
      if (kDebugMode) {
        print('Error in _createSession: $e');
      }
      throw ServerException(
        errorModel: ErrorModel(errorMessage: 'Unexpected error: $e'),
      );
    }
  }

  Future<SendMessageModel> _sendMessage(
    String sessionId,
    String? text, {
    String mode = 'TutorAsks',
  }) async {
    try {
      final body = {ApiKey.sessionid: sessionId, 'mode': mode};
      if (mode == 'StudentAsks' && text != null && text.isNotEmpty) {
        body[ApiKey.message] = text;
      }

      if (kDebugMode) {
        print("ApiKey.sessionid: ${ApiKey.sessionid}");
        print("Sending to send-message with sessionId: $sessionId");
        print("Sending body: $body");
      }

      final response = await _api.post(Endpoints.sendMessage, data: body);

      if (kDebugMode) {
        print("Send message response: $response");
      }

      return SendMessageModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error in _sendMessage: $e');
      }
      throw ServerException(
        errorModel: ErrorModel(errorMessage: 'Unexpected error: $e'),
      );
    }
  }

  Future<void> _initializeChat() async {
    _setLoading(true);
    try {
      if (!await _checkInternet()) {
        _showError('No internet connection');
        return;
      }
      final sessionResponse = await _createSession();
      _sessionId = sessionResponse.sessionId;
      await _fetchInitialMessage();
    } catch (e) {
      if (kDebugMode) {
        print('Init error: $e, Stack trace: ${StackTrace.current}');
      }
      _showError(
        e is ServerException
            ? e.errorModel.errorMessage!
            : 'Error initializing chat: $e',
      );
      _sessionId = null;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> createSession() async {
    _setLoading(true);
    try {
      final sessionResponse = await _createSession();
      _sessionId = sessionResponse.sessionId;
      _error = null;
    } on ServerException catch (e) {
      _error = e.errorModel.errorMessage;
    } catch (e) {
      _error = 'Unexpected error: $e';
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  Future<void> _fetchInitialMessage() async {
    if (_sessionId == null) {
      _addMessage(
        Message(
          text:
              "Hi I'm your AI tutor for Lesson 6: Slavery. How can I help you today?",
          isBot: true,
          choices: ['Choice 1', 'Choice 2', 'Choice 3', 'Choice 4'],
        ),
      );
      return;
    }
    try {
      // Refresh session to ensure validity
      await createSession();
      final response = await _sendMessage(_sessionId!, null, mode: 'TutorAsks');
      _addMessage(
        Message(
          text: response.response.message,
          isBot: true,
          choices: response.response.choices?.cast<String>(),
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print(
          'Fetch initial message error: $e, Stack trace: ${StackTrace.current}',
        );
      }
      _addMessage(
        Message(
          text:
              "Hi I'm your AI tutor for Lesson 6: Slavery. How can I help you today?",
          isBot: true,
          choices: ['Choice 1', 'Choice 2', 'Choice 3', 'Choice 4'],
        ),
      );
    }
  }

  Future<void> sendMessage(String text) async {
    if (text.isEmpty || _sessionId == null) return;
    _addMessage(Message(text: text, isBot: false));
    try {
      final response = await _sendMessage(
        _sessionId!,
        text,
        mode: 'StudentAsks',
      );
      _addMessage(
        Message(
          text: response.response.message,
          isBot: true,
          choices: response.response.choices?.cast<String>(),
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print('Send error: $e, Stack trace: ${StackTrace.current}');
      }
      _addMessage(Message(text: 'Error: $e', isBot: true));
    }
  }

  Future<bool> _checkInternet() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      return connectivityResult != ConnectivityResult.none;
    } catch (e) {
      if (kDebugMode) {
        print('Connectivity check error: $e');
      }
      return false;
    }
  }

  void _showError(String message) {
    _addMessage(Message(text: message, isBot: true));
    notifyListeners();
  }

  void _addMessage(Message message) {
    _messages.add(message);
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
