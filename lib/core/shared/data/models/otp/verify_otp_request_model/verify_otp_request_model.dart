import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'verify_otp_request_model.g.dart';

VerifyOtpRequestModel verifyOtpRequestModelFromJson(String str) =>
    VerifyOtpRequestModel.fromJson(json.decode(str));

String verifyOtpRequestModelToJson(VerifyOtpRequestModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class VerifyOtpRequestModel {
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'otp')
  final String otp;

  VerifyOtpRequestModel({required this.email, required this.otp});

  factory VerifyOtpRequestModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyOtpRequestModelToJson(this);
}
