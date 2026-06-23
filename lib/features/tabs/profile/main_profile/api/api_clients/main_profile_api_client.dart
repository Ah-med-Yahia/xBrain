import 'package:dio/dio.dart';
import 'package:explaino/core/constants/api_constants.dart';
import 'package:explaino/core/shared/data/models/auth/user_model/user_model.dart';
import 'package:explaino/core/shared/data/models/posts/response/get_posts_response_model/get_posts_response_model.dart';
import 'package:explaino/core/shared/data/models/questions/response/get_list_questions_response_model/get_list_questions_response_model.dart';
import 'package:explaino/features/tabs/profile/main_profile/data/models/response/get_certificates_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'main_profile_api_client.g.dart';

@injectable
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class MainProfileApiClient {
  @factoryMethod
  factory MainProfileApiClient(Dio dio) = _MainProfileApiClient;

  @GET(ApiConstants.getProfile)
  Future<UserModel> getProfile();
  @GET(ApiConstants.getMyPosts)
  Future<GetPostsResponsModel> getMyPosts();
  @GET(ApiConstants.getMyQuestions)
  Future<GetListQuestionsResponseModel> getMyQuestions();
  @GET(ApiConstants.getMyCertificates)
  Future<GetCertificatesResponseModel> getMyCertificates();
  @DELETE(ApiConstants.deleteMyCertificate)
  Future<void> deleteMyCertificate(@Path('id') String id);
}
