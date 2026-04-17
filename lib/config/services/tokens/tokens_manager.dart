import 'package:dio/dio.dart';
import 'package:explaino/config/services/tokens/tokens_manager_contract.dart';
import 'package:explaino/core/constants/api_constants.dart';
import 'package:explaino/core/shared/data/models/refresh_token_response_model/refresh_token_response_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: TokensManagerContract)
class TokensManager implements TokensManagerContract {
  final Dio dio;
  TokensManager(this.dio);
  @override
  Future<RefreshTokenResponseModel> refreshToken(String refreshToken) async {
    final response = await dio.post(
      ApiConstants.refreshToken,
      data: {ApiConstants.refreshTokenKey: refreshToken},
    );
    return RefreshTokenResponseModel.fromJson(response.data);
  }

  @override
  Future<Response<dynamic>> fetchRequestOptions(RequestOptions options) async {
    return await dio.fetch(options);
  }
}
