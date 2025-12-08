import 'package:edutech_app/core/api/endpoints.dart';

class ChatSession {
  final String sessionId;
  final int userId;
  final int? clusterId;
  final String createdAt;
  final String lastActivityAt;
  final bool isActive;

  ChatSession({
    required this.sessionId,
    required this.userId,
    this.clusterId,
    required this.createdAt,
    required this.lastActivityAt,
    required this.isActive,
  });

  factory ChatSession.fromJson(Map<String, dynamic> json) {
    return ChatSession(
      sessionId: json[ApiKey.sessionid] as String,
      userId: json[ApiKey.userId] as int,
      clusterId: json[ApiKey.clusterid] as int?,
      createdAt: json[ApiKey.createdat] as String,
      lastActivityAt: json[ApiKey.lastActivityAt] as String,
      isActive: json[ApiKey.isActive] as bool,
    );
  }
}
