import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/config/network/safe_api_call.dart';
import 'package:explaino/features/schedule_meeting/data/models/response/schedule_meeting_response_model.dart';
import 'package:explaino/features/tabs/meetings/api/api_clients/metting_api_client.dart';
import 'package:explaino/features/tabs/meetings/data/data_sources/remote/remote_meeting_data_source.dart';
import 'package:explaino/features/tabs/meetings/data/models/request/decline_meeting_request_model.dart';
import 'package:explaino/features/tabs/meetings/data/models/response/meetings_response_model.dart';
import 'package:explaino/features/tabs/meetings/data/models/request/accept_meeting_request_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RemoteMeetingsDataSource)
class RemoteMeetingsDataSourceImpl implements RemoteMeetingsDataSource {
  final MeetingsApiClient _apiClient;

  RemoteMeetingsDataSourceImpl(this._apiClient);

  @override
  Future<BaseResponse<MeetingsResponseModel>> getIncomingMeetings({
    int? page,
  }) async {
    return await safeApiCall<MeetingsResponseModel>(
      () => _apiClient.getIncomingMeetings(page: page),
    );
  }

  @override
  Future<BaseResponse<ScheduleMeetingResponseModel>> acceptMeeting(
    String id,
    AcceptMeetingRequestModel request,
  ) async {
    return await safeApiCall<ScheduleMeetingResponseModel>(
      () => _apiClient.acceptMeeting(id, request),
    );
  }

  @override
  Future<BaseResponse<ScheduleMeetingResponseModel>> cancelMeeting(
    String id,
  ) async {
    return await safeApiCall<ScheduleMeetingResponseModel>(
      () => _apiClient.cancelMeeting(id),
    );
  }

  @override
  Future<BaseResponse<ScheduleMeetingResponseModel>> declineMeeting(
    String id,
    DeclineMeetingRequestModel request,
  ) async {
    return await safeApiCall<ScheduleMeetingResponseModel>(
      () => _apiClient.declineMeeting(id, request),
    );
  }

  @override
  Future<BaseResponse<MeetingsResponseModel>> getOutgoingMeetings({
    int? page,
  }) async {
    return await safeApiCall<MeetingsResponseModel>(
      () => _apiClient.getOutgoingMeetings(page: page),
    );
  }

  @override
  Future<BaseResponse<ScheduleMeetingResponseModel>> getSingleMeetingDetails(
    String id,
  ) async {
    return await safeApiCall<ScheduleMeetingResponseModel>(
      () => _apiClient.getSingleMeetingDetails(id),
    );
  }
}
