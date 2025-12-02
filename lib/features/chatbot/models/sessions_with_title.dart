class SessionWithTitle {
  final String sessionId;
  final String? title;

  SessionWithTitle({required this.sessionId, this.title});

  factory SessionWithTitle.fromJson(Map<String, dynamic> json) {
    return SessionWithTitle(
      sessionId: json['sessionId'] as String,
      title: json['title'] as String?,
    );
  }
}
