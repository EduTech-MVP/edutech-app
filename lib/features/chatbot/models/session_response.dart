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
    if (json['sessionId'] == null ||
        json['createdAt'] == null ||
        json['clusterId'] == null) {
      throw FormatException('Missing required fields in JSON: $json');
    }
    return SessionResponse(
      sessionId: json['sessionId'] as String,
      createdAt: json['createdAt'] as String,
      clusterId: json['clusterId'] as int,
    );
  }
}
