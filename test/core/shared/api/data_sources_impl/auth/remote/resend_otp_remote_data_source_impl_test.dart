import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/api/api_clients/auth/resend_otp_api_client.dart';
import 'package:explaino/core/shared/api/data_sources_impl/remote/auth/resend_otp_remote_data_source_impl.dart';
import 'package:explaino/core/shared/data/models/auth/otp/otp_response_model/otp_response_model.dart';
import 'package:explaino/core/shared/data/models/auth/otp/resend_otp_request_model/resend_otp_request_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'resend_otp_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ResendOtpApiClient])
void main() {
  late MockResendOtpApiClient mockResendOtpApiClient;
  late ResendOtpRemoteDataSourceImpl resendOtpRemoteDataSourceImpl;
  final request = ResendOtpRequestModel(email: 'test@example.com');
  final response = OtpResponseModel(
    email: 'test@example.com',
    message: 'OTP sent successfully',
  );
  setUp(() {
    mockResendOtpApiClient = MockResendOtpApiClient();
    resendOtpRemoteDataSourceImpl = ResendOtpRemoteDataSourceImpl(
      mockResendOtpApiClient,
    );
  });

  group('resendOtp', () {
    test(
      'should return BaseResponse<OtpResponseModel> when the API call is successful',
      () async {
        when(
          mockResendOtpApiClient.resendOtp(request),
        ).thenAnswer((_) async => response);

        final result = await resendOtpRemoteDataSourceImpl.resendOtp(request);

        expect(result, isA<Success<OtpResponseModel>>());
        final successResult = result as Success<OtpResponseModel>;
        expect(successResult.data, response);
      },
    );

    test('should fail when the API call is failed', () async {
      when(
        mockResendOtpApiClient.resendOtp(request),
      ).thenThrow(Exception('Failed to resend OTP'));

      final result = await resendOtpRemoteDataSourceImpl.resendOtp(request);

      expect(result, isA<Failure<OtpResponseModel>>());
    });
  });
}
