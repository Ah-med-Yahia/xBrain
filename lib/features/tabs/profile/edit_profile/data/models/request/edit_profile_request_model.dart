import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
part 'edit_profile_request_model.g.dart';

@JsonSerializable()
class EditProfileRequestModel {
  @JsonKey(name: 'first_name')
  final String? firstName;

  @JsonKey(name: 'last_name')
  final String? lastName;

  @JsonKey(name: 'phone_number')
  final String? phoneNumber;

  final String? bio;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final MultipartFile? image;

  EditProfileRequestModel({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.bio,
    this.image,
  });

  factory EditProfileRequestModel.fromJson(Map<String, dynamic> json) =>
      _$EditProfileRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$EditProfileRequestModelToJson(this);
}
