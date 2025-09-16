class Message {
  final String text;
  final bool isBot;
  final List<String>? choices;

  Message({required this.text, this.isBot = true, this.choices});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      text:
          json['text']
              as String, // Adjust key if API uses a different name (e.g., 'message')
      isBot: json['isBot'] as bool? ?? true, // Default to true if null
      choices: json['choices'] != null
          ? (json['choices'] as List<dynamic>).cast<String>()
          : null, // Handle optional choices
    );
  }
}
