import 'package:explaino/features/auth/forgot_password/data/models/verify_email_models/verify_email_response_model.dart';
import 'package:explaino/features/auth/forgot_password/domain/entities/verify_email_entitt.dart';

extension VerifyEmailMapper on VerifyEmailResponseModel {
  VerifyEmailEntity toEntity() {
    return VerifyEmailEntity(email: email, resetToken: resetToken);
  }
}
