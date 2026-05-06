import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/domain/repository/auth/user_states_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SaveIsLoggedInUseCase {
  final UserStatesRepository userStatesRepository;
  SaveIsLoggedInUseCase({required this.userStatesRepository});

  Future<BaseResponse<void>> call() {
    return userStatesRepository.saveIsLoggedIn();
  }
}
