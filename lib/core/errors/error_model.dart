class ErrorModel {
  final String? errorMessage;

  ErrorModel({this.errorMessage});

  factory ErrorModel.fromJson(dynamic json) {
    if (json is String) {
      return ErrorModel(errorMessage: json);
    } else if (json is Map<String, dynamic>) {
      return ErrorModel(errorMessage: json['message'] ?? 'Unknown error');
    } else {
      return ErrorModel(errorMessage: 'Unknown error');
    }
  }
}
