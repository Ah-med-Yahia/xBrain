import 'package:dio/dio.dart';
import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/config/errors/local_exception.dart';
import 'package:explaino/config/network/safe_api_call.dart';
import 'package:explaino/config/services/app_logger.dart';
import 'package:explaino/config/services/tokens/token_service_storage_contract.dart';
import 'package:explaino/config/services/tokens/tokens_manager_contract.dart';
import 'package:explaino/core/constants/api_constants.dart';
import 'package:explaino/core/constants/cache_constants.dart';
import 'package:explaino/core/constants/errors_constants.dart';
import 'package:explaino/core/extensions/extensions.dart';
import 'package:explaino/core/routing/app_router.dart';
import 'package:explaino/core/routing/app_routes_constant.dart';
import 'package:explaino/core/shared/data/models/auth/refresh_token_response_model/refresh_token_response_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthInterceptor extends Interceptor {
  final TokenServiceStorageContract _tokenStorage;
  final TokensManagerContract _tokensManager;

  AuthInterceptor(this._tokenStorage, this._tokensManager);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final isPublic = ApiConstants.publicEndpoints.any(
      (endpoint) => options.path.contains(endpoint),
    );
    if (!isPublic) {
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
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      final refreshedTokenResponse = await _tokenStorage.getRefreshToken();
      refreshedTokenResponse.when(
        success: (refreshToken) async {
          if (refreshToken.isNullOrEmpty()) {
            return _clearAndNavigateToLogin(err, handler);
          }
          final refreshTokenResponse =
              await safeApiCall<RefreshTokenResponseModel>(() async {
                return await _tokensManager.refreshToken(refreshToken!);
              });
          refreshTokenResponse.when(
            success: (data) async {
              _tokenStorage.saveAccessToken(token: data.access);
              _tokenStorage.saveRefreshToken(token: data.refresh);
              err.requestOptions.headers[ApiConstants.authorization] =
                  '${ApiConstants.bearer} ${data.access}';
              final cloneRequest = await _tokensManager.fetchRequestOptions(
                err.requestOptions,
              );
              return handler.resolve(cloneRequest);
            },
            failure: (error) {
              return _clearAndNavigateToLogin(err, handler);
            },
          );
        },
        failure: (error) {
          return CacheException(CacheConstants.refreshTokenReadFailed);
        },
      );
    } else {
      handler.next(err);
    }
  }

  void _clearAndNavigateToLogin(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    _tokenStorage.clearTokens();
    AppRouter.router.go(AppRoutesConstants.loginRoute);
    return handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: ErrorsConstant.sessionExpiredError,
        type: DioExceptionType.cancel,
      ),
    );
  }
}
