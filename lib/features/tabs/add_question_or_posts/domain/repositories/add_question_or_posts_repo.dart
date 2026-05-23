import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/tabs/add_question_or_posts/domain/entities/request/add_post_request_entity.dart';
import 'package:explaino/features/tabs/add_question_or_posts/domain/entities/request/add_question_request_entity.dart';

abstract interface class AddQuestionOrPostsRepo {
  Future<BaseResponse<void>> addQuestion(AddQuestionRequestEntity request);
  Future<BaseResponse<void>> addPost(AddPostRequestEntity request);
}
