import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'otp_response_model.g.dart';

OtpResponseModel otpResponseModelFromJson(String str) =>
    OtpResponseModel.fromJson(json.decode(str));

String otpResponseModelToJson(OtpResponseModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class OtpResponseModel {
  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'email')
  final String email;

  OtpResponseModel({required this.message, required this.email});

  OtpResponseModel copyWith({String? message, String? email}) =>
      OtpResponseModel(
        message: message ?? this.message,
        email: email ?? this.email,
      );

  factory OtpResponseModel.fromJson(Map<String, dynamic> json) =>
      _$OtpResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$OtpResponseModelToJson(this);
}
