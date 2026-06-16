import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/tabs/home/domain/entities/response/get_posts_response_entity.dart';
import 'package:explaino/features/tabs/home/domain/entities/response/get_questions_response_entity.dart';

abstract interface class HomeRepo {
  Future<BaseResponse<GetQuestionListEntity>> getQuestionList({int page = 1});
  Future<BaseResponse<GetPostsResponseEntity>> getPostsList({int page = 1});
}
