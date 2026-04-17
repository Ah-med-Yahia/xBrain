import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/data/models/otp/otp_response_model/otp_response_model.dart';
import 'package:explaino/core/shared/data/models/otp/verify_otp_request_model/verify_otp_request_model.dart';
import 'package:explaino/core/shared/domain/entities/message_entity.dart';
import 'package:explaino/features/auth/forgot_password/data/models/reset_password_request_model.dart';
import 'package:explaino/features/auth/forgot_password/data/models/send_otp_code_models/forgot_password_request_model.dart';
import 'package:explaino/features/auth/forgot_password/domain/entities/verify_email_entitt.dart';

abstract interface class ForgotPasswordRepo {
  Future<BaseResponse<OtpResponseModel>> forgetPassword(
    ForgotPasswordRequestModel request,
  );

  Future<BaseResponse<VerifyEmailEntity>> verifyEmailOtp(
    VerifyOtpRequestModel request,
  );
  Future<BaseResponse<MessageEntity>> resetPassword(
    ResetPasswordRequestModel request,
  );
}
