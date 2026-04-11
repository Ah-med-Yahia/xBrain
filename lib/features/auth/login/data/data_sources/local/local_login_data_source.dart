import 'package:explaino/config/base_response/base_response.dart';

abstract interface class LocalLoginDataSource {
  Future<BaseResponse<void>> saveLoggedUserData({
    required String accessToken,
    required String refreshToken,
  });
}
