import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/schedule_meeting/domain/entities/request/schedule_meeting_request_entity.dart';
import 'package:explaino/features/schedule_meeting/domain/entities/request/schedule_meeting_response_entity.dart';
import 'package:explaino/features/schedule_meeting/domain/repositories/schedule_meeting_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ScheduleMeetingUseCase {
  final ScheduleMeetingRepo scheduleMeetingRepo;

  ScheduleMeetingUseCase({required this.scheduleMeetingRepo});

  Future<BaseResponse<ScheduleMeetingResponseEntity>> call(
    ScheduleMeetingRequestEntity request,
  ) async {
    return await scheduleMeetingRepo.scheduleMeeting(request);
  }
}
