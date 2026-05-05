import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/domain/repository/auth/user_states_repository.dart';
import 'package:explaino/features/splash/presentation/cubit/splash_states.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserStatusUseCase {
  final UserStatesRepository _userStatesRepository;

  GetUserStatusUseCase(this._userStatesRepository);

  Future<UserInitialStatus> call() async {
    final isLoggedInRes = await _userStatesRepository.getIsLoggedIn();
    final onBoardingRes = await _userStatesRepository.getOnBoardingViewed();

    return onBoardingRes.when(
      success: (viewd) {
        if (!(viewd ?? false)) {
          return UserInitialStatus.newUser;
        } else {
          return isLoggedInRes.when(
            success: (isLoggedIn) {
              if (isLoggedIn ?? false) {
                return UserInitialStatus.loggedIn;
              } else {
                return UserInitialStatus.notLoggedIn;
              }
            },
            failure: (error) {
              return UserInitialStatus.notLoggedIn;
            },
          );
        }
      },
      failure: (error) {
        return UserInitialStatus.newUser;
      },
    );
  }
}
