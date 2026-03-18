import 'package:dio/dio.dart';
import 'package:explaino/config/errors/api_exception.dart';
import 'package:explaino/config/errors/exceptions_handler.dart';
import 'package:explaino/config/errors/local_exception.dart';
import 'package:explaino/core/constants/errors_constants.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('test DioException', () {
    test('connection timeout', () {
      final dioException = DioException(
        requestOptions: RequestOptions(),
        type: DioExceptionType.connectionTimeout,
      );

      final exception = ExceptionsHandler.handle(dioException);
      expect(exception, isA<ApiException>());
      expect(exception.message, ErrorsConstant.connectionTimeoutError);
    });

    test('send timeout', () {
      final dioException = DioException(
        requestOptions: RequestOptions(),
        type: DioExceptionType.sendTimeout,
      );

      final exception = ExceptionsHandler.handle(dioException);
      expect(exception, isA<ApiException>());
      expect(exception.message, ErrorsConstant.sendTimeoutError);
    });

    test('receive timeout', () {
      final dioException = DioException(
        requestOptions: RequestOptions(),
        type: DioExceptionType.receiveTimeout,
      );

      final exception = ExceptionsHandler.handle(dioException);
      expect(exception, isA<ApiException>());
      expect(exception.message, ErrorsConstant.receiveTimeoutError);
    });

    test('bad response', () {
      final dioException = DioException(
        requestOptions: RequestOptions(),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(),
          statusCode: 404,
          data: {
            'email': ['This field is required.'],
            'username': ['This field is required.'],
            'phone_number': ['This phone number is already registered.'],
          },
        ),
      );

      final exception = ExceptionsHandler.handle(dioException);
      expect(exception, isA<ApiException>());
      expect(
        exception.message,
        'email: This field is required.\nusername: This field is required.\nphone_number: This phone number is already registered.',
      );
    });

    test('connection error', () {
      final dioException = DioException(
        requestOptions: RequestOptions(),
        type: DioExceptionType.connectionError,
      );

      final exception = ExceptionsHandler.handle(dioException);
      expect(exception, isA<ApiException>());
      expect(exception.message, ErrorsConstant.noInternetError);
    });

    test('cancel', () {
      final dioException = DioException(
        requestOptions: RequestOptions(),
        type: DioExceptionType.cancel,
      );

      final exception = ExceptionsHandler.handle(dioException);
      expect(exception, isA<ApiException>());
      expect(exception.message, ErrorsConstant.cancelError);
    });

    test('bad certificate', () {
      final dioException = DioException(
        requestOptions: RequestOptions(),
        type: DioExceptionType.badCertificate,
      );

      final exception = ExceptionsHandler.handle(dioException);
      expect(exception, isA<ApiException>());
      expect(exception.message, ErrorsConstant.badCertificateError);
    });

    test('unknown', () {
      final dioException = DioException(
        requestOptions: RequestOptions(),
        type: DioExceptionType.unknown,
      );

      final exception = ExceptionsHandler.handle(dioException);
      expect(exception, isA<ApiException>());
      expect(exception.message, ErrorsConstant.defaultError);
    });
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
