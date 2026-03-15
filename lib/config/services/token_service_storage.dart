import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/config/cache_services/cache_storage_contract.dart';
import 'package:explaino/config/cache_services/serializer/string_serializer.dart';
import 'package:explaino/config/services/token_service_storage_contract.dart';
import 'package:explaino/core/constants/cache_constants.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: TokenServiceStorageContract)
class TokenServiceStorage implements TokenServiceStorageContract {
  final CacheStorageContract _secureStorageService;

  TokenServiceStorage(@Named('secureStorage') this._secureStorageService);

  @override
  Future<BaseResponse<bool>> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    final result = await _secureStorageService.write(
      StorageKeys.accessToken,
      accessToken,
      StringSerializer(),
    );
    final result2 = await _secureStorageService.write(
      StorageKeys.refreshToken,
      refreshToken,
      StringSerializer(),
    );
    return result.when(
      success: (_) => result2.when(
        success: (_) => const BaseResponse<bool>.success(true),
        failure: (f) => BaseResponse<bool>.failure(f),
      ),
      failure: (f) => BaseResponse<bool>.failure(f),
    );
  }

  @override
  Future<BaseResponse<bool>> saveAccessToken({required String token}) async {
    final result = await _secureStorageService.write(
      StorageKeys.accessToken,
      token,
      StringSerializer(),
    );
    return result.when(
      success: (_) => const BaseResponse<bool>.success(true),
      failure: (f) => BaseResponse<bool>.failure(f),
    );
  }

  @override
  Future<BaseResponse<bool>> saveRefreshToken({required String token}) async {
    final result = await _secureStorageService.write(
      StorageKeys.refreshToken,
      token,
      StringSerializer(),
    );
    return result.when(
      success: (_) => const BaseResponse<bool>.success(true),
      failure: (f) => BaseResponse<bool>.failure(f),
    );
  }

  @override
  Future<BaseResponse<String?>> getAccessToken() async {
    final result = await _secureStorageService.read(
      StorageKeys.accessToken,
      StringSerializer(),
    );
    return result.when(
      success: (s) => BaseResponse.success(s),
      failure: (f) => BaseResponse.failure(f),
    );
  }

  @override
  Future<BaseResponse<String?>> getRefreshToken() async {
    final result = await _secureStorageService.read(
      StorageKeys.refreshToken,
      StringSerializer(),
    );
    return result.when(
      success: (s) => BaseResponse.success(s),
      failure: (f) => BaseResponse.failure(f),
    );
  }

  @override
  Future<BaseResponse<void>> clearTokens() async {
    final result = await _secureStorageService.delete(StorageKeys.accessToken);
    final result2 = await _secureStorageService.delete(
      StorageKeys.refreshToken,
    );
    return result.when(
      success: (_) => result2.when(
        success: (_) => const BaseResponse<void>.success(null),
        failure: (f) => BaseResponse<void>.failure(f),
      ),
      failure: (f) => BaseResponse<void>.failure(f),
    );
  }
}
