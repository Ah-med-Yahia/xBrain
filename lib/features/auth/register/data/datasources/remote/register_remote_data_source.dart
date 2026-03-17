import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/data/models/auth_response_model/auth_response_model.dart';
import 'package:explaino/core/shared/data/models/otp_response_model/otp_response_model.dart';
import 'package:explaino/core/shared/data/models/resend_otp_request_model/resend_otp_request_model.dart';
import 'package:explaino/features/auth/register/data/models/request/register_request_model/register_request_model.dart';
import 'package:explaino/features/auth/register/data/models/request/verify_email_request_model/verify_email_request_model.dart';

abstract  interface class RegisterRemoteDataSource {
  Future<BaseResponse<OtpResponseModel>> sendOtp(RegisterRequestModel request);
  Future<BaseResponse<OtpResponseModel>> resendOtp(ResendOtpRequestModel request);
  Future<BaseResponse<AuthResponseModel>> verifyEmailAndRegister(
    VerifyEmailRequestModel request,
  );
}