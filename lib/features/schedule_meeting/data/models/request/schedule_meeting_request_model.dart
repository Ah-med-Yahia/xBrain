import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'schedule_meeting_request_model.g.dart';

ScheduleMeetingRequestModel scheduleMeetingRequestModelFromJson(String str) =>
    ScheduleMeetingRequestModel.fromJson(json.decode(str));

String scheduleMeetingRequestModelToJson(ScheduleMeetingRequestModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class ScheduleMeetingRequestModel {
  @JsonKey(name: 'duration_minutes')
  final int durationMinutes;

  @JsonKey(name: 'proposed_slots')
  final List<String> proposedSlots;

  @JsonKey(name: 'message')
  final String? message;

  const ScheduleMeetingRequestModel({
    required this.durationMinutes,
    required this.proposedSlots,
    this.message,
  });

  ScheduleMeetingRequestModel copyWith({
    int? durationMinutes,
    List<String>? proposedSlots,
    String? message,
  }) {
    return ScheduleMeetingRequestModel(
      durationMinutes: durationMinutes ?? this.durationMinutes,
      proposedSlots: proposedSlots ?? this.proposedSlots,
      message: message ?? this.message,
    );
  }

  factory ScheduleMeetingRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleMeetingRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleMeetingRequestModelToJson(this);
}
