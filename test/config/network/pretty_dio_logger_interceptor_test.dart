import 'package:dio/dio.dart';
import 'package:explaino/config/network/pretty_dio_logger_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:test/test.dart';

void main() {
  test('LoggerInterceptor redacts Authorization header', () {
    final logs = <String>[];
    debugPrint = (String? message, {int? wrapWidth}) {
      if (message != null) logs.add(message);
    };
    final interceptor = PrettyDioLoggerInterceptor();
    final requestOptions = RequestOptions(
      path: '/test',
      headers: {'Authorization': 'Bearer my-secret-token'},
    );
    final handler = RequestInterceptorHandler();
    interceptor.onRequest(requestOptions, handler);
    expect(logs.any((log) => log.contains('[REDACTED]')), true);
  });
}
