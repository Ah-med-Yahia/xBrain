import 'package:explaino/config/base_response/base_response.dart';

abstract interface class RegisterLocalDataSource {
  Future<BaseResponse<void>> saveTokens(
    String accessToken,
    String refreshToken,
  );
}
