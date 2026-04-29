import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/domain/entities/auth/user_entity/user_entity.dart';
import 'package:explaino/features/tabs/profile/main_profile/domain/repositories/main_profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProfileUseCase {
  final MainProfileRepository _profileRepository;
  GetProfileUseCase(this._profileRepository);
  Future<BaseResponse<UserEntity>> call() {
    return _profileRepository.getProfile();
  }
}
