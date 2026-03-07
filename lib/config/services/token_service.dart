import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/config/cache_services/cache_storage_contract.dart';
import 'package:explaino/config/cache_services/serializer/string_serializer.dart';
import 'package:explaino/core/constants/cache_constants.dart';
import 'package:injectable/injectable.dart';

@injectable
class TokenService {
  final CacheStorageContract _secureStorageService;

  TokenService(@Named('secureStorage') this._secureStorageService);

  Future<BaseResponse<String?>> getToken() async {
    final result = await _secureStorageService.read(
      StorageKeys.accessToken,
      StringSerializer(),
    );
    return result.when(
      success: (s) => BaseResponse.success(s),
      failure: (f) => BaseResponse.failure(f),
    );
  }

  Future<BaseResponse<bool>> saveToken({required String accessToken}) async {
    final result = await _secureStorageService.write(
      StorageKeys.accessToken,
      accessToken,
      StringSerializer(),
    );
    return result.when(
      success: (s) => const BaseResponse<bool>.success(true),
      failure: (f) => BaseResponse<bool>.failure(f),
    );
  }

  Future<BaseResponse<bool>> clearToken() async {
    final results = await _secureStorageService.delete(StorageKeys.accessToken);
    return results.when(
      success: (s) => const BaseResponse.success(true),
      failure: (f) => BaseResponse.failure(f),
    );
  }

  Future<BaseResponse<bool>> isTokenValid() async {
    final tokenResponse = await getToken();

    return tokenResponse.when(
      success: (token) {
        if (token == null || token.isEmpty) {
          return const BaseResponse.success(false);
        }

        return const BaseResponse.success(true);
      },
      failure: (error) => const BaseResponse.success(false),
    );
  }
}
