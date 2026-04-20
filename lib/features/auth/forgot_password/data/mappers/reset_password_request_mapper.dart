import 'package:explaino/features/auth/forgot_password/data/models/request/reset_password_request_model.dart';
import 'package:explaino/features/auth/forgot_password/domain/entities/request/reset_password_request_entity.dart';

extension ResetPasswordRequestMapper on ResetPasswordRequestEntity {
  ResetPasswordRequestModel toModel() {
    return ResetPasswordRequestModel(
      email: email,
      token: token,
      newPassword: newPassword,
    );
  }
}
