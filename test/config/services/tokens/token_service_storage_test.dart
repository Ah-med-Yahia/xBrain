import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/config/cache_services/flutter_secure_key_value_storage.dart';
import 'package:explaino/config/errors/local_exception.dart';
import 'package:explaino/config/services/tokens/token_service_storage.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'token_service_storage_test.mocks.dart';

@GenerateMocks([FlutterSecureKeyValueStorage])
void main() {
  late MockFlutterSecureKeyValueStorage mockSecureStorageService;
  late TokenServiceStorage tokenServiceStorage;

  setUp(() {
    mockSecureStorageService = MockFlutterSecureKeyValueStorage();
    tokenServiceStorage = TokenServiceStorage(mockSecureStorageService);
  });

  group('saveTokens', () {
    test('should save tokens successfully', () async {
      when(
        mockSecureStorageService.write(any, any, any),
      ).thenAnswer((_) async => const BaseResponse.success(null));
      final result = await tokenServiceStorage.saveTokens(
        accessToken: 'accessToken',
        refreshToken: 'refreshToken',
      );
      expect(result, isA<Success<bool>>());
    });

    test('should return failure if write fails', () async {
      when(
        mockSecureStorageService.write(any, any, any),
      ).thenAnswer((_) async => BaseResponse.failure(CacheException('error')));
      final result = await tokenServiceStorage.saveTokens(
        accessToken: 'accessToken',
        refreshToken: 'refreshToken',
      );
      expect(result, isA<Failure<bool>>());
    });
  });

  group('saveAccessToken', () {
    test('should save access token successfully', () async {
      when(
        mockSecureStorageService.write(any, any, any),
      ).thenAnswer((_) async => const BaseResponse.success(null));
      final result = await tokenServiceStorage.saveAccessToken(
        token: 'accessToken',
      );
      expect(result, isA<Success<bool>>());
    });

    test('should return failure if write fails', () async {
      when(
        mockSecureStorageService.write(any, any, any),
      ).thenAnswer((_) async => BaseResponse.failure(CacheException('error')));
      final result = await tokenServiceStorage.saveAccessToken(
        token: 'accessToken',
      );
      expect(result, isA<Failure<bool>>());
    });
  });

  group('saveRefreshToken', () {
    test('should save refresh token successfully', () async {
      when(
        mockSecureStorageService.write(any, any, any),
      ).thenAnswer((_) async => const BaseResponse.success(null));
      final result = await tokenServiceStorage.saveRefreshToken(
        token: 'refreshToken',
      );
      expect(result, isA<Success<bool>>());
    });

    test('should return failure if write fails', () async {
      when(
        mockSecureStorageService.write(any, any, any),
      ).thenAnswer((_) async => BaseResponse.failure(CacheException('error')));
      final result = await tokenServiceStorage.saveRefreshToken(
        token: 'refreshToken',
      );
      expect(result, isA<Failure<bool>>());
    });
  });

  group('getAccessToken', () {
    test('should get access token successfully', () async {
      when(mockSecureStorageService.read(any, any)).thenAnswer(
        (_) async => const BaseResponse<String?>.success('accessToken'),
      );
      final result = await tokenServiceStorage.getAccessToken();
      expect(result, isA<Success<String?>>());
    });

    test('should return failure if read fails', () async {
      when(mockSecureStorageService.read(any, any)).thenAnswer(
        (_) async => BaseResponse<String?>.failure(CacheException('error')),
      );
      final result = await tokenServiceStorage.getAccessToken();
      expect(result, isA<Failure<String?>>());
    });
  });

  group('getRefreshToken', () {
    test('should get refresh token successfully', () async {
      when(mockSecureStorageService.read(any, any)).thenAnswer(
        (_) async => const BaseResponse<String?>.success('refreshToken'),
      );
      final result = await tokenServiceStorage.getRefreshToken();
      expect(result, isA<Success<String?>>());
    });

    test('should return failure if read fails', () async {
      when(mockSecureStorageService.read(any, any)).thenAnswer(
        (_) async => BaseResponse<String?>.failure(CacheException('error')),
      );
      final result = await tokenServiceStorage.getRefreshToken();
      expect(result, isA<Failure<String?>>());
    });
  });

  group('clearTokens', () {
    test('should clear tokens successfully', () async {
      when(
        mockSecureStorageService.delete(any),
      ).thenAnswer((_) async => const BaseResponse<void>.success(null));
      final result = await tokenServiceStorage.clearTokens();
      expect(result, isA<Success<void>>());
    });

    test('should return failure if delete fails', () async {
      when(mockSecureStorageService.delete(any)).thenAnswer(
        (_) async => BaseResponse<void>.failure(CacheException('error')),
      );
      final result = await tokenServiceStorage.clearTokens();
      expect(result, isA<Failure<void>>());
    });
  });
}
