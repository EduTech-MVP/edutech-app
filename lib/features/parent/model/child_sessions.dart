class ChildSessions {
  final int childId;
  final String childName;
  final String profileImageUrl;
  final List<dynamic> sessions;

  ChildSessions({
    required this.childId,
    required this.childName,
    required this.profileImageUrl,
    required this.sessions,
  });

  factory ChildSessions.fromJson(Map<String, dynamic> json) {
    return ChildSessions(
      childId: json['childId'],
      childName: json['childName'],
      profileImageUrl: json['profileImageUrl'],
      sessions: List<dynamic>.from(json['sessions']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'childId': childId,
      'childName': childName,
      'profileImageUrl': profileImageUrl,
      'sessions': sessions,
    };
  }
}
