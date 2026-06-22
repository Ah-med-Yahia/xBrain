import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/post_action/domain/entities/response/post_entity.dart';
import 'package:explaino/features/post_action/domain/repositories/post_action_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class UnlikePostUseCase {
  final PostActionRepo _repo;

  UnlikePostUseCase(this._repo);

  Future<BaseResponse<PostEntity>> call(String id) {
    return _repo.unlikePost(id);
  }
}
