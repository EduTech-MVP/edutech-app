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
    // Handle profile image path - convert relative to absolute URL
    String? profileImage = json['profileImageUrl'];
    if (profileImage != null && profileImage.isNotEmpty) {
      // Convert relative path to absolute URL
      if (profileImage.startsWith('/') && !profileImage.startsWith('//')) {
        profileImage = 'http://edutech.runasp.net$profileImage';
      }
      // If it's already a full URL, keep it as is
    } else {
      profileImage = null; // Set to null if empty
    }

    return ChildSessions(
      childId: json['childId'] ?? 0,
      childName: json['childName'] ?? '',
      profileImageUrl: profileImage ?? '',
      sessions: List<dynamic>.from(json['sessions'] ?? []),
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
