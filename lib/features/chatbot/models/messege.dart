class Message {
  final String text;
  final bool isBot;
  final List<String>? choices;

  Message({required this.text, this.isBot = true, this.choices});
}
