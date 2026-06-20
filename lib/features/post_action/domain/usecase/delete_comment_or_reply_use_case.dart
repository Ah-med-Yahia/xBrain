import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/post_action/domain/repositories/post_action_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteCommentOrReplyUseCase {
  final PostActionRepo _repo;

  DeleteCommentOrReplyUseCase(this._repo);

  Future<BaseResponse<void>> call(String id) {
    return _repo.deleteCommentOrReply(id);
  }
}
