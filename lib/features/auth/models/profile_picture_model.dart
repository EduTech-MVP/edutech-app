import 'package:edutech_app/core/api/endpoints.dart';

///delete profile image
class DeleteProfileImage {
  final String message;
  final String imageUrl;

  DeleteProfileImage({required this.message, required this.imageUrl});

  factory DeleteProfileImage.fromJson(Map<String, dynamic> json) {
    return DeleteProfileImage(
      message: json[ApiKey.message],
      imageUrl: json[ApiKey.imageurl],
    );
  }

  Map<String, dynamic> toJson() {
    return {ApiKey.message: message, ApiKey.imageurl: imageUrl};
  }
}
