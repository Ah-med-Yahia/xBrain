import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/tabs/meetings/domain/entities/response/meetings_response_entity.dart';
import 'package:explaino/features/tabs/meetings/domain/repositories/meetings_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetIncomingMeetingsUseCase {
  final MeetingsRepo meetingsRepo;

  GetIncomingMeetingsUseCase({required this.meetingsRepo});

  Future<BaseResponse<MeetingsResponseEntity>> call() {
    return meetingsRepo.getIncomingMeetings();
  }
}
