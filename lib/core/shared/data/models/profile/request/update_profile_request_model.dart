import 'package:dio/dio.dart';

class UpdateProfileRequestModel {
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? bio;
  final MultipartFile? image;

  UpdateProfileRequestModel({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.bio,
    this.image,
  });
}
