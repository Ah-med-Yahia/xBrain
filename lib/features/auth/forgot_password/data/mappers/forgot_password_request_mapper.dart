import 'package:explaino/features/auth/forgot_password/data/models/request/send_otp_code_models/forgot_password_request_model.dart';
import 'package:explaino/features/auth/forgot_password/domain/entities/request/forgot_password_request_entity.dart';

extension ForgotPasswordRequestMapper on ForgotPasswordRequestEntity {
  ForgotPasswordRequestModel toModel() {
    return ForgotPasswordRequestModel(email: email);
  }
}
