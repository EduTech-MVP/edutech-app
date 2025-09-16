import 'package:edutech_app/core/api/endpoints.dart';

class ChatHistory {
  final String sessionId;
  final List<ChatMessageItem> items;

  ChatHistory({required this.sessionId, required this.items});

  factory ChatHistory.fromJson(Map<String, dynamic> json) {
    return ChatHistory(
      sessionId: json[ApiKey.sessionid],
      items: (json[ApiKey.items] as List)
          .map((item) => ChatMessageItem.fromJson(item))
          .toList(),
    );
  }
}

class ChatMessageItem {
  final int messageId;
  final String content;
  final bool isFromUser;
  final List<String>? choices;
  final String sentAt;

  ChatMessageItem({
    required this.messageId,
    required this.content,
    required this.isFromUser,
    this.choices,
    required this.sentAt,
  });

  factory ChatMessageItem.fromJson(Map<String, dynamic> json) {
    return ChatMessageItem(
      messageId: json[ApiKey.messageId],
      content: json[ApiKey.content],
      isFromUser: json[ApiKey.isFromUser],
      choices: json[ApiKey.choices] != null
          ? List<String>.from(json['choices'])
          : null,
      sentAt: json[ApiKey.sentAt],
    );
  }
}
