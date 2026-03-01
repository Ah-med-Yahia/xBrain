import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'resend_otp_response_model.g.dart';

ResendOtpResponseModel resendOtpResponseModelFromJson(String str) =>
    ResendOtpResponseModel.fromJson(json.decode(str));

String resendOtpResponseModelToJson(ResendOtpResponseModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class ResendOtpResponseModel {
  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'email')
  final String email;

  ResendOtpResponseModel({required this.message, required this.email});

  ResendOtpResponseModel copyWith({String? message, String? email}) =>
      ResendOtpResponseModel(
        message: message ?? this.message,
        email: email ?? this.email,
      );

  factory ResendOtpResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResendOtpResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResendOtpResponseModelToJson(this);
}
