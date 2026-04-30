import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/data/models/auth/user_model/user_model.dart';
import 'package:explaino/features/tabs/profile/edit_profile/data/data_sources/remote/remote_edit_profile_data_source.dart';
import 'package:explaino/features/tabs/profile/edit_profile/data/models/request/edit_profile_request_model.dart';
import 'package:explaino/features/tabs/profile/edit_profile/domain/repositories/edit_profile_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: EditProfileRepo)
class EditProfileRepoImple implements EditProfileRepo {
  final RemoteEditProfileDataSource remoteEditProfileDataSource;

  EditProfileRepoImple({required this.remoteEditProfileDataSource});

  @override
  Future<BaseResponse<UserModel>> editProfile(
    EditProfileRequestModel request,
  ) async {
    final result = await remoteEditProfileDataSource.editProfile(request);
    return result.when(
      success: (data) {
        return BaseResponse<UserModel>.success(data);
      },
      failure: (error) {
        return BaseResponse<UserModel>.failure(error);
      },
    );
  }
}
