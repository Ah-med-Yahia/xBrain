import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/domain/entities/otp/resend_otp_request_entity.dart';
import 'package:explaino/core/shared/domain/repository/resend_otp_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ResendOtpUseCase {
  final ResendOtpRepository _resendOtpRepository;
  const ResendOtpUseCase(this._resendOtpRepository);
  Future<BaseResponse<String>> call(ResendOtpRequestEntity request) async {
    return await _resendOtpRepository.resendOtp(request);
  }
}
