import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/config/network/safe_api_call.dart';
import 'package:explaino/core/shared/data/models/auth/auth_response_model/auth_response_model.dart';
import 'package:explaino/features/auth/login/api/api_clients/login_api_client.dart';
import 'package:explaino/features/auth/login/data/data_sources/remote/remote_login_data_source.dart';
import 'package:explaino/features/auth/login/data/models/request/login_request_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RemoteLoginDataSource)
class RemoteLoginDataSourceImpl implements RemoteLoginDataSource {
  final LoginApiClient loginApiClient;
  RemoteLoginDataSourceImpl(this.loginApiClient);

  @override
  Future<BaseResponse<AuthResponseModel>> login(LoginRequestModel request) {
    return safeApiCall(() => loginApiClient.login(request));
  }
}
