import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/domain/entities/message_entity.dart';
import 'package:explaino/features/auth/login/data/models/login_request_model.dart';

abstract interface class LoginRepo {
  Future<BaseResponse<MessageEntity>> login(LoginRequestModel request);
}
