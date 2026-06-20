import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/post_action/domain/entities/request/comment_request_entity.dart';
import 'package:explaino/features/post_action/domain/entities/response/comment_entity.dart';
import 'package:explaino/features/post_action/domain/repositories/post_action_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateCommentOrReplyUseCase {
  final PostActionRepo _repo;

  UpdateCommentOrReplyUseCase(this._repo);

  Future<BaseResponse<CommentEntity>> call({
    required String id,
    required CommentRequestEntity request,
  }) {
    return _repo.updateCommentOrReply(id: id, request: request);
  }
}
