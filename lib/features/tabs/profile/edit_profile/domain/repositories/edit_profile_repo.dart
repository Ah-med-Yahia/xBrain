import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/domain/entities/auth/user_entity/user_entity.dart';
import 'package:explaino/features/tabs/profile/edit_profile/data/models/request/edit_profile_request_model.dart';

abstract interface class EditProfileRepo {
  Future<BaseResponse<UserEntity>> editProfile(EditProfileRequestModel request);
}
