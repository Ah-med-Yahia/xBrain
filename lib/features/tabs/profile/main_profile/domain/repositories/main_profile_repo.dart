import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/domain/entities/auth/user_entity/user_entity.dart';

abstract interface class MainProfileRepository {
  Future<BaseResponse<UserEntity>> getProfile();
}
