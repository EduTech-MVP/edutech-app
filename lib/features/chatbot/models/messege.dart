import 'dart:convert'; // Add this import at the top

class Message {
  final String text;
  final bool isBot;
  final List<String>? choices;
  final String? imageUrl; // Local path for user images or URL for bot images

  Message({required this.text, this.isBot = true, this.choices, this.imageUrl});

  factory Message.fromJson(Map<String, dynamic> json) {
    // Handle choices that might be a JSON string or a List
    List<String>? parseChoices(dynamic choicesData) {
      if (choicesData == null) return null;

      // If it's already a list, cast it
      if (choicesData is List) {
        return choicesData.cast<String>();
      }

      // If it's a string, decode it first
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

    return Message(
      text: json['text'] as String,
      isBot: json['isBot'] as bool? ?? true,
      choices: parseChoices(json['choices']),
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'isBot': isBot,
      'choices': choices,
      'imageUrl': imageUrl,
    };
  }
}
