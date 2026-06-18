import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/schedule_meeting/data/data_sources/remote/remote_schedule_meeting_data_source.dart';
import 'package:explaino/features/schedule_meeting/data/mappers/schedule_meeting_request_mapper.dart';
import 'package:explaino/features/schedule_meeting/data/mappers/schedule_metting_response_mapper.dart';
import 'package:explaino/features/schedule_meeting/domain/entities/request/schedule_meeting_request_entity.dart';
import 'package:explaino/features/schedule_meeting/domain/entities/request/schedule_meeting_response_entity.dart';
import 'package:explaino/features/schedule_meeting/domain/repositories/schedule_meeting_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ScheduleMeetingRepo)
class ScheduleMeetingRepoImpl implements ScheduleMeetingRepo {
  final RemoteScheduleMeetingDataSource remoteScheduleMeetingDataSource;

  ScheduleMeetingRepoImpl({required this.remoteScheduleMeetingDataSource});

  @override
  Future<BaseResponse<ScheduleMeetingResponseEntity>> scheduleMeeting(
    String id,
    ScheduleMeetingRequestEntity request,
  ) async {
    final response = await remoteScheduleMeetingDataSource.scheduleMeeting(
      id,
      request.toModel(),
    );
    return response.when(
      success: (data) {
        return BaseResponse<ScheduleMeetingResponseEntity>.success(
          data.toEntity(),
        );
      },
      failure: (failure) {
        return BaseResponse<ScheduleMeetingResponseEntity>.failure(failure);
      },
    );
  }
}
