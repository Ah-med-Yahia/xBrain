import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/config/network/safe_api_call.dart';
import 'package:explaino/core/shared/data/models/auth/user_model/user_model.dart';
import 'package:explaino/features/tabs/profile/edit_profile/api/api_clients/edit_profile_api_client.dart';
import 'package:explaino/features/tabs/profile/edit_profile/data/data_sources/remote/remote_edit_profile_data_source.dart';
import 'package:explaino/features/tabs/profile/edit_profile/data/models/request/edit_profile_request_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RemoteEditProfileDataSource)
class RemoteEditProfileDataSourceImple implements RemoteEditProfileDataSource {
  final EditProfileApiClient _apiClient;

  RemoteEditProfileDataSourceImple(this._apiClient);

  @override
  Future<BaseResponse<UserModel>> editProfile(EditProfileRequestModel request) {
    return safeApiCall(
      () async => _apiClient.updateProfile(await request.toFormData()),
    );
  }
}
