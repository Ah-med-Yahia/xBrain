import 'package:explaino/core/shared/data/models/auth_response_model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'auth_response_model.g.dart';

AuthResponseModel authResponseModelFromJson(String str) =>
    AuthResponseModel.fromJson(json.decode(str));

String authResponseModelToJson(AuthResponseModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class AuthResponseModel {
  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'access_token')
  final String accessToken;
  @JsonKey(name: 'refresh_token')
  final String refreshToken;
  @JsonKey(name: 'user')
  final User user;

  AuthResponseModel({
    required this.message,
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  AuthResponseModel copyWith({
    String? message,
    String? accessToken,
    String? refreshToken,
    User? user,
  }) => AuthResponseModel(
    message: message ?? this.message,
    accessToken: accessToken ?? this.accessToken,
    refreshToken: refreshToken ?? this.refreshToken,
    user: user ?? this.user,
  );

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseModelToJson(this);
}
