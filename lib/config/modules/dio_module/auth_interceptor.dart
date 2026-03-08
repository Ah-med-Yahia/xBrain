import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/config/network/session_manager.dart';
import 'package:explaino/config/services/token_service.dart';
import 'package:explaino/core/constants/cache_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthInterceptor extends Interceptor {
  final TokenService _tokenService;
  final SessionManager _sessionManager;

  AuthInterceptor(this._tokenService, this._sessionManager);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final tokenResponse = await _tokenService.getToken();

    tokenResponse.when(
      success: (token) {
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
          options.headers[CacheConstants.token] = token;
        }
      },
      failure: (error) {
        if (kDebugMode) {}
      },
    );

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      _clearExpiredToken();
      _sessionManager.notifySessionExpired(
        message: 'Your session has expired. Please login again.',
      );
      if (kDebugMode) {
        log('401 Unauthorized - Session expired');
      }

      return handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          error: 'Session expired',
          type: DioExceptionType.cancel,
        ),
      );
    }
    handler.next(err);
  }

  Future<void> _clearExpiredToken() async {
    try {
      await _tokenService.clearToken();
      // await _tokenService.writeBool(StorageKeys.isLoggedIn, false);

      if (kDebugMode) {
        log('Auth tokens cleared due to session expiration');
      }
    } catch (e) {
      if (kDebugMode) {
        log('Failed to clear expired token', error: e);
      }
    }
  }
}
