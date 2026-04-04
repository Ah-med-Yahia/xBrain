import 'package:explaino/core/shared/data/models/refresh_token_response_model/refresh_token_response_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class TokensManagerContract {
  Future<RefreshTokenResponseModel> refreshToken(String refreshToken);
  Future<Response<dynamic>> fetchRequestOptions(RequestOptions options);
}

@LazySingleton(as: TokensManagerContract)
class DummyTokensManager implements TokensManagerContract {
  @override
  Future<RefreshTokenResponseModel> refreshToken(String refreshToken) async {
    // ترجع dummy object مؤقت
    return RefreshTokenResponseModel(access: '', refresh: '');
  }

  @override
  Future<Response> fetchRequestOptions(RequestOptions options) async {
    // بس رجع نفس الطلب بدون تعديل
    return Response(requestOptions: options, statusCode: 200, data: {});
  }
}
