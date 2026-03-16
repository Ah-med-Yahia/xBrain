import 'package:dio/dio.dart';
import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/config/errors/local_exception.dart';
import 'package:explaino/config/network/auth_interceptor.dart';
import 'package:explaino/config/services/tokens/token_service_storage_contract.dart';
import 'package:explaino/config/services/tokens/tokens_manager_contract.dart';
import 'package:explaino/core/shared/data/models/refresh_token_response_model/refresh_token_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_interceptor_test.mocks.dart';

@GenerateMocks([
  TokenServiceStorageContract,
  TokensManagerContract,
  ErrorInterceptorHandler,
  RequestInterceptorHandler,
])
void main() {
  late AuthInterceptor interceptor;
  late MockTokenServiceStorageContract tokenStorage;
  late MockTokensManagerContract tokensManager;

  setUp(() {
    tokenStorage = MockTokenServiceStorageContract();
    tokensManager = MockTokensManagerContract();
    interceptor = AuthInterceptor(tokenStorage, tokensManager);
  });

  group('onRequest', () {
    late RequestOptions options;
    late MockRequestInterceptorHandler handler;

    setUp(() {
      options = RequestOptions(path: '/test');
      handler = MockRequestInterceptorHandler();

      reset(tokenStorage);
      reset(tokensManager);
      reset(handler);

      when(handler.next(any)).thenReturn(null);
      when(handler.reject(any)).thenReturn(null);
    });

    Future<void> flush() => Future.delayed(Duration.zero);

    test('should set authorization header when access token exists', () async {
      when(tokenStorage.getAccessToken()).thenAnswer(
        (_) async => const BaseResponse<String?>.success('valid_access_token'),
      );

      await interceptor.onRequest(options, handler);
      await flush();

      expect(
        options.headers['Authorization'],
        equals('Bearer valid_access_token'),
      );
      verify(handler.next(options)).called(1);
    });

    test(
      'should not set authorization header when access token is null',
      () async {
        when(
          tokenStorage.getAccessToken(),
        ).thenAnswer((_) async => const BaseResponse<String?>.success(null));

        await interceptor.onRequest(options, handler);
        await flush();

        expect(options.headers.containsKey('Authorization'), isFalse);
        verify(handler.next(options)).called(1);
      },
    );

    test(
      'should not set authorization header when access token is empty',
      () async {
        when(
          tokenStorage.getAccessToken(),
        ).thenAnswer((_) async => const BaseResponse<String?>.success(''));

        await interceptor.onRequest(options, handler);
        await flush();

        expect(options.headers.containsKey('Authorization'), isFalse);
        verify(handler.next(options)).called(1);
      },
    );

    test(
      'should call handler.next even when getAccessToken returns failure',
      () async {
        when(tokenStorage.getAccessToken()).thenAnswer(
          (_) async => BaseResponse<String?>.failure(
            CacheException('access_token_read_failed'),
          ),
        );

        await interceptor.onRequest(options, handler);
        await flush();

        expect(options.headers.containsKey('Authorization'), isFalse);
        verify(handler.next(options)).called(1);
      },
    );

    test(
      'should not override existing authorization header on failure',
      () async {
        options.headers['Authorization'] = 'Bearer old_token';

        when(tokenStorage.getAccessToken()).thenAnswer(
          (_) async => BaseResponse<String?>.failure(
            CacheException('access_token_read_failed'),
          ),
        );

        await interceptor.onRequest(options, handler);
        await flush();

        // header should remain unchanged since getAccessToken failed
        expect(options.headers['Authorization'], equals('Bearer old_token'));
        verify(handler.next(options)).called(1);
      },
    );

    test('should always call handler.next regardless of token state', () async {
      when(tokenStorage.getAccessToken()).thenAnswer(
        (_) async => const BaseResponse<String?>.success('some_token'),
      );

      await interceptor.onRequest(options, handler);
      await flush();

      verify(handler.next(options)).called(1);
      verifyNever(handler.reject(any));
    });
  });

  group('onError', () {
    late RequestOptions options;
    late MockErrorInterceptorHandler handler;

    setUp(() {
      options = RequestOptions(path: '/test');
      handler = MockErrorInterceptorHandler();

      reset(tokenStorage);
      reset(tokensManager);
      reset(handler);

      when(handler.next(any)).thenReturn(null);
      when(handler.reject(any)).thenReturn(null);
      when(handler.resolve(any)).thenReturn(null);
    });

    DioException make401() => DioException(
      type: DioExceptionType.badResponse,
      requestOptions: options,
      response: Response(requestOptions: options, statusCode: 401),
    );

    DioException makeNon401(int code) => DioException(
      type: DioExceptionType.badResponse,
      requestOptions: options,
      response: Response(requestOptions: options, statusCode: code),
    );

    Future<void> flush() => Future.delayed(Duration.zero);

    test('should call handler.next for non-401 errors (500)', () async {
      final err = makeNon401(500);

      await interceptor.onError(err, handler);

      verify(handler.next(err)).called(1);
      verifyNever(tokenStorage.getRefreshToken());
    });

    test('should call handler.next for non-401 errors (403)', () async {
      final err = makeNon401(403);

      await interceptor.onError(err, handler);

      verify(handler.next(err)).called(1);
      verifyNever(tokenStorage.getRefreshToken());
    });

    test(
      'should call handler.next when getRefreshToken returns failure',
      () async {
        final err = make401();

        when(tokenStorage.getRefreshToken()).thenAnswer(
          (_) async =>
              BaseResponse<String?>.failure(CacheException('cache_error')),
        );

        await interceptor.onError(err, handler);
        await flush();

        verify(tokenStorage.getRefreshToken()).called(1);
        verifyNever(tokensManager.refreshToken(any));
        verify(handler.next(err)).called(1);
      },
    );

    test(
      'should refresh token, save tokens, and resolve request on 401',
      () async {
        final err = make401();
        final retryResponse = Response(
          requestOptions: options,
          statusCode: 200,
          data: {'key': 'value'},
        );

        when(tokenStorage.getRefreshToken()).thenAnswer(
          (_) async =>
              const BaseResponse<String?>.success('test_refresh_token'),
        );
        when(tokensManager.refreshToken('test_refresh_token')).thenAnswer(
          (_) async => RefreshTokenResponseModel(
            access: 'new_access',
            refresh: 'new_refresh',
          ),
        );
        when(
          tokenStorage.saveAccessToken(token: 'new_access'),
        ).thenAnswer((_) async => const BaseResponse<bool>.success(true));
        when(
          tokenStorage.saveRefreshToken(token: 'new_refresh'),
        ).thenAnswer((_) async => const BaseResponse<bool>.success(true));
        when(
          tokensManager.fetchRequestOptions(any),
        ).thenAnswer((_) async => retryResponse);

        await interceptor.onError(err, handler);
        await flush();

        verify(tokenStorage.getRefreshToken()).called(1);
        verify(tokensManager.refreshToken('test_refresh_token')).called(1);
        verify(tokenStorage.saveAccessToken(token: 'new_access')).called(1);
        verify(tokenStorage.saveRefreshToken(token: 'new_refresh')).called(1);
        verify(tokensManager.fetchRequestOptions(any)).called(1);
        verify(handler.resolve(retryResponse)).called(1);
      },
    );

    test(
      'should set Bearer authorization header before retrying request',
      () async {
        final err = make401();

        when(tokenStorage.getRefreshToken()).thenAnswer(
          (_) async =>
              const BaseResponse<String?>.success('test_refresh_token'),
        );
        when(tokensManager.refreshToken('test_refresh_token')).thenAnswer(
          (_) async => RefreshTokenResponseModel(
            access: 'new_access',
            refresh: 'new_refresh',
          ),
        );
        when(
          tokenStorage.saveAccessToken(token: anyNamed('token')),
        ).thenAnswer((_) async => const BaseResponse<bool>.success(true));
        when(
          tokenStorage.saveRefreshToken(token: anyNamed('token')),
        ).thenAnswer((_) async => const BaseResponse<bool>.success(true));
        when(tokensManager.fetchRequestOptions(any)).thenAnswer(
          (_) async => Response(requestOptions: options, statusCode: 200),
        );

        await interceptor.onError(err, handler);
        await flush();

        final captured = verify(
          tokensManager.fetchRequestOptions(captureAny),
        ).captured;

        final capturedOptions = captured.first as RequestOptions;
        expect(
          capturedOptions.headers['Authorization'],
          equals('Bearer new_access'),
        );
      },
    );
  });
}
