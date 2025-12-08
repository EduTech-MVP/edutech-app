import 'package:edutech_app/core/api/endpoints.dart';

class ResponseData {
  final String message;
  final dynamic choices;

  ResponseData({required this.message, this.choices});

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    if (json[ApiKey.message] == null) {
      throw FormatException('Missing required field "message" in JSON: $json');
    }
    return ResponseData(
      message: json[ApiKey.message] as String,
      choices: json[ApiKey.choices],
    );
  }
}

class SendMessageModel {
  final String timeStamp;
  final ResponseData response;

  SendMessageModel({required this.timeStamp, required this.response});

  factory SendMessageModel.fromJson(Map<String, dynamic> json) {
    if (json[ApiKey.timestamp] == null || json[ApiKey.response] == null) {
      throw FormatException('Missing required fields in JSON: $json');
    }

    return SendMessageModel(
      timeStamp: json[ApiKey.timestamp] as String,
      response: ResponseData.fromJson(
        json[ApiKey.response] as Map<String, dynamic>,
      ),
    );
  }
}
