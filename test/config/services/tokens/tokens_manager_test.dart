import 'package:dio/dio.dart';
import 'package:explaino/config/services/tokens/tokens_manager.dart';
import 'package:explaino/core/constants/api_constants.dart';
import 'package:explaino/core/shared/data/models/refresh_token_response_model/refresh_token_response_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'tokens_manager_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late TokensManager tokensManager;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    tokensManager = TokensManager(mockDio);
  });

  group('refreshToken', () {
    test(
      'should return RefreshTokenResponseModel when API call is successful',
      () async {
        const refreshToken = 'test_refresh_token';
        final responseData = {
          'access': 'new_access_token',
          'refresh': 'new_refresh_token',
        };
        final response = Response<dynamic>(
          requestOptions: RequestOptions(path: ''),
          data: responseData,
        );
        when(
          mockDio.post(
            ApiConstants.refreshToken,
            data: {ApiConstants.refreshTokenKey: refreshToken},
          ),
        ).thenAnswer((_) async => response);

        final result = await tokensManager.refreshToken(refreshToken);

        expect(result, isA<RefreshTokenResponseModel>());
        expect(result.access, 'new_access_token');
        expect(result.refresh, 'new_refresh_token');
        verify(
          mockDio.post(
            ApiConstants.refreshToken,
            data: {ApiConstants.refreshTokenKey: refreshToken},
          ),
        ).called(1);
      },
    );

    test('should throw DioException when API call fails', () async {
      const refreshToken = 'test_refresh_token';
      when(
        mockDio.post(
          ApiConstants.refreshToken,
          data: {ApiConstants.refreshTokenKey: refreshToken},
        ),
      ).thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      expect(
        () => tokensManager.refreshToken(refreshToken),
        throwsA(isA<DioException>()),
      );
      verify(
        mockDio.post(
          ApiConstants.refreshToken,
          data: {ApiConstants.refreshTokenKey: refreshToken},
        ),
      ).called(1);
    });
  });

  group('fetchRequestOptions', () {
    test('should fetch request options successfully', () async {
      final requestOptions = RequestOptions(path: '/test');
      final responseData = {'data': 'test_data'};
      final response = Response<dynamic>(
        requestOptions: requestOptions,
        data: responseData,
      );
      when(mockDio.fetch(requestOptions)).thenAnswer((_) async => response);

      final result = await tokensManager.fetchRequestOptions(requestOptions);

      expect(result, isA<Response<dynamic>>());
      expect(result.data, responseData);
      verify(mockDio.fetch(requestOptions)).called(1);
    });

    test('should throw DioException when fetch fails', () async {
      final requestOptions = RequestOptions(path: '/test');
      when(
        mockDio.fetch(requestOptions),
      ).thenThrow(DioException(requestOptions: requestOptions));

      expect(
        () => tokensManager.fetchRequestOptions(requestOptions),
        throwsA(isA<DioException>()),
      );
      verify(mockDio.fetch(requestOptions)).called(1);
    });
  });
}
