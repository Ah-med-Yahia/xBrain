import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/auth/forgot_password/data/models/send_otp_code_models/forgot_password_request_model.dart';
import 'package:explaino/features/auth/forgot_password/data/models/send_otp_code_models/forgot_password_response_model.dart';

abstract interface class RemoteForgotPasswordDataSource {
  Future<BaseResponse<ForgotPasswordResponseModel>> forgetPassword(
    ForgotPasswordRequestModel request,
  );
}
