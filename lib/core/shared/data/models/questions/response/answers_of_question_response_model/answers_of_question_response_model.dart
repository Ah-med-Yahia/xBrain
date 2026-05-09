import 'package:explaino/core/shared/data/models/questions/response/first_ten_answers_of_question_response_model/answer_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'answers_of_question_response_model.g.dart';

@JsonSerializable()
class AnswersOfQuestionResponsModel {
  @JsonKey(name: 'count')
  final int count;
  @JsonKey(name: 'next')
  final String? next;
  @JsonKey(name: 'previous')
  final String? previous;
  @JsonKey(name: 'results')
  final List<AnswerModel> answers;

  AnswersOfQuestionResponsModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.answers,
  });

  factory AnswersOfQuestionResponsModel.fromJson(Map<String, dynamic> json) =>
      _$AnswersOfQuestionResponsModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnswersOfQuestionResponsModelToJson(this);
}
