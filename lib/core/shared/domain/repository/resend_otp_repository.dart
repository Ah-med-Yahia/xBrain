import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/domain/entities/otp/resend_otp_request_entity.dart';

abstract interface class ResendOtpRepository {
  Future<BaseResponse<String>> resendOtp(ResendOtpRequestEntity request);
}
