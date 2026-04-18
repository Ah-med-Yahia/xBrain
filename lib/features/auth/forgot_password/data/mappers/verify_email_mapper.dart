import 'package:explaino/features/auth/forgot_password/data/models/response/verify_email_models/verify_email_response_model.dart';
import 'package:explaino/features/auth/forgot_password/domain/entities/response/verify_email_response_entity.dart';

extension VerifyEmailMapper on VerifyEmailResponseModel {
  VerifyEmailResponseEntity toEntity() {
    return VerifyEmailResponseEntity(email: email, resetToken: resetToken);
  }
}
