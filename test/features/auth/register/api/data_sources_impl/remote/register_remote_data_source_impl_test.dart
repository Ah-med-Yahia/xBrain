import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/api/api_clients/resend_otp_api_client.dart';
import 'package:explaino/core/shared/data/models/auth_response_model/auth_response_model.dart';
import 'package:explaino/core/shared/data/models/otp/otp_response_model/otp_response_model.dart';
import 'package:explaino/core/shared/data/models/otp/resend_otp_request_model/resend_otp_request_model.dart';
import 'package:explaino/features/auth/register/api/api_clients/register_api_client.dart';
import 'package:explaino/features/auth/register/api/data_sources_impl/remote/register_remote_data_source_impl.dart';
import 'package:explaino/features/auth/register/data/models/request/register_request_model/register_request_model.dart';
import 'package:explaino/core/shared/data/models/otp/verify_otp_request_model/verify_otp_request_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'register_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ResendOtpApiClient, RegisterApiClient, AuthResponseModel])
void main() {
  late RegisterRemoteDataSourceImpl registerRemoteDataSourceImpl;
  late MockResendOtpApiClient resendOtpApiClient;
  late MockRegisterApiClient registerApiClient;

  final request = RegisterRequestModel(
    email: '',
    username: '',
    password: '',
    firstName: '',
    lastName: '',
    phoneNumber: '',
  );

  final resendOtpRequest = ResendOtpRequestModel(email: '');

  final verifyEmailRequest = VerifyOtpRequestModel(email: '', otp: '');

  final response = OtpResponseModel(
    email: 'test@example.com',
    message: 'OTP sent successfully',
  );

  final authResponse = MockAuthResponseModel();

  setUp(() {
    resendOtpApiClient = MockResendOtpApiClient();
    registerApiClient = MockRegisterApiClient();
    registerRemoteDataSourceImpl = RegisterRemoteDataSourceImpl(
      resendOtpApiClient,
      registerApiClient,
    );
  });

  group('sendOtp', () {
    test(
      'should return OtpResponseModel when api call is successful',
      () async {
        when(
          registerApiClient.sendOtp(request),
        ).thenAnswer((_) async => response);

        final result = await registerRemoteDataSourceImpl.sendOtp(request);

        expect(result, isA<Success<OtpResponseModel>>());
        result as Success<OtpResponseModel>;
        expect(result.data, response);
      },
    );

    test('should return Failure when api call is unsuccessful', () async {
      when(
        registerApiClient.sendOtp(request),
      ).thenThrow(Exception('Failed to send OTP'));

      final result = await registerRemoteDataSourceImpl.sendOtp(request);

      expect(result, isA<Failure<OtpResponseModel>>());
    });
  });

  group('resendOtp', () {
    test(
      'should return OtpResponseModel when api call is successful',
      () async {
        when(
          resendOtpApiClient.resendOtp(resendOtpRequest),
        ).thenAnswer((_) async => response);

        final result = await registerRemoteDataSourceImpl.resendOtp(
          resendOtpRequest,
        );

        expect(result, isA<Success<OtpResponseModel>>());
        result as Success<OtpResponseModel>;
        expect(result.data, response);
      },
    );

    test('should return Failure when api call is unsuccessful', () async {
      when(
        resendOtpApiClient.resendOtp(resendOtpRequest),
      ).thenThrow(Exception('Failed to resend OTP'));

      final result = await registerRemoteDataSourceImpl.resendOtp(
        resendOtpRequest,
      );

      expect(result, isA<Failure<OtpResponseModel>>());
    });
  });

  group('verifyEmailAndRegister', () {
    test(
      'should return AuthResponseModel when api call is successful',
      () async {
        when(
          registerApiClient.verifyEmailAndRegister(verifyEmailRequest),
        ).thenAnswer((_) async => authResponse);

        final result = await registerRemoteDataSourceImpl
            .verifyEmailAndRegister(verifyEmailRequest);

        expect(result, isA<Success<AuthResponseModel>>());
      },
    );

    test('should return Failure when api call is unsuccessful', () async {
      when(
        registerApiClient.verifyEmailAndRegister(verifyEmailRequest),
      ).thenThrow(Exception('Failed to verify email and register'));

      final result = await registerRemoteDataSourceImpl.verifyEmailAndRegister(
        verifyEmailRequest,
      );

      expect(result, isA<Failure<AuthResponseModel>>());
    });
  });
}
