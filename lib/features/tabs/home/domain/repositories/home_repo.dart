import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/tabs/home/domain/entities/response/get_posts_response_entity.dart';
import 'package:explaino/features/tabs/home/domain/entities/response/get_questions_response_entity.dart';

abstract interface class HomeRepo {
  Future<BaseResponse<GetQuestionListEntity>> getQuestionList();
  Future<BaseResponse<GetPostsResponseEntity>> getPostsList();
}
