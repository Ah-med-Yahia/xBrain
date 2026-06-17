import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/schedule_meeting/domain/entities/request/schedule_meeting_request_entity.dart';
import 'package:explaino/features/schedule_meeting/domain/entities/request/schedule_meeting_response_entity.dart';

abstract class ScheduleMeetingRepo {
  Future<BaseResponse<ScheduleMeetingResponseEntity>> scheduleMeeting(
    ScheduleMeetingRequestEntity request,
  );
}
