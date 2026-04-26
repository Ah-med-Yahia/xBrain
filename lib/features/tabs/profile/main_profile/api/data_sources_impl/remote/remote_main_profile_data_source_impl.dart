import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/config/network/safe_api_call.dart';
import 'package:explaino/core/shared/data/models/auth/user_model/user_model.dart';
import 'package:explaino/features/tabs/profile/main_profile/api/api_clients/main_profile_api_client.dart';
import 'package:explaino/features/tabs/profile/main_profile/data/data_sources/remote/remote_main_profile_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RemoteMainProfileDataSource)
class RemoteMainProfileDataSourceImpl implements RemoteMainProfileDataSource {
  final MainProfileApiClient _mainProfileApiClient;

  RemoteMainProfileDataSourceImpl(this._mainProfileApiClient);

  @override
  Future<BaseResponse<UserModel>> getProfile() {
    return safeApiCall(() => _mainProfileApiClient.getProfile());
  }
}
