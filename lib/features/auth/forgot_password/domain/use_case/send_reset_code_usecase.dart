import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/domain/entities/message_entity.dart';
import 'package:explaino/features/auth/forgot_password/data/models/send_otp_code_models/forgot_password_request_model.dart';
import 'package:explaino/features/auth/forgot_password/domain/repositories/forgot_password_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SendResetCodeUseCase {
  final ForgotPasswordRepo _repo;

  SendResetCodeUseCase(this._repo);
  Future<BaseResponse<MessageEntity>> call(ForgotPasswordRequestModel params) {
    return _repo.forgetPassword(params);
  }
}
