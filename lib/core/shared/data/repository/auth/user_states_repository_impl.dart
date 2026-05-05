import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/data/data_sources/local/auth/user_states_local_data_sources.dart';
import 'package:explaino/core/shared/domain/repository/auth/user_states_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: UserStatesRepository)
class UserStatesRepositoryImpl implements UserStatesRepository {
  final UserStatesLocalDataSources _userStatesLocalDataSources;
  UserStatesRepositoryImpl(this._userStatesLocalDataSources);
  @override
  Future<BaseResponse<void>> saveOnBoardingViewed() {
    return _userStatesLocalDataSources.saveOnBoardingViewed();
  }

  @override
  Future<BaseResponse<bool?>> getOnBoardingViewed() {
    return _userStatesLocalDataSources.getOnBoardingViewed();
  }

  @override
  Future<BaseResponse<void>> saveIsLoggedIn() {
    return _userStatesLocalDataSources.saveIsLoggedIn();
  }

  @override
  Future<BaseResponse<bool?>> getIsLoggedIn() {
    return _userStatesLocalDataSources.getIsLoggedIn();
  }
}
