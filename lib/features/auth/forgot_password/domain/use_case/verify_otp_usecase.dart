import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/data/models/auth/otp/verify_otp_request_model/verify_otp_request_model.dart';
import 'package:explaino/features/auth/forgot_password/domain/entities/verify_email_entitt.dart';
import 'package:explaino/features/auth/forgot_password/domain/repositories/forgot_password_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class VerifyOtpUseCase {
  final ForgotPasswordRepo _repo;

  VerifyOtpUseCase(this._repo);

  Future<BaseResponse<VerifyEmailEntity>> call(VerifyOtpRequestModel params) {
    return _repo.verifyEmailOtp(params);
  }
}
