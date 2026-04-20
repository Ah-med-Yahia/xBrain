import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/data/models/auth/otp/otp_response_model/otp_response_model.dart';
import 'package:explaino/features/auth/forgot_password/domain/entities/request/forgot_password_request_entity.dart';
import 'package:explaino/features/auth/forgot_password/domain/repositories/forgot_password_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SendResetCodeUseCase {
  final ForgotPasswordRepo _repo;

  SendResetCodeUseCase(this._repo);
  Future<BaseResponse<OtpResponseModel>> call(
    ForgotPasswordRequestEntity params,
  ) {
    return _repo.forgetPassword(params);
  }
}
