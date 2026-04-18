import 'package:explaino/core/shared/data/models/auth/otp/verify_otp_request_model/verify_otp_request_model.dart';
import 'package:explaino/features/auth/forgot_password/data/models/reset_password_request_model.dart';
import 'package:explaino/features/auth/forgot_password/data/models/send_otp_code_models/forgot_password_request_model.dart';

sealed class ForgotPasswordIntent {}

class SendResetCodeIntent extends ForgotPasswordIntent {
  final ForgotPasswordRequestModel forgotPasswordRequestModel;
  SendResetCodeIntent({required this.forgotPasswordRequestModel});
}

class VerifyOtpCodeIntent extends ForgotPasswordIntent {
  final VerifyOtpRequestModel verifyOtpRequestModel;
  VerifyOtpCodeIntent({required this.verifyOtpRequestModel});
}

class ResetPasswordIntent extends ForgotPasswordIntent {
  final ResetPasswordRequestModel resetPasswordRequestModel;
  ResetPasswordIntent({required this.resetPasswordRequestModel});
}

class ResendOtpCodeIntent extends ForgotPasswordIntent {
  final ForgotPasswordRequestModel forgotPasswordRequestModel;
  ResendOtpCodeIntent({required this.forgotPasswordRequestModel});
}

class TogglePasswordVisibilityIntent extends ForgotPasswordIntent {}

class ToggleConfirmPasswordVisibilityIntent extends ForgotPasswordIntent {}
