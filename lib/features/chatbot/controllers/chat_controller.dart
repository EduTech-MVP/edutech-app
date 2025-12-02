import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:edutech_app/core/api/dio_consumer.dart';
import 'package:edutech_app/core/api/endpoints.dart';
import 'package:edutech_app/core/errors/error_model.dart';
import 'package:edutech_app/core/errors/exceptions.dart';
import 'package:edutech_app/features/chatbot/models/messege.dart';
import 'package:edutech_app/features/chatbot/models/send_messege_model.dart';
import 'package:edutech_app/features/chatbot/models/session_response.dart';
import 'package:edutech_app/features/chatbot/models/chat_history.dart';
import 'package:edutech_app/features/chatbot/models/sessions_with_title.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

/// Optimized ChatController with better state management
class ChatController with ChangeNotifier {
  // ========== PRIVATE STATE ==========
  final DioConsumer _api;
  final ImagePicker _imagePicker = ImagePicker();

  // Messages and sessions
  final List<Message> _messages = [];
  final List<SessionWithTitle> _sessions = [];

  // Current session
  String? _sessionId;
  String? _error;

  // Loading states
  bool _isLoading = false;
  bool _isLoadingSessions = false;
  bool _isLoadingHistory = false;
  bool _isBotTyping = false;
  bool _isDeletingSession = false;

  // UI states
  bool _showHistory = false;
  bool _showScrollButton = false;
  bool _showImagePreview = false;

  // Image handling
  XFile? _pendingImage;

  // Pagination
  int _currentPage = 1;
  final int _pageSize = 20;
  bool _hasMoreSessions = true;

  // Search state
  String _searchQuery = '';

  // ========== PUBLIC GETTERS ==========
  String? get sessionId => _sessionId;
  String? get error => _error;
  List<Message> get messages => List.unmodifiable(_messages);
  List<SessionWithTitle> get sessions => List.unmodifiable(_sessions);
  String get searchQuery => _searchQuery;

  // Loading states
  bool get isLoading => _isLoading;
  bool get isLoadingSessions => _isLoadingSessions;
  bool get isLoadingHistory => _isLoadingHistory;
  bool get isBotTyping => _isBotTyping;
  bool get hasMoreSessions => _hasMoreSessions;
  bool get isDeletingSession => _isDeletingSession;

  // UI states
  bool get showHistory => _showHistory;
  bool get showScrollButton => _showScrollButton;
  bool get showImagePreview => _showImagePreview;

  // Image preview
  XFile? get pendingImage => _pendingImage;

  /// Get filtered sessions based on search query
  List<SessionWithTitle> get filteredSessions {
    if (_searchQuery.isEmpty) {
      return List.unmodifiable(_sessions);
    }

    final query = _searchQuery.toLowerCase();
    return _sessions.where((session) {
      final title = (session.title ?? 'New Chat').toLowerCase();
      return title.contains(query);
    }).toList();
  }

  // ========== CONSTRUCTOR ==========
  ChatController({required DioConsumer api}) : _api = api {
    _initializeChat();
  }

  // ========== IMAGE HANDLING ==========

