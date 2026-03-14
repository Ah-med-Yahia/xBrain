import 'package:dio/dio.dart';
import 'package:explaino/config/errors/api_exception.dart';
import 'package:explaino/config/errors/exceptions_handler.dart';
import 'package:explaino/config/errors/local_exception.dart';
import 'package:explaino/core/constants/errors_constants.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test DioException', () {
    final dioException = DioException(
      requestOptions: RequestOptions(),
      type: DioExceptionType.connectionTimeout,
    );

    final exception = ExceptionsHandler.handle(dioException);
    expect(exception, isA<ApiException>());
    expect(exception.message, ErrorsConstant.connectionTimeoutError);
  });

  test('LocalException', () {
    final localException = CacheException('Local error');
    final exception = ExceptionsHandler.handle(localException);
    expect(exception, isA<CacheException>());
    expect(exception.message, 'Local error');
  });

  test('UnknownException', () {
    final unknownException = Exception();
    final exception = ExceptionsHandler.handle(unknownException);
    expect(exception, isA<ApiException>());
    expect(exception.message, ErrorsConstant.defaultError);
  });
}
