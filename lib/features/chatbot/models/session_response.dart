import 'package:edutech_app/core/api/endpoints.dart';

class SessionResponse {
  final String sessionId;
  final String createdAt;
  final int clusterId;

  SessionResponse({
    required this.sessionId,
    required this.clusterId,
    required this.createdAt,
  });

  factory SessionResponse.fromJson(Map<String, dynamic> json) {
    if (json[ApiKey.sessionid] == null ||
        json[ApiKey.createdat] == null ||
        json[ApiKey.clusterid] == null) {
      throw FormatException('Missing required fields in JSON: $json');
    }
    return SessionResponse(
      sessionId: json[ApiKey.sessionid] as String,
      createdAt: json[ApiKey.createdat] as String,
      clusterId: json[ApiKey.clusterid] as int,
    );
  }
}
