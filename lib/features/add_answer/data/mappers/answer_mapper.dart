import 'package:explaino/core/shared/data/models/questions/response/first_ten_answers_of_question_response_model/answer_model.dart';
import 'package:explaino/features/add_answer/domain/entities/response/answer_entity.dart';

extension AnswerMapper on AnswerModel {
  AnswerEntity toEntity() {
    return AnswerEntity(
      id: id,
      question: question,
      author: author,
      content: content,
      parentAnswer: parentAnswer,
      repliesCount: repliesCount,
      replies: replies,
      attachments: attachments,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
