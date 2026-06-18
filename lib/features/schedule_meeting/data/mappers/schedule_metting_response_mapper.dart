import 'package:explaino/features/schedule_meeting/data/models/response/schedule_meeting_response_model.dart';
import 'package:explaino/features/schedule_meeting/domain/entities/request/schedule_meeting_response_entity.dart';

extension ScheduleMeetingResponseModelMapper on ScheduleMeetingResponseModel {
  ScheduleMeetingResponseEntity toEntity() {
    return ScheduleMeetingResponseEntity(
      id: id,
      asker: asker,
      answerer: answerer,
      answerId: answerId,
      questionId: questionId,
      questionPreview: questionPreview,
      message: message,
      durationMinutes: durationMinutes,
      proposedSlots: proposedSlots,
      scheduledAt: scheduledAt,
      meetLink: meetLink,
      declineMessage: declineMessage,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
