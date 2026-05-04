import 'dart:io';
import 'package:dio/dio.dart';
import 'package:explaino/core/helpers/to_multi_part_helper.dart';

class EditProfileRequestModel {
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? bio;
  final File? image;

  EditProfileRequestModel({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.bio,
    this.image,
  });

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (bio != null) 'bio': bio,
      if (image != null) 'profile_image': await toMultipartFile(image!),
    });
  }
}
