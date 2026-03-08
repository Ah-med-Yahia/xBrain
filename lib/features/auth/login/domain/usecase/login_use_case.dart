import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/domain/entities/message_entity.dart';
import 'package:explaino/features/auth/login/data/models/login_request_model.dart';
import 'package:explaino/features/auth/login/domain/repositories/login_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  final LoginRepo repo;

  LoginUseCase(this.repo);
  Future<BaseResponse<MessageEntity>> call(LoginRequestModel request) {
    return repo.login(request);
  }
}
