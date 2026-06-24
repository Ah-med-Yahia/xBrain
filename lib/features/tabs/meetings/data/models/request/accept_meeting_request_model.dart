import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'accept_meeting_request_model.g.dart';

AcceptMeetingRequestModel acceptMeetingRequestModelFromJson(String str) =>
    AcceptMeetingRequestModel.fromJson(json.decode(str));

String acceptMeetingRequestModelToJson(AcceptMeetingRequestModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class AcceptMeetingRequestModel {
  @JsonKey(name: 'scheduled_at')
  final DateTime scheduledAt;

  const AcceptMeetingRequestModel({required this.scheduledAt});

  factory AcceptMeetingRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AcceptMeetingRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$AcceptMeetingRequestModelToJson(this);
}
