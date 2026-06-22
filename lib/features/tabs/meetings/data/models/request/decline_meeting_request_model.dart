import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'decline_meeting_request_model.g.dart';

DeclineMeetingRequestModel declineMeetingRequestModelFromJson(String str) =>
    DeclineMeetingRequestModel.fromJson(json.decode(str));

String declineMeetingRequestModelToJson(DeclineMeetingRequestModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class DeclineMeetingRequestModel {
  @JsonKey(name: 'message')
  final String? message;

  const DeclineMeetingRequestModel({required this.message});

  factory DeclineMeetingRequestModel.fromJson(Map<String, dynamic> json) =>
      _$DeclineMeetingRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeclineMeetingRequestModelToJson(this);
}
