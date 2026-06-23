import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/schedule_meeting/domain/entities/response/schedule_meeting_response_entity.dart';
import 'package:explaino/features/tabs/meetings/domain/repositories/meetings_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class CancelMeetingUseCase {
  final MeetingsRepo meetingsRepo;

  CancelMeetingUseCase({required this.meetingsRepo});

  Future<BaseResponse<ScheduleMeetingResponseEntity>> call(String id) {
    return meetingsRepo.cancelMeeting(id);
  }
}
