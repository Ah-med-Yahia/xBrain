import 'package:dio/dio.dart';
import 'package:explaino/core/constants/api_constants.dart';
import 'package:explaino/features/schedule_meeting/data/models/response/schedule_meeting_response_model.dart';
import 'package:explaino/features/tabs/meetings/data/models/response/meetings_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
part 'metting_api_client.g.dart';

@singleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class MeetingsApiClient {
  @factoryMethod
  factory MeetingsApiClient(Dio dio) = _MeetingsApiClient;

  @GET(ApiConstants.getOutgoingMeetings)
  Future<MeetingsResponseModel> getOutgoingMeetings({@Query('page') int? page});

  @GET(ApiConstants.getIncomingMeetings)
  Future<MeetingsResponseModel> getIncomingMeetings({@Query('page') int? page});

  @POST(ApiConstants.cancelMeeting)
  Future<ScheduleMeetingResponseModel> cancelMeeting(@Path() String id);

  @POST(ApiConstants.declineMeeting)
  Future<ScheduleMeetingResponseModel> declineMeeting(
    @Path() String id,
    String message,
  );

  @POST(ApiConstants.acceptMeeting)
  Future<ScheduleMeetingResponseModel> acceptMeeting(
    @Path() String id,
    String createdAt,
  );

  @POST(ApiConstants.getSingleMeetingDetails)
  Future<ScheduleMeetingResponseModel> getSingleMeetingDetails(
    @Path() String id,
  );
}
