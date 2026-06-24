import 'package:dio/dio.dart';
import 'package:explaino/core/constants/api_constants.dart';
import 'package:explaino/core/shared/data/models/questions/response/answers_of_question_response_model/answers_of_question_response_model.dart';
import 'package:explaino/core/shared/data/models/questions/response/first_ten_answers_of_question_response_model/answer_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'add_answer_api_cilnt.g.dart';

@injectable
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class AddAnswerApiClient {
  @factoryMethod
  factory AddAnswerApiClient(Dio dio) = _AddAnswerApiClient;

  @POST(ApiConstants.addAnswer)
  Future<AnswerModel> addAnswer(
    @Path('question_id') String questionId,
    @Body() FormData formData,
  );

  @GET(ApiConstants.getAllAnswers)
  Future<AnswersOfQuestionResponsModel> getAllAnswers(
    @Path('question_id') String questionId,
    @Query('page') int page,
  );

  @GET(ApiConstants.getReplies)
  Future<AnswersOfQuestionResponsModel> getReplies(@Path('id') String id);

  @DELETE(ApiConstants.deleteAnswer)
  Future<void> deleteAnswerOrReply(@Path('id') String id);

  @POST(ApiConstants.addReply)
  Future<AnswerModel> addReply(
    @Path('id') String answerId,
    @Body() FormData formData,
  );
}
