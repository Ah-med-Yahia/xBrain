import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'refresh_token_response_model.g.dart';

RefreshTokenResponseModel refreshTokenResponseModelFromJson(String str) =>
    RefreshTokenResponseModel.fromJson(json.decode(str));

@JsonSerializable()
class RefreshTokenResponseModel {
  @JsonKey(name: 'access')
  final String access;
  @JsonKey(name: 'refresh')
  final String refresh;

  RefreshTokenResponseModel({required this.access, required this.refresh});

  factory RefreshTokenResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenResponseModelFromJson(json);
}
