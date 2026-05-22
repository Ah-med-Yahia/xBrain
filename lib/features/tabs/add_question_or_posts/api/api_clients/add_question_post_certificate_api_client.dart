import 'package:dio/dio.dart';
import 'package:explaino/core/constants/api_constants.dart';
import 'package:explaino/core/shared/data/models/posts/response/post_model/post_model.dart';
import 'package:explaino/features/tabs/add_question_or_posts/data/models/response/add_question_response_model/add_question_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'add_question_post_certificate_api_client.g.dart';

@injectable
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class AddQuestionPostCertificateApiClient {
  @factoryMethod
  factory AddQuestionPostCertificateApiClient(Dio dio) =
      _AddQuestionPostCertificateApiClient;

  @POST(ApiConstants.addQuestion)
  Future<AddQuestionResponsModel> addQuestion(@Body() FormData formData);

  @POST(ApiConstants.addPost)
  Future<PostModel> addPost(@Body() FormData formData);

  @POST(ApiConstants.addCertificate)
  Future<dynamic> addCertificate(@Body() FormData formData);
}
