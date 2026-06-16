import 'package:explaino/core/shared/data/models/questions/response/first_ten_answers_of_question_response_model/answer_model.dart';

class AnswersOfQuestionResponseEntity {
  final int count;
  final String? next;
  final String? previous;
  final List<AnswerModel> answers;

  AnswersOfQuestionResponseEntity({
    required this.count,
    required this.next,
    required this.previous,
    required this.answers,
  });

  AnswersOfQuestionResponseEntity copyWith({
    int? count,
    String? next,
    String? previous,
    List<AnswerModel>? answers,
  }) {
    return AnswersOfQuestionResponseEntity(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      answers: answers ?? this.answers,
    );
  }
}
