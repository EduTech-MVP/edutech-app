import 'package:edutech_app/core/api/endpoints.dart';

///delete or upload profile image
class ProfilePictureModel {
  final String message;
  final String imageUrl;

  ProfilePictureModel({required this.message, required this.imageUrl});

  factory ProfilePictureModel.fromJson(Map<String, dynamic> json) {
    return ProfilePictureModel(
      message: json[ApiKey.message],
      imageUrl: json[ApiKey.imageurl],
    );
  }

  Map<String, dynamic> toJson() {
    return {ApiKey.message: message, ApiKey.imageurl: imageUrl};
  }
}
