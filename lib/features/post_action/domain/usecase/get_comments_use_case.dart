import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/post_action/domain/entities/response/get_comments_of_post_response_entity.dart';
import 'package:explaino/features/post_action/domain/repositories/post_action_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCommentsUseCase {
  final PostActionRepo _repo;

  GetCommentsUseCase(this._repo);

  Future<BaseResponse<GetCommentsOfPostResponseEntity>> call({
    required String id,
    int page = 1,
  }) {
    return _repo.getComments(id: id, page: page);
  }
}
