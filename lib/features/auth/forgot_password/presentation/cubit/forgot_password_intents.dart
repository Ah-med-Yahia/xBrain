import 'package:explaino/core/shared/domain/entities/auth/otp/verify_otp_request_entity.dart';
import 'package:explaino/features/auth/forgot_password/domain/entities/request/forgot_password_request_entity.dart';
import 'package:explaino/features/auth/forgot_password/domain/entities/request/reset_password_request_entity.dart';

sealed class ForgotPasswordIntent {}

class SendResetCodeIntent extends ForgotPasswordIntent {
  final ForgotPasswordRequestEntity forgotPasswordRequestModel;
  SendResetCodeIntent({required this.forgotPasswordRequestModel});
}

class VerifyOtpCodeIntent extends ForgotPasswordIntent {
  final VerifyOtpRequestEntity verifyOtpRequestModel;
  VerifyOtpCodeIntent({required this.verifyOtpRequestModel});
}

class ResetPasswordIntent extends ForgotPasswordIntent {
  final ResetPasswordRequestEntity resetPasswordRequestModel;
  ResetPasswordIntent({required this.resetPasswordRequestModel});
}

class ResendOtpCodeIntent extends ForgotPasswordIntent {
  final ForgotPasswordRequestEntity forgotPasswordRequestModel;
  ResendOtpCodeIntent({required this.forgotPasswordRequestModel});
}

class TogglePasswordVisibilityIntent extends ForgotPasswordIntent {}

class ToggleConfirmPasswordVisibilityIntent extends ForgotPasswordIntent {}
