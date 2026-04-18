import 'package:freezed_annotation/freezed_annotation.dart';
part 'verify_email_response_model.g.dart';

@JsonSerializable()
class VerifyEmailResponseModel {
  final String email;
  final String otp;
  @JsonKey(name: 'reset_token')
  final String resetToken;

  VerifyEmailResponseModel({
    required this.email,
    required this.otp,
    required this.resetToken,
  });

  factory VerifyEmailResponseModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyEmailResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyEmailResponseModelToJson(this);
}
