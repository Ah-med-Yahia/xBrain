import 'package:explaino/features/tabs/meetings/data/models/request/decline_meeting_request_model.dart';
import 'package:explaino/features/tabs/meetings/domain/entities/request/decline_meeting_request_entity.dart';

extension DeclineMeetingRequestEntityMapper on DeclineMeetingRequestEntity {
  DeclineMeetingRequestModel toModel() {
    return DeclineMeetingRequestModel(message: message);
  }
}
