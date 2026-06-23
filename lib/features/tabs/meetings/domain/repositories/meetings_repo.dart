import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/schedule_meeting/domain/entities/response/schedule_meeting_response_entity.dart';
import 'package:explaino/features/tabs/meetings/domain/entities/request/accept_meeting_request_entity.dart';
import 'package:explaino/features/tabs/meetings/domain/entities/request/decline_meeting_request_entity.dart';
import 'package:explaino/features/tabs/meetings/domain/entities/response/meetings_response_entity.dart';

abstract interface class MeetingsRepo {
  Future<BaseResponse<MeetingsResponseEntity>> getIncomingMeetings({int? page});

  Future<BaseResponse<MeetingsResponseEntity>> getOutgoingMeetings({int? page});

  Future<BaseResponse<ScheduleMeetingResponseEntity>> acceptMeeting(
    String id,
    AcceptMeetingRequestEntity request,
  );

  Future<BaseResponse<ScheduleMeetingResponseEntity>> declineMeeting(
    String id,
    DeclineMeetingRequestEntity request,
  );

  Future<BaseResponse<ScheduleMeetingResponseEntity>> cancelMeeting(String id);

  Future<BaseResponse<ScheduleMeetingResponseEntity>> getSingleMeetingDetails(
    String id,
  );
}
