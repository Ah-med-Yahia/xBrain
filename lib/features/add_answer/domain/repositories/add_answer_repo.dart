import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/add_answer/domain/entities/request/add_answer_request_entity.dart';
import 'package:explaino/features/add_answer/domain/entities/response/answer_entity.dart';
import 'package:explaino/features/add_answer/domain/entities/response/answers_of_question_respons_entity.dart';

abstract interface class AddAnswerRepo {
  Future<BaseResponse<AnswerEntity>> addAnswer(
    AddAnswerRequestEntity answer,
    String questionId,
  );

  Future<BaseResponse<AnswersOfQuestionResponseEntity>> getAnswersOfQuestion(
    String questionId,
    int page,
  );

  Future<BaseResponse<AnswersOfQuestionResponseEntity>> getReplies(
    String answerId,
  );

  Future<BaseResponse<AnswerEntity>> addReply(
    String answerId,
    AddAnswerRequestEntity request,
  );
  Future<BaseResponse<void>> deleteAnswerOrReply(String id);
}
