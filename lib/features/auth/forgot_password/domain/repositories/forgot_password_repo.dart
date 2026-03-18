import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/domain/entities/message_entity.dart';
import 'package:explaino/features/auth/forgot_password/data/models/send_otp_code_models/forgot_password_request_model.dart';

abstract interface class ForgotPasswordRepo {
  Future<BaseResponse<MessageEntity>> forgetPassword(
    ForgotPasswordRequestModel request,
  );
}
