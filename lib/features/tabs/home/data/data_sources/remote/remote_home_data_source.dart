import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/data/models/posts/response/get_posts_response_model/get_posts_response_model.dart';
import 'package:explaino/core/shared/data/models/questions/response/get_list_questions_response_model/get_list_questions_response_model.dart';

abstract interface class RemoteHomeDataSource {
  Future<BaseResponse<GetListQuestionsResponseModel>> getQuestionList({
    int page = 1,
  });
  Future<BaseResponse<GetPostsResponsModel>> getPostsList({int page = 1});
}
