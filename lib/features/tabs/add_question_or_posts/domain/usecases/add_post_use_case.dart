import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/tabs/add_question_or_posts/domain/entities/request/add_post_request_entity.dart';
import 'package:explaino/features/tabs/add_question_or_posts/domain/repositories/add_question_or_posts_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddPostUseCase {
  final AddQuestionOrPostsRepo _repo;

  AddPostUseCase(this._repo);

  Future<BaseResponse<void>> call(AddPostRequestEntity request) async {
    return await _repo.addPost(request);
  }
}
