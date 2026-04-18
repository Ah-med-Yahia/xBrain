import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/data/models/auth/otp/otp_response_model/otp_response_model.dart';
import 'package:explaino/core/shared/domain/entities/auth/message_entity.dart';
import 'package:explaino/core/shared/domain/entities/auth/otp/verify_otp_request_entity.dart';
import 'package:explaino/features/auth/forgot_password/domain/entities/request/forgot_password_request_entity.dart';
import 'package:explaino/features/auth/forgot_password/domain/entities/request/reset_password_request_entity.dart';
import 'package:explaino/features/auth/forgot_password/domain/entities/response/verify_email_response_entity.dart';

abstract interface class ForgotPasswordRepo {
  Future<BaseResponse<OtpResponseModel>> forgetPassword(
    ForgotPasswordRequestEntity request,
  );

  Future<BaseResponse<VerifyEmailResponseEntity>> verifyEmailOtp(
    VerifyOtpRequestEntity request,
  );
  Future<BaseResponse<MessageEntity>> resetPassword(
    ResetPasswordRequestEntity request,
  );
}
