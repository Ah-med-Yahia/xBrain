import 'package:json_annotation/json_annotation.dart';
part 'reset_password_request_model.g.dart';

@JsonSerializable()
class ResetPasswordRequestModel {
  final String email;
  final String token;
  @JsonKey(name: 'new_password')
  final String newPassword;

  ResetPasswordRequestModel({
    required this.email,
    required this.token,
    required this.newPassword,
  });

  factory ResetPasswordRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$ResetPasswordRequestModelToJson(this);
}
