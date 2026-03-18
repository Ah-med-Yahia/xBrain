import 'package:explaino/features/auth/forgot_password/data/models/send_otp_code_models/forgot_password_request_model.dart';

sealed class ForgotPasswordIntent {}

class SendResetCodeIntent extends ForgotPasswordIntent {
  final ForgotPasswordRequestModel forgotPasswordRequestModel;

  SendResetCodeIntent({required this.forgotPasswordRequestModel});
}
