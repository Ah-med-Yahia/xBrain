import 'package:dio/dio.dart';
import 'package:explaino/core/constants/api_constants.dart';
import 'package:explaino/features/schedule_meeting/data/models/request/schedule_meeting_request_model.dart';
import 'package:explaino/features/schedule_meeting/data/models/response/schedule_meeting_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'schedule_meeting_api_client.g.dart';

@singleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ScheduleMeetingApiClient {
  @factoryMethod
  factory ScheduleMeetingApiClient(Dio dio) = _ScheduleMeetingApiClient;

  @POST(ApiConstants.scheduleMeeting)
  Future<ScheduleMeetingResponseModel> scheduleMeeting(
    @Path('id') String id,
    @Body() ScheduleMeetingRequestModel body,
  );
}
