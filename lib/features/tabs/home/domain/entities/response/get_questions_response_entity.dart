import 'package:explaino/core/shared/data/models/questions/response/get_list_questions_response_model/question_model.dart';

class GetQuestionListEntity {
  final int count;
  final String next;
  final String previous;
  final List<QuestionModel> questions;

  GetQuestionListEntity({
    required this.count,
    required this.next,
    required this.previous,
    required this.questions,
  });
}
