import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/data/models/questions/response/answers_of_question_response_model/answers_of_question_response_model.dart';
import 'package:explaino/core/shared/data/models/questions/response/first_ten_answers_of_question_response_model/answer_model.dart';
import 'package:explaino/features/add_answer/data/models/request/add_answer_request_model.dart';

abstract class RemoteAddAnswerDataSource {
  Future<BaseResponse<AnswerModel>> addAnswer(
    AddAnswerRequestModel request,
    String questionId,
  );
  Future<BaseResponse<AnswersOfQuestionResponsModel>> getAllAnswers(
    String questionId,
    int page,
  );
  Future<BaseResponse<AnswersOfQuestionResponsModel>> getReplies(String id);

  Future<BaseResponse<AnswerModel>> addReply(
    String answerId,
    AddAnswerRequestModel request,
  );
  Future<BaseResponse<void>> deleteAnswerOrReply(String id);
}
