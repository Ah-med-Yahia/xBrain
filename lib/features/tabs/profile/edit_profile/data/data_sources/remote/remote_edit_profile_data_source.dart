import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/data/models/auth/user_model/user_model.dart';
import 'package:explaino/features/tabs/profile/edit_profile/data/models/request/edit_profile_request_model.dart';

abstract interface class RemoteEditProfileDataSource {
  Future<BaseResponse<UserModel>> editProfile(EditProfileRequestModel request);
}
