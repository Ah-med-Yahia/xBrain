import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/schedule_meeting/data/models/request/schedule_meeting_request_model.dart';
import 'package:explaino/features/schedule_meeting/data/models/response/schedule_meeting_response_model.dart';

abstract class RemoteScheduleMeetingDataSource {
  Future<BaseResponse<ScheduleMeetingResponseModel>> scheduleMeeting(
    ScheduleMeetingRequestModel request,
  );
}
