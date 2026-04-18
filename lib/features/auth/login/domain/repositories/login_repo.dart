import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/domain/entities/auth/message_entity.dart';
import 'package:explaino/features/auth/login/domain/entities/request/login_request_entity.dart';

abstract interface class LoginRepo {
  Future<BaseResponse<MessageEntity>> login(LoginRequestEntity request);
}
