import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/domain/entities/auth/message_entity.dart';
import 'package:explaino/features/auth/login/domain/entities/request/login_request_entity.dart';
import 'package:explaino/features/auth/login/domain/repositories/login_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  final LoginRepo repo;

  LoginUseCase(this.repo);
  Future<BaseResponse<MessageEntity>> call(LoginRequestEntity request) {
    return repo.login(request);
  }
}
