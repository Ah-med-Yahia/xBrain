import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/data/models/otp/resend_otp_request_model/resend_otp_request_model.dart';
import 'package:explaino/core/shared/domain/repository/resend_otp_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ResendOtpUseCase {
  final ResendOtpRepository _resendOtpRepository;
  const ResendOtpUseCase(this._resendOtpRepository);
  Future<BaseResponse<String>> call(ResendOtpRequestModel request) async {
    return await _resendOtpRepository.resendOtp(request);
  }
}
