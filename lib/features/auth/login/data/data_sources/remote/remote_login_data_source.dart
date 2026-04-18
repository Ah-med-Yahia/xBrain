import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/data/models/auth/auth_response_model/auth_response_model.dart';
import 'package:explaino/features/auth/login/data/models/login_request_model.dart';

abstract interface class RemoteLoginDataSource {
  Future<BaseResponse<AuthResponseModel>> login(LoginRequestModel request);
}
