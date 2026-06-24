import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/tabs/home/domain/entities/response/get_posts_response_entity.dart';
import 'package:explaino/features/tabs/profile/main_profile/domain/repositories/main_profile_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetMyPostsUseCase {
  final MainProfileRepository _repository;

  GetMyPostsUseCase(this._repository);

  Future<BaseResponse<GetPostsResponseEntity>> call(int page) {
    return _repository.getMyPosts(page);
  }
}
