import 'package:dio/dio.dart';
import 'package:explaino/core/constants/api_constants.dart';
import 'package:explaino/core/shared/data/models/posts/response/get_posts_response_model/get_posts_response_model.dart';
import 'package:explaino/core/shared/data/models/questions/response/get_list_questions_response_model/get_list_questions_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'home_api_client.g.dart';

@injectable
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class HomeApiClient {
  @factoryMethod
  factory HomeApiClient(Dio dio) = _HomeApiClient;

  @GET(ApiConstants.getQuestionList)
  Future<GetListQuestionsResponseModel> getQuestionList({
    @Query('page') int page = 1,
  });

  @GET(ApiConstants.getPosts)
  Future<GetPostsResponsModel> getPostsList({@Query('page') int page = 1});
}
