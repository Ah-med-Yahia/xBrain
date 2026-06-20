import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/post_action/domain/entities/response/get_comments_of_post_response_entity.dart';
import 'package:explaino/features/post_action/domain/repositories/post_action_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRepliesOnCommentUseCase {
  final PostActionRepo _repo;

  GetRepliesOnCommentUseCase(this._repo);

  Future<BaseResponse<GetCommentsOfPostResponseEntity>> call({
    required String id,
    int page = 1,
  }) {
    return _repo.getRepliesOnComment(id: id, page: page);
  }
}
