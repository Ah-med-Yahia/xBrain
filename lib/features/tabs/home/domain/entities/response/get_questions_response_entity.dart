import 'package:explaino/core/shared/data/models/questions/response/get_list_questions_response_model/question_model.dart';

class GetQuestionListEntity {
  final int count;
  final String? next;
  final String? previous;
  final List<QuestionModel> questions;

  GetQuestionListEntity({
    required this.count,
    required this.next,
    required this.previous,
    required this.questions,
  });

  GetQuestionListEntity copyWith({
    int? count,
    String? next,
    String? previous,
    List<QuestionModel>? questions,
  }) {
    return GetQuestionListEntity(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      questions: questions ?? this.questions,
    );
  }
}
