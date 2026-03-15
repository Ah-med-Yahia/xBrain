import 'package:explaino/config/base_response/base_response.dart';

abstract class TokenServiceStorageContract {
  Future<BaseResponse<bool>> saveTokens({
    required String accessToken,
    required String refreshToken,
  });

  Future<BaseResponse<bool>> saveAccessToken({required String token});

  Future<BaseResponse<bool>> saveRefreshToken({required String token});

  Future<BaseResponse<String?>> getAccessToken();

  Future<BaseResponse<String?>> getRefreshToken();

  Future<BaseResponse<void>> clearTokens();
}