  /// Pick image from gallery and show preview
  Future<void> pickImageForPreview() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        _pendingImage = image;
        _showImagePreview = true;
        notifyListeners();
      }
    } catch (e) {
      _handleError('Failed to pick image', e);
    }
  }

  /// Take photo from camera and show preview
  Future<void> takePhotoForPreview() async {
    try {
      final XFile? photo = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (photo != null) {
        _pendingImage = photo;
        _showImagePreview = true;
        notifyListeners();
      }
    } catch (e) {
      _handleError('Failed to take photo', e);
    }
  }

  /// Cancel image preview
  void cancelImagePreview() {
    _pendingImage = null;
    _showImagePreview = false;
    notifyListeners();
  }

  /// Send image message with optional caption
  Future<void> sendImageMessage(String caption) async {
    if (_pendingImage == null) {
      _logDebug("No pending image to send");
      return;
    }

    // Check if we have a session, if not create one
    if (_sessionId == null) {
      _logDebug("No active session, creating one...");
      try {
        final sessionResponse = await _createSession();
        _sessionId = sessionResponse.sessionId;
        _logDebug("Created new session: $_sessionId");
      } catch (e) {
        _logDebug("Failed to create session: $e");
        _showErrorMessage('Failed to create chat session. Please try again.');
        return;
      }
    }

    final image = _pendingImage!;
    final displayText = caption.trim().isNotEmpty ? caption : '[Image]';

    // Clear preview state immediately
    _pendingImage = null;
    _showImagePreview = false;

    // Add user message optimistically
    _addMessage(Message(text: displayText, isBot: false, imageUrl: image.path));

    // Show typing indicator
    _setBotTyping(true);

    try {
      _logDebug("Sending image - Session: $_sessionId, Caption: $caption");

      final response = await _api.postFormData(
        Endpoints.sendMessage,
        data: {
          ApiKey.message: caption.trim().isNotEmpty
              ? caption
              : 'Image uploaded',
          ApiKey.sessionid: _sessionId!,
        },
        filePath: image.path,
        fileKey: 'image',
      );

      _logDebug("Image upload successful");

      final sendMessageModel = SendMessageModel.fromJson(response);

      // Add bot response
      _addMessage(
        Message(
          text: sendMessageModel.response.message,
          isBot: true,
          choices: sendMessageModel.response.choices?.cast<String>(),
        ),
      );

      // Refresh sessions to update title
      await fetchSessions(refresh: true);
    } catch (e) {
      _handleError('Error sending image', e);
      _addMessage(
        Message(text: 'Failed to send image. Please try again.', isBot: true),
      );
    } finally {
      _setBotTyping(false);
    }
  }

  // ========== SESSION MANAGEMENT ==========

  /// Create a new chat session
  Future<SessionResponse> _createSession() async {
    try {
      final response = await _api.post(
        Endpoints.createSession,
        data: {'clusterId': 1},
      );

      _logDebug("Session created successfully: $response");
      return SessionResponse.fromJson(response);
    } catch (e) {
      _logDebug('Error creating session: $e');
      throw ServerException(
        errorModel: ErrorModel(errorMessage: 'Failed to create session'),
      );
    }
  }

  /// Create new session and reset chat
  Future<void> createNewSession() async {
    _setLoading(true);

    try {
      if (!await _checkInternet()) {
        _showErrorMessage('No internet connection');
        return;
      }

      try {
        final sessionResponse = await _createSession();
        _sessionId = sessionResponse.sessionId;
        _messages.clear();
        _error = null;

        _logDebug("New session created: $_sessionId");
        await fetchSessions(refresh: true);
      } catch (e) {
        // If session creation fails (404), clear messages and set null session
        // Session will be auto-created when user sends first message
        _logDebug("Session creation failed, will create on first message");
        _sessionId = null;
        _messages.clear();
        _error = null;
      }
    } catch (e) {
      _handleError('Error creating session', e);
    } finally {
      _setLoading(false);
    }
  }

  // ========== HISTORY MANAGEMENT ==========

  /// Fetch chat sessions with titles and pagination
  Future<void> fetchSessions({bool refresh = false}) async {
    if (_isLoadingSessions) return;

    if (refresh) {
      _currentPage = 1;
      _sessions.clear();
      _hasMoreSessions = true;
    }

    if (!_hasMoreSessions) return;

    _setLoadingSessions(true);

    try {
      _logDebug("Fetching sessions - Page: $_currentPage");

      final response = await _api.get(Endpoints.getSessions);

      if (response == null) {
        _hasMoreSessions = false;
        return;
      }

      final List<dynamic> sessionsJson = response as List<dynamic>;
      final List<SessionWithTitle> fetchedSessions = sessionsJson
          .map((json) => SessionWithTitle.fromJson(json))
          .toList();

      _logDebug("Fetched ${fetchedSessions.length} sessions with titles");

      // Apply pagination
      final startIndex = (_currentPage - 1) * _pageSize;
      final endIndex = startIndex + _pageSize;

      if (startIndex < fetchedSessions.length) {
        final paginatedSessions = fetchedSessions.sublist(
          startIndex,
          endIndex > fetchedSessions.length ? fetchedSessions.length : endIndex,
        );

        _sessions.addAll(paginatedSessions);
        _hasMoreSessions = endIndex < fetchedSessions.length;
        _currentPage++;

        _logDebug(
          "Loaded ${paginatedSessions.length} sessions. Total: ${_sessions.length}",
        );
      } else {
        _hasMoreSessions = false;
      }
    } catch (e) {
      _handleError('Failed to load sessions', e);
    } finally {
      _setLoadingSessions(false);
    }
  }

  /// Load chat history for a specific session
  Future<void> loadSessionHistory(String sessionId) async {
    if (_isLoadingHistory) return;

    // Close history drawer when loading a session
    if (_showHistory) {
      _showHistory = false;
    }

    _setLoadingHistory(true);
    _sessionId = sessionId;
    _messages.clear();
    _showScrollButton = false;

    try {
      final endpoint = '${Endpoints.sessionsHistory}/$sessionId';
      _logDebug("Loading history for session: $sessionId");

      final response = await _api.get(endpoint);

      if (response == null) {
        _showErrorMessage('This session has no messages yet');
        return;
      }

      final chatHistory = ChatHistory.fromJson(response);
      _logDebug("Loaded ${chatHistory.items.length} messages");

      // Build messages with proper image URLs
      for (var item in chatHistory.items) {
        String? imageUrl = item.imageUrl;

        if (imageUrl != null &&
            imageUrl.isNotEmpty &&
            imageUrl.startsWith('/uploads/')) {
          imageUrl = '${Endpoints.staticBaseUrl}$imageUrl';
          _logDebug("Converted image URL: $imageUrl");
        }

        // Handle choices - convert to List<String>? safely
        List<String>? choices;
        if (item.choices != null) {
          if (item.choices is List) {
            choices = (item.choices as List).cast<String>();
          } else if (item.choices is String) {
            _logDebug("Choices is a String, ignoring: ${item.choices}");
          }
        }

        _messages.add(
          Message(
            text: item.content,
            isBot: !item.isFromUser,
            choices: choices,
            imageUrl: imageUrl,
          ),
        );
      }

      if (_messages.isEmpty) {
        _showErrorMessage('This session has no messages');
      }
    } catch (e) {
      _handleError('Failed to load chat history', e);
    } finally {
      _setLoadingHistory(false);
    }
  }

  /// Delete a session
  Future<bool> deleteSession(String sessionId) async {
    if (_isDeletingSession) return false;

    _isDeletingSession = true;
    notifyListeners();

    try {
      _logDebug("Deleting session: $sessionId");

      final endpoint = '${Endpoints.deletesession}/$sessionId';
      await _api.delete(endpoint);

      _logDebug("Session deleted successfully");

      // Remove from local list
      _sessions.removeWhere((s) => s.sessionId == sessionId);

      // If deleted session is current, create new one
      if (_sessionId == sessionId) {
        await createNewSession();
      }

      notifyListeners();
      return true;
    } catch (e) {
      _handleError('Failed to delete session', e);
      return false;
    } finally {
      _isDeletingSession = false;
      notifyListeners();
    }
  }

  // ========== MESSAGE MANAGEMENT ==========

  /// Send text message to API
  Future<SendMessageModel> _sendMessage(String sessionId, String text) async {
    try {
      final formData = {ApiKey.sessionid: sessionId, ApiKey.message: text};

      _logDebug("Sending message - Session: $sessionId");

      final response = await _api.postFormData(
        Endpoints.sendMessage,
        data: formData,
      );

      return SendMessageModel.fromJson(response);
    } catch (e) {
      _logDebug('Error sending message: $e');
      throw ServerException(
        errorModel: ErrorModel(errorMessage: 'Failed to send message'),
      );
    }
  }

  /// Send a text message
  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) {
      _logDebug("Empty message, not sending");
      return;
    }

    // Check if we have a session, if not create one
    if (_sessionId == null) {
      _logDebug("No active session, creating one...");
      try {
        final sessionResponse = await _createSession();
        _sessionId = sessionResponse.sessionId;
        _logDebug("Created new session: $_sessionId");
      } catch (e) {
        _logDebug("Failed to create session: $e");
        _showErrorMessage('Failed to create chat session. Please try again.');
        return;
      }
    }

    // Add user message optimistically
    _addMessage(Message(text: text, isBot: false));

    _setBotTyping(true);

    try {
      final response = await _sendMessage(_sessionId!, text);

      // Add bot response
      _addMessage(
        Message(
          text: response.response.message,
          isBot: true,
          choices: response.response.choices?.cast<String>(),
        ),
      );

      // Refresh sessions to update title
      await fetchSessions(refresh: true);
    } catch (e) {
      _handleError('Error sending message', e);
      _addMessage(
        Message(text: 'Failed to send message. Please try again.', isBot: true),
      );
    } finally {
      _setBotTyping(false);
    }
  }

  /// Initialize chat by using first available session or creating one
  Future<void> _initializeChat() async {
    _setLoading(true);

    try {
      if (!await _checkInternet()) {
        _showErrorMessage('No internet connection');
        return;
      }

      // Try to fetch existing sessions first
      try {
        await fetchSessions(refresh: true);

        // If we have sessions, use the first one
        if (_sessions.isNotEmpty) {
          _sessionId = _sessions.first.sessionId;
          _logDebug("Using existing session: $_sessionId");
          return;
        }
      } catch (e) {
        _logDebug("Failed to fetch sessions: $e");
      }

      // Only try to create session if no sessions exist
      try {
        final sessionResponse = await _createSession();
        _sessionId = sessionResponse.sessionId;
        _logDebug("Created new session: $_sessionId");
      } catch (e) {
        _logDebug("Failed to create session: $e");
        _sessionId = null;
      }
    } catch (e) {
      _handleError('Error initializing chat', e);
      _sessionId = null;
    } finally {
      _setLoading(false);
    }
  }

  // ========== UI STATE MANAGEMENT ==========

  /// Toggle history drawer
  void toggleHistory() {
    _showHistory = !_showHistory;

    if (_showHistory && _sessions.isEmpty && !_isLoadingSessions) {
      fetchSessions(refresh: true);
    }

    notifyListeners();
  }

  /// Close history drawer and clear search
  void closeHistory() {
    if (_showHistory) {
      _showHistory = false;
      // Clear search when closing history
      if (_searchQuery.isNotEmpty) {
        _searchQuery = '';
      }
      notifyListeners();
    }
  }

  /// Update scroll button visibility
  void updateScrollButtonVisibility(bool show) {
    if (_showScrollButton != show) {
      _showScrollButton = show;
      notifyListeners();
    }
  }

  /// Clear error state
  void clearError() {
    if (_error != null) {
      _error = null;
      notifyListeners();
    }
  }

  /// Get session title with fallback
  String getSessionTitle(String sessionId) {
    final session = _sessions.firstWhere(
      (s) => s.sessionId == sessionId,
      orElse: () => SessionWithTitle(sessionId: sessionId, title: null),
    );
    return session.title ?? 'New Chat';
  }

  // ========== SEARCH METHODS ==========

  /// Update search query and filter sessions
  void updateSearchQuery(String query) {
    if (_searchQuery != query) {
      _searchQuery = query;
      notifyListeners();
    }
  }

  /// Clear search query
  void clearSearch() {
    if (_searchQuery.isNotEmpty) {
      _searchQuery = '';
      notifyListeners();
    }
  }

  // ========== PRIVATE HELPER METHODS ==========

  void _addMessage(Message message) {
    _messages.add(message);
    notifyListeners();
  }

  void _setLoading(bool value) {
    if (_isLoading != value) {
      _isLoading = value;
      notifyListeners();
    }
  }

  void _setLoadingSessions(bool value) {
    if (_isLoadingSessions != value) {
      _isLoadingSessions = value;
      notifyListeners();
    }
  }

  void _setLoadingHistory(bool value) {
    if (_isLoadingHistory != value) {
      _isLoadingHistory = value;
      notifyListeners();
    }
  }

  void _setBotTyping(bool value) {
    if (_isBotTyping != value) {
      _isBotTyping = value;
      notifyListeners();
    }
  }

  void _showErrorMessage(String message) {
    _error = message;
    _addMessage(Message(text: message, isBot: true));
  }

  void _handleError(String context, Object error) {
    _logDebug('$context: $error');

    final errorMessage = error is ServerException
        ? error.errorModel.errorMessage ?? 'An error occurred'
        : error.toString();

    _showErrorMessage(errorMessage);
  }

  Future<bool> _checkInternet() async {
    try {
      final result = await Connectivity().checkConnectivity();
      return result != ConnectivityResult.none;
    } catch (e) {
      _logDebug('Connectivity check error: $e');
      return false;
    }
  }

  void _logDebug(String message) {
    if (kDebugMode) {
      print('[ChatController] $message');
    }
  }

  @override
  void dispose() {
    _messages.clear();
    _sessions.clear();
    super.dispose();
  }
}
