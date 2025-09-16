class ResponseData {
  final String message;
  final dynamic choices;

  ResponseData({required this.message, this.choices});

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    if (json['message'] == null) {
      throw FormatException('Missing required field "message" in JSON: $json');
    }
    return ResponseData(
      message: json['message'] as String,
      choices: json['choices'],
    );
  }
}

class SendMessageModel {
  final String sessionId;
  final String timeStamp; // Corrected spelling
  final ResponseData response;

  SendMessageModel({
    required this.sessionId,
    required this.timeStamp,
    required this.response,
  });

  factory SendMessageModel.fromJson(Map<String, dynamic> json) {
    if (json['sessionId'] == null ||
        json['timestamp'] == null ||
        json['response'] == null) {
      throw FormatException('Missing required fields in JSON: $json');
    }
    return SendMessageModel(
      sessionId: json['sessionId'] as String,
      timeStamp: json['timestamp'] as String,
      response: ResponseData.fromJson(json['response'] as Map<String, dynamic>),
    );
  }
}
