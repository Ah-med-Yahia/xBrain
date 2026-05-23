import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/tabs/home/domain/entities/response/get_posts_response_entity.dart';
import 'package:explaino/features/tabs/home/domain/repositories/home_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetPostListUseCase {
  final HomeRepo _homeRepo;

  GetPostListUseCase(this._homeRepo);
  Future<BaseResponse<GetPostsResponseEntity>> call() {
    return _homeRepo.getPostsList();
  }
}
