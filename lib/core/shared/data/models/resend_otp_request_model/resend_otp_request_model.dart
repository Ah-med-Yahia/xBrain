import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'resend_otp_request_model.g.dart';

ResendOtpRequestModel resendOtpRequestModelFromJson(String str) =>
    ResendOtpRequestModel.fromJson(json.decode(str));

String resendOtpRequestModelToJson(ResendOtpRequestModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class ResendOtpRequestModel {
  @JsonKey(name: 'email')
  final String email;

  ResendOtpRequestModel({required this.email});

  factory ResendOtpRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ResendOtpRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResendOtpRequestModelToJson(this);
}
