import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/config/network/safe_api_call.dart';
import 'package:explaino/features/schedule_meeting/api/api_clients/schedule_meeting_api_client.dart';
import 'package:explaino/features/schedule_meeting/data/data_sources/remote/remote_schedule_meeting_data_source.dart';
import 'package:explaino/features/schedule_meeting/data/models/request/schedule_meeting_request_model.dart';
import 'package:explaino/features/schedule_meeting/data/models/response/schedule_meeting_response_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RemoteScheduleMeetingDataSource)
class RemoteScheduleMeetingDataSourceImpl
    implements RemoteScheduleMeetingDataSource {
  final ScheduleMeetingApiClient _apiClient;

  RemoteScheduleMeetingDataSourceImpl(this._apiClient);

  @override
  Future<BaseResponse<ScheduleMeetingResponseModel>> scheduleMeeting(
    ScheduleMeetingRequestModel request,
  ) async {
    return await safeApiCall<ScheduleMeetingResponseModel>(
      () => _apiClient.scheduleMeeting(request),
    );
  }
}
