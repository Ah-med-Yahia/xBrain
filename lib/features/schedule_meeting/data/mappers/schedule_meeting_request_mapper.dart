import 'package:explaino/features/schedule_meeting/data/models/request/schedule_meeting_request_model.dart';
import 'package:explaino/features/schedule_meeting/domain/entities/request/schedule_meeting_request_entity.dart';

extension ScheduleMeetingRequestMapper on ScheduleMeetingRequestEntity {
  ScheduleMeetingRequestModel toModel() {
    return ScheduleMeetingRequestModel(
      durationMinutes: durationMinutes,
      proposedSlots: proposedSlots,
      message: message,
    );
  }
}
