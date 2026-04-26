import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/data/models/auth/user_model/user_model.dart';

abstract interface class RemoteMainProfileDataSource {
  Future<BaseResponse<UserModel>> getProfile();
}
