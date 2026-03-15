import 'package:dio/dio.dart';
import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/config/services/app_logger.dart';
import 'package:explaino/config/services/token_service_storage_contract.dart';
import 'package:explaino/core/constants/api_constants.dart';
import 'package:explaino/core/constants/cache_constants.dart';
import 'package:explaino/core/extensions/extensions.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthInterceptor extends Interceptor {
  final TokenServiceStorageContract _tokenStorage;

  AuthInterceptor(this._tokenStorage);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await _tokenStorage.getAccessToken();

    accessToken.when(
      success: (token) {
        if (!token.isNullOrEmpty()) {
          options.headers[ApiConstants.authorization] =
              '${ApiConstants.bearer} $token';
        }
      },
      failure: (error) {
        appLogger.e(CacheConstants.accessTokenReadFailed);
      },
    );

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final refreshed = await _tokenStorage.getRefreshToken();
      refreshed.when(
        success: (token) async {
          if (!token.isNullOrEmpty()) {
            // use getNewAccessToken endpoint to get new access token
            // new access and refresh tokens
            // save new access and refresh tokens

            err.requestOptions.headers[ApiConstants.authorization] =
                '${ApiConstants.bearer} $token';
            final cloneRequest = await Dio().fetch(err.requestOptions);
            return handler.resolve(cloneRequest);
          }
        },
        failure: (error) {
          return handler.reject(
            DioException(
              requestOptions: err.requestOptions,
              error: 'Session expired',
              type: DioExceptionType.cancel,
            ),
          );
        },
      );
    }
    handler.next(err);
  }
}
