import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/domain/entities/auth/otp/verify_otp_request_entity.dart';
import 'package:explaino/features/auth/forgot_password/domain/entities/response/verify_email_response_entity.dart';
import 'package:explaino/features/auth/forgot_password/domain/repositories/forgot_password_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class VerifyOtpUseCase {
  final ForgotPasswordRepo _repo;

  VerifyOtpUseCase(this._repo);

  Future<BaseResponse<VerifyEmailResponseEntity>> call(
    VerifyOtpRequestEntity params,
  ) {
    return _repo.verifyEmailOtp(params);
  }
}
