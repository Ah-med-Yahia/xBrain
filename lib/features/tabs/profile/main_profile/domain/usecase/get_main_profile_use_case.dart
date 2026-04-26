import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/domain/entities/auth/user_entity/user_entity.dart';
import 'package:explaino/features/tabs/profile/main_profile/domain/repositories/main_profile_repo.dart';

class GetProfileUseCase {
  final MainProfileRepository _profileRepository;
  GetProfileUseCase(this._profileRepository);
  Future<BaseResponse<UserEntity>> getProfile() {
    return _profileRepository.getProfile();
  }
}
