// session_response.dart
class SessionResponse {
  final String sessionId;
  final String? createdAt;
  final int? clusterId;

  SessionResponse({required this.sessionId, this.createdAt, this.clusterId});

  factory SessionResponse.fromJson(Map<String, dynamic> json) {
    return SessionResponse(
      sessionId: (json['sessionid'] ?? json['sessionId']) as String,
      createdAt: json['createdAt'] as String?,
      clusterId: json['clusterId'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sessionId': sessionId,
      'createdAt': createdAt,
      'clusterId': clusterId,
    };
  }
}
