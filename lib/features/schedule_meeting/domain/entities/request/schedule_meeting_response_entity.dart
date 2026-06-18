import 'package:explaino/features/schedule_meeting/data/models/meeting_status.dart';
import 'package:explaino/features/schedule_meeting/data/models/user_model.dart';

class ScheduleMeetingResponseEntity {
  final String id;

  final UserModel asker;
  final UserModel answerer;

  final String answerId;
  final String questionId;
  final String questionPreview;

  final String? message;

  final int durationMinutes;

  final List<DateTime> proposedSlots;

  final DateTime? scheduledAt;

  final String? meetLink;

  final String? declineMessage;

  final MeetingStatus status;

  final DateTime createdAt;
  final DateTime updatedAt;

  const ScheduleMeetingResponseEntity({
    required this.id,
    required this.asker,
    required this.answerer,
    required this.answerId,
    required this.questionId,
    required this.questionPreview,
    this.message,
    required this.durationMinutes,
    required this.proposedSlots,
    this.scheduledAt,
    this.meetLink,
    this.declineMessage,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
}
