import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/schedule_meeting/data/models/response/schedule_meeting_response_model.dart';
import 'package:explaino/features/tabs/meetings/data/models/response/meetings_response_model.dart';

abstract interface class RemoteMeetingsDataSource {
  Future<BaseResponse<MeetingsResponseModel>> getIncomingMeetings({int? page});

  Future<BaseResponse<MeetingsResponseModel>> getOutgoingMeetings({int? page});
  Future<BaseResponse<ScheduleMeetingResponseModel>> cancelMeeting(String id);
  Future<BaseResponse<ScheduleMeetingResponseModel>> declineMeeting(
    String id,
    String message,
  );
  Future<BaseResponse<ScheduleMeetingResponseModel>> acceptMeeting(
    String id,
    String createdAt,
  );
  Future<BaseResponse<ScheduleMeetingResponseModel>> getSingleMeetingDetails(
    String id,
  );
}
