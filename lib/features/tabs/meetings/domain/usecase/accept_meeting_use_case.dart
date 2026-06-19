import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/schedule_meeting/domain/entities/response/schedule_meeting_response_entity.dart';
import 'package:explaino/features/tabs/meetings/domain/repositories/meetings_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AcceptMeetingUseCase {
  final MeetingsRepo meetingsRepo;

  AcceptMeetingUseCase({required this.meetingsRepo});

  Future<BaseResponse<ScheduleMeetingResponseEntity>> call(
    String id,
    String createdAt,
  ) {
    return meetingsRepo.acceptMeeting(id, createdAt);
  }
}
