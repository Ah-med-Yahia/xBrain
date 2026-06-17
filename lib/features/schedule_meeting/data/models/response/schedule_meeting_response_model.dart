import 'package:explaino/core/shared/data/models/auth/user_model/user_model.dart';
import 'package:explaino/features/schedule_meeting/data/models/meeting_status.dart';
import 'package:json_annotation/json_annotation.dart';
part 'schedule_meeting_response_model.g.dart';

@JsonSerializable()
class ScheduleMeetingResponseModel {
  final String id;

  final UserModel asker;
  final UserModel answerer;

  @JsonKey(name: 'answer_id')
  final String answerId;

  @JsonKey(name: 'question_id')
  final String questionId;

  @JsonKey(name: 'question_preview')
  final String questionPreview;

  final String? message;

  @JsonKey(name: 'duration_minutes')
  final int durationMinutes;

  @JsonKey(name: 'proposed_slots')
  final List<DateTime> proposedSlots;

  @JsonKey(name: 'scheduled_at')
  final DateTime? scheduledAt;

  @JsonKey(name: 'meet_link')
  final String? meetLink;

  @JsonKey(name: 'decline_message')
  final String? declineMessage;

  final MeetingStatus status;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  const ScheduleMeetingResponseModel({
    required this.id,
    required this.asker,
    required this.answerer,
    required this.answerId,
    required this.questionId,
    required this.questionPreview,
    required this.durationMinutes,
    required this.proposedSlots,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.message,
    this.scheduledAt,
    this.meetLink,
    this.declineMessage,
  });

  factory ScheduleMeetingResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleMeetingResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleMeetingResponseModelToJson(this);
}
