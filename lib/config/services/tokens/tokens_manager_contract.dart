import 'package:explaino/core/shared/data/models/refresh_token_response_model/refresh_token_response_model.dart';
import 'package:dio/dio.dart';

abstract class TokensManagerContract {
  Future<RefreshTokenResponseModel> refreshToken(String refreshToken);
  Future<Response<dynamic>> fetchRequestOptions(RequestOptions options);
}
