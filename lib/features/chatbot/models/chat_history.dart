import 'dart:convert'; // Add this import

class ChatHistoryItem {
  final String content;
  final bool isFromUser;
  final List<String>? choices; // Changed from List<dynamic>? to List<String>?
  final String? imageUrl;

  ChatHistoryItem({
    required this.content,
    required this.isFromUser,
    this.choices,
    this.imageUrl,
  });

  factory ChatHistoryItem.fromJson(Map<String, dynamic> json) {
    // Helper function to parse choices
    List<String>? parseChoices(dynamic choicesData) {
      if (choicesData == null) return null;

      // If it's already a list, cast it
      if (choicesData is List) {
        return choicesData.cast<String>();
      }

      // If it's a string (JSON-encoded), decode it first
      if (choicesData is String) {
        try {
          final decoded = jsonDecode(choicesData);
          if (decoded is List) {
            return decoded.cast<String>();
          }
        } catch (e) {
          print('Error parsing choices: $e');
          return null;
        }
      }

      return null;
    }

    return ChatHistoryItem(
      content: json['content'] as String? ?? json['message'] as String? ?? '',
      isFromUser: json['isFromUser'] as bool? ?? false,
      choices: parseChoices(json['choices']), // Use the helper function
      imageUrl: json['imageUrl'] as String?,
    );
  }
}

class ChatHistory {
  final List<ChatHistoryItem> items;

  ChatHistory({required this.items});

  factory ChatHistory.fromJson(Map<String, dynamic> json) {
    final List<dynamic> itemsJson = json['items'] as List<dynamic>? ?? [];

    return ChatHistory(
      items: itemsJson
          .map((item) => ChatHistoryItem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
