import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/config/errors/api_exception.dart';
import 'package:explaino/core/shared/data/data_sources/remote/auth/resend_otp_remote_data_source.dart';
import 'package:explaino/core/shared/data/models/auth/otp/otp_response_model/otp_response_model.dart';
import 'package:explaino/core/shared/data/repository/auth/resend_otp_repository_impl.dart';
import 'package:explaino/core/shared/domain/entities/auth/otp/resend_otp_request_entity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'resend_otp_repository_impl_test.mocks.dart';

@GenerateMocks([ResendOtpRemoteDataSource])
void main() {
  late ResendOtpRepositoryImpl resendOtpRepositoryImpl;
  late MockResendOtpRemoteDataSource mockResendOtpRemoteDataSource;
  final OtpResponseModel otpResponseModel = OtpResponseModel(
    message: 'OTP sent successfully',
    email: 'test@example.com',
  );
  final ResendOtpRequestEntity request = ResendOtpRequestEntity(
    email: 'test@example.com',
  );

  setUp(() {
    mockResendOtpRemoteDataSource = MockResendOtpRemoteDataSource();
    resendOtpRepositoryImpl = ResendOtpRepositoryImpl(
      mockResendOtpRemoteDataSource,
    );
  });

  group('resend otp repository impl', () {
    test('success resend otp', () async {
      when(mockResendOtpRemoteDataSource.resendOtp(any)).thenAnswer(
        (_) async => BaseResponse<OtpResponseModel>.success(otpResponseModel),
      );
      final result = await resendOtpRepositoryImpl.resendOtp(request);
      expect(result, Success<String>(otpResponseModel.message));
    });

    test('failure resend otp', () async {
      when(mockResendOtpRemoteDataSource.resendOtp(any)).thenAnswer(
        (_) async => BaseResponse<OtpResponseModel>.failure(
          ApiException('Failed to resend OTP'),
        ),
      );
      final result = await resendOtpRepositoryImpl.resendOtp(request);
      expect(result, isA<Failure<String>>());
    });
  });
}
