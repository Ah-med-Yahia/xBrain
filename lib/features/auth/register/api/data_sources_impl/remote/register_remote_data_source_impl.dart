import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/config/network/safe_api_call.dart';
import 'package:explaino/core/shared/api/api_clients/resend_otp_api_client.dart';
import 'package:explaino/core/shared/data/models/auth_response_model/auth_response_model.dart';
import 'package:explaino/core/shared/data/models/otp_response_model/otp_response_model.dart';
import 'package:explaino/core/shared/data/models/resend_otp_request_model/resend_otp_request_model.dart';
import 'package:explaino/features/auth/register/api/api_clients/register_api_client.dart';
import 'package:explaino/features/auth/register/data/datasources/remote/register_remote_data_source.dart';
import 'package:explaino/features/auth/register/data/models/request/register_request_model/register_request_model.dart';
import 'package:explaino/features/auth/register/data/models/request/verify_email_request_model/verify_email_request_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: RegisterRemoteDataSource)
class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {
  final ResendOtpApiClient _resendOtpApiClient;
  final RegisterApiClient _registerApiClient;

  RegisterRemoteDataSourceImpl(
    this._resendOtpApiClient,
    this._registerApiClient,
  );

  @override
  Future<BaseResponse<OtpResponseModel>> sendOtp(RegisterRequestModel request) {
    return safeApiCall(() => _registerApiClient.sendOtp(request));
  }

  @override
  Future<BaseResponse<OtpResponseModel>> resendOtp(
    ResendOtpRequestModel request,
  ) {
    return safeApiCall(() => _resendOtpApiClient.resendOtp(request));
  }

  @override
  Future<BaseResponse<AuthResponseModel>> verifyEmailAndRegister(
    VerifyEmailRequestModel request,
  ) {
    return safeApiCall(
      () => _registerApiClient.verifyEmailAndRegister(request),
    );
  }
}
