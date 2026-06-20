import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/post_action/domain/entities/response/comment_entity.dart';
import 'package:explaino/features/post_action/domain/repositories/post_action_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetSingleCommentOrReplyUseCase {
  final PostActionRepo _repo;

  GetSingleCommentOrReplyUseCase(this._repo);

  Future<BaseResponse<CommentEntity>> call(String id) {
    return _repo.getSingleCommentOrReply(id);
  }
}
