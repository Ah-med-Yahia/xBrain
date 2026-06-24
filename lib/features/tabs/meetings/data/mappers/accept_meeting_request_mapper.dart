import 'package:explaino/features/tabs/meetings/data/models/request/accept_meeting_request_model.dart';
import 'package:explaino/features/tabs/meetings/domain/entities/request/accept_meeting_request_entity.dart';

extension AcceptMeetingRequestMapper on AcceptMeetingRequestEntity {
  AcceptMeetingRequestModel toModel() {
    return AcceptMeetingRequestModel(scheduledAt: scheduledAt);
  }
}
