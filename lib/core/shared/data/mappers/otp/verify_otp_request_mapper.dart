import 'package:explaino/core/shared/data/models/otp/verify_otp_request_model/verify_otp_request_model.dart';
import 'package:explaino/core/shared/domain/entities/otp/verify_otp_request_entity.dart';

extension VerifyOtpRequestMapper on VerifyOtpRequestEntity {
  VerifyOtpRequestModel toModel() {
    return VerifyOtpRequestModel(email: email, otp: otp);
  }
}
