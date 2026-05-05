import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/config/cache_services/cache_storage_contract.dart';
import 'package:explaino/config/cache_services/serializer/bool_serializer.dart';
import 'package:explaino/core/constants/cache_constants.dart';
import 'package:explaino/core/shared/data/data_sources/local/auth/user_states_local_data_sources.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: UserStatesLocalDataSources)
class UserStatesLocalDataSourcesImpl implements UserStatesLocalDataSources {
  final CacheStorageContract _cacheStorage;
  UserStatesLocalDataSourcesImpl(@Named('secureStorage') this._cacheStorage);
  @override
  Future<BaseResponse<void>> saveOnBoardingViewed() async {
    return await _cacheStorage.write(
      StorageKeys.onBoardingViewed,
      true,
      BoolSerializer(),
    );
  }

  @override
  Future<BaseResponse<bool?>> getOnBoardingViewed() async {
    return await _cacheStorage.read(
      StorageKeys.onBoardingViewed,
      BoolSerializer(),
    );
  }

  @override
  Future<BaseResponse<void>> saveIsLoggedIn() async {
    return await _cacheStorage.write(
      StorageKeys.isLoggedIn,
      true,
      BoolSerializer(),
    );
  }

  @override
  Future<BaseResponse<bool?>> getIsLoggedIn() async {
    return await _cacheStorage.read(StorageKeys.isLoggedIn, BoolSerializer());
  }
}
