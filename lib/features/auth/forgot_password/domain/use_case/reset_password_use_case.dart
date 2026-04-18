import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/domain/entities/auth/message_entity.dart';
import 'package:explaino/features/auth/forgot_password/data/models/reset_password_request_model.dart';
import 'package:explaino/features/auth/forgot_password/domain/repositories/forgot_password_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetPasswordUseCase {
  final ForgotPasswordRepo _repo;

  ResetPasswordUseCase(this._repo);

  Future<BaseResponse<MessageEntity>> call(ResetPasswordRequestModel params) {
    return _repo.resetPassword(params);
  }
}
