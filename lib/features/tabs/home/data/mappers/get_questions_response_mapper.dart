import 'package:explaino/core/shared/data/models/questions/response/get_list_questions_response_model/get_list_questions_response_model.dart';
import 'package:explaino/features/tabs/home/domain/entities/response/get_questions_response_entity.dart';

extension GetQuestionsResponseMapper on GetListQuestionsResponseModel {
  GetQuestionListEntity toEntity() {
    return GetQuestionListEntity(
      count: count,
      next: next,
      previous: previous,
      questions: questions,
    );
  }
}
