import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/domain/repository/auth/user_states_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SaveViewedOnBoardingUseCase {
  final UserStatesRepository _userStatesRepository;
  SaveViewedOnBoardingUseCase(this._userStatesRepository);
  Future<BaseResponse<void>> call() async {
    return await _userStatesRepository.saveOnBoardingViewed();
  }
}
