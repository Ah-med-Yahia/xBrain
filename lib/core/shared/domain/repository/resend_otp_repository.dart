import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/data/models/otp/resend_otp_request_model/resend_otp_request_model.dart';

abstract interface class ResendOtpRepository {
  Future<BaseResponse<String>> resendOtp(ResendOtpRequestModel request);
}
