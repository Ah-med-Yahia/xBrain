import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'verify_email_request_model.g.dart';

VerifyEmailRequestModel verifyEmailRequestModelFromJson(String str) => VerifyEmailRequestModel.fromJson(json.decode(str));

String verifyEmailRequestModelToJson(VerifyEmailRequestModel data) => json.encode(data.toJson());

@JsonSerializable()
class VerifyEmailRequestModel {
    @JsonKey(name: 'email')
    final String email;
    @JsonKey(name: 'otp')
    final String otp;

    VerifyEmailRequestModel({
        required this.email,
        required this.otp,
    });

    factory VerifyEmailRequestModel.fromJson(Map<String, dynamic> json) => _$VerifyEmailRequestModelFromJson(json);

    Map<String, dynamic> toJson() => _$VerifyEmailRequestModelToJson(this);
}
