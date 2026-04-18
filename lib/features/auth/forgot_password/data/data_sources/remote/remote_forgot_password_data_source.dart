import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/data/models/auth/message_response.dart';
import 'package:explaino/core/shared/data/models/auth/otp/otp_response_model/otp_response_model.dart';
import 'package:explaino/core/shared/data/models/auth/otp/verify_otp_request_model/verify_otp_request_model.dart';
import 'package:explaino/features/auth/forgot_password/data/models/reset_password_request_model.dart';
import 'package:explaino/features/auth/forgot_password/data/models/send_otp_code_models/forgot_password_request_model.dart';
import 'package:explaino/features/auth/forgot_password/data/models/verify_email_models/verify_email_response_model.dart';

abstract interface class RemoteForgotPasswordDataSource {
  Future<BaseResponse<OtpResponseModel>> forgetPassword(
    ForgotPasswordRequestModel request,
  );
  Future<BaseResponse<VerifyEmailResponseModel>> verifyEmailOtp(
    VerifyOtpRequestModel request,
  );
  Future<BaseResponse<MessageResponse>> resetPassword(
    ResetPasswordRequestModel request,
  );
}
