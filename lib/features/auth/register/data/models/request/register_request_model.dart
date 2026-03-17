import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'register_request_model.g.dart';

RegisterRequestModel registerRequestModelFromJson(String str) =>
    RegisterRequestModel.fromJson(json.decode(str));

String registerRequestModelToJson(RegisterRequestModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class RegisterRequestModel {
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'password')
  final String password;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  @JsonKey(name: 'bio')
  final String? bio;
  @JsonKey(name: 'profile_image')
  final String? profileImage;

  RegisterRequestModel({
    required this.email,
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.bio,
    this.profileImage,
  });

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestModelToJson(this);
}
