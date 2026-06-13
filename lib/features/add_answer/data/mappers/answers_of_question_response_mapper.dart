import 'package:explaino/core/shared/data/models/questions/response/answers_of_question_response_model/answers_of_question_response_model.dart';
import 'package:explaino/features/add_answer/domain/entities/response/answers_of_question_respons_entity.dart';

extension AnswersOfQuestionResponsMapper on AnswersOfQuestionResponsModel {
  AnswersOfQuestionResponseEntity toEntity() {
    return AnswersOfQuestionResponseEntity(
      count: count,
      next: next,
      previous: previous,
      answers: answers,
    );
  }
}
