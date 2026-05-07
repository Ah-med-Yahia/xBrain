import 'dart:io';

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
}
