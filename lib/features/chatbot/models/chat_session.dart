import 'package:edutech_app/core/api/endpoints.dart';

class ChatSession {
  final String sessionId;
  final int userId;
  final int clusterId;
  final String createdAt;
  final String lastActivityAt;
  final bool isActive;

  ChatSession({
    required this.sessionId,
    required this.userId,
    required this.clusterId,
    required this.createdAt,
    required this.lastActivityAt,
    required this.isActive,
  });

  factory ChatSession.fromJson(Map<String, dynamic> json) {
    return ChatSession(
      sessionId: json[ApiKey.sessionid],
      userId: json[ApiKey.userId],
      clusterId: json[ApiKey.clusterid],
      createdAt: json[ApiKey.createdat],
      lastActivityAt: json[ApiKey.lastActivityAt],
      isActive: json[ApiKey.isActive],
    );
  }
}
