import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/data/models/auth/user_model/user_model.dart';
import 'package:explaino/features/tabs/profile/edit_profile/data/models/request/edit_profile_request_model.dart';
import 'package:explaino/features/tabs/profile/edit_profile/domain/repositories/edit_profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditProfileUseCase {
  final EditProfileRepo _editProfileRepo;
  EditProfileUseCase({required EditProfileRepo editProfileRepo})
    : _editProfileRepo = editProfileRepo;
  Future<BaseResponse<UserModel>> call(EditProfileRequestModel request) {
    return _editProfileRepo.editProfile(request);
  }
}
