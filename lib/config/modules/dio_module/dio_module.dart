import 'package:dio/dio.dart';
import 'package:explaino/config/modules/dio_module/auth_interceptor.dart';
import 'package:explaino/config/modules/dio_module/logger_interceptor.dart';
import 'package:explaino/core/constants/api_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DioModule {
  @singleton
  Dio dio(
    AuthInterceptor authInterceptor,
    LoggerInterceptor loggerInterceptor,
  ) {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      ),
    );
    dio.interceptors.add(authInterceptor);
    if (kDebugMode) {
      dio.interceptors.add(loggerInterceptor);
    }
    return dio;
  }
}
