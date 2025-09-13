import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:edutech_app/features/chatbot/models/messege.dart';
import 'package:edutech_app/features/chatbot/services/chat_services.dart';
import 'package:flutter/material.dart';

class ChatController with ChangeNotifier {
  final List<Message> _messages = [];
  final ChatService _chatService;
  String? _sessionId;
  bool _isLoading = false;

  List<Message> get messages => List.unmodifiable(_messages);
  bool get isLoading => _isLoading;

  ChatController(String token) : _chatService = ChatService(token) {
    _initializeChat();
  }

  Future<void> _initializeChat() async {
    _setLoading(true);
    try {
      // if (!await _checkInternet()) {
      //   _showError('No internet connection');
      //   return;
      // }
      _sessionId = await _chatService.createSession('Lesson 6');
      await _fetchInitialMessage();
    } catch (e) {
      print('Init error: $e, Stack trace: ${StackTrace.current}');
      _showError('Error initializing chat: $e');
      _sessionId = 'fallback-session-id-123'; // fallback
      await _fetchInitialMessage();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _fetchInitialMessage() async {
    try {
      final response = await _chatService.sendMessage(_sessionId!, 'start');
      _addMessage(
        Message(
          text: response['response']['message'],
          isBot: true,
          choices: response['response']['choices']?.cast<String>(),
        ),
      );
    } catch (e) {
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

  void sendMessage(String text) async {
    if (text.isNotEmpty && _sessionId != null) {
      _addMessage(Message(text: text, isBot: false));
      try {
        final response = await _chatService.sendMessage(_sessionId!, text);
        _addMessage(
          Message(
            text: response['response']['message'],
            isBot: true,
            choices: response['response']['choices']?.cast<String>(),
          ),
        );
      } catch (e) {
        print('Send error: $e, Stack trace: ${StackTrace.current}');
        _addMessage(Message(text: 'Error: $e', isBot: true));
      }
    }
  }

  Future<bool> _checkInternet() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      return connectivityResult != ConnectivityResult.none;
    } catch (e) {
      print('Connectivity check error: $e');
      return false;
    }
  }

  void _showError(String message) {
    _addMessage(Message(text: message, isBot: true));
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
