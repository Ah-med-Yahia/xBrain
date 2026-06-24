import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/schedule_meeting/data/mappers/schedule_metting_response_mapper.dart';
import 'package:explaino/features/schedule_meeting/domain/entities/response/schedule_meeting_response_entity.dart';
import 'package:explaino/features/tabs/meetings/data/data_sources/remote/remote_meeting_data_source.dart';
import 'package:explaino/features/tabs/meetings/data/mappers/accept_meeting_request_mapper.dart';
import 'package:explaino/features/tabs/meetings/data/mappers/decline_meeting_request_mapper.dart';
import 'package:explaino/features/tabs/meetings/data/mappers/meetings_response_mapper.dart';
import 'package:explaino/features/tabs/meetings/domain/entities/request/accept_meeting_request_entity.dart';
import 'package:explaino/features/tabs/meetings/domain/entities/request/decline_meeting_request_entity.dart';
import 'package:explaino/features/tabs/meetings/domain/entities/response/meetings_response_entity.dart';
import 'package:explaino/features/tabs/meetings/domain/repositories/meetings_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: MeetingsRepo)
class MeetingsRepoImpl implements MeetingsRepo {
  final RemoteMeetingsDataSource remoteMeetingsDataSource;

  MeetingsRepoImpl({required this.remoteMeetingsDataSource});

  @override
  Future<BaseResponse<MeetingsResponseEntity>> getIncomingMeetings({
    int? page,
  }) async {
    final result = await remoteMeetingsDataSource.getIncomingMeetings(
      page: page,
    );
    return result.when(
      success: (data) {
        return BaseResponse<MeetingsResponseEntity>.success(data.toEntity());
      },
      failure: (error) {
        return BaseResponse<MeetingsResponseEntity>.failure(error);
      },
    );
  }

  @override
  Future<BaseResponse<MeetingsResponseEntity>> getOutgoingMeetings({
    int? page,
  }) async {
    final result = await remoteMeetingsDataSource.getOutgoingMeetings(
      page: page,
    );
    return result.when(
      success: (data) {
        return BaseResponse<MeetingsResponseEntity>.success(data.toEntity());
      },
      failure: (error) {
        return BaseResponse<MeetingsResponseEntity>.failure(error);
      },
    );
  }

  @override
  Future<BaseResponse<ScheduleMeetingResponseEntity>> acceptMeeting(
    String id,
    AcceptMeetingRequestEntity request,
  ) async {
    final result = await remoteMeetingsDataSource.acceptMeeting(
      id,
      request.toModel(),
    );
    return result.when(
      success: (data) {
        return BaseResponse<ScheduleMeetingResponseEntity>.success(
          data.toEntity(),
        );
      },
      failure: (error) {
        return BaseResponse<ScheduleMeetingResponseEntity>.failure(error);
      },
    );
  }

  @override
  Future<BaseResponse<ScheduleMeetingResponseEntity>> declineMeeting(
    String id,
    DeclineMeetingRequestEntity request,
  ) async {
    final result = await remoteMeetingsDataSource.declineMeeting(
      id,
      request.toModel(),
    );
    return result.when(
      success: (data) {
        return BaseResponse<ScheduleMeetingResponseEntity>.success(
          data.toEntity(),
        );
      },
      failure: (error) {
        return BaseResponse<ScheduleMeetingResponseEntity>.failure(error);
      },
    );
  }

  @override
  Future<BaseResponse<ScheduleMeetingResponseEntity>> cancelMeeting(
    String id,
  ) async {
    final result = await remoteMeetingsDataSource.cancelMeeting(id);
    return result.when(
      success: (data) {
        return BaseResponse<ScheduleMeetingResponseEntity>.success(
          data.toEntity(),
        );
      },
      failure: (error) {
        return BaseResponse<ScheduleMeetingResponseEntity>.failure(error);
      },
    );
  }

  @override
  Future<BaseResponse<ScheduleMeetingResponseEntity>> getSingleMeetingDetails(
    String id,
  ) async {
    final result = await remoteMeetingsDataSource.getSingleMeetingDetails(id);
    return result.when(
      success: (data) {
        return BaseResponse<ScheduleMeetingResponseEntity>.success(
          data.toEntity(),
        );
      },
      failure: (error) {
        return BaseResponse<ScheduleMeetingResponseEntity>.failure(error);
      },
    );
  }
}
