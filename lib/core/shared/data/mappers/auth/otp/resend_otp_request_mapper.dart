import 'package:explaino/core/shared/data/models/auth/otp/resend_otp_request_model/resend_otp_request_model.dart';
import 'package:explaino/core/shared/domain/entities/auth/otp/resend_otp_request_entity.dart';

extension ResendOtpRequestMapper on ResendOtpRequestEntity {
  ResendOtpRequestModel toModel() {
    return ResendOtpRequestModel(email: email);
  }
}
