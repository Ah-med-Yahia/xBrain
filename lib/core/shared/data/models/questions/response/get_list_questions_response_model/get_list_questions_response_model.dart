import 'package:explaino/core/shared/data/models/questions/response/get_list_questions_response_model/question_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_list_questions_response_model.g.dart';

@JsonSerializable()
class GetListQuestionsResponseModel {
  @JsonKey(name: 'count')
  final int count;
  @JsonKey(name: 'next')
  final String? next;
  @JsonKey(name: 'previous')
  final String? previous;
  @JsonKey(name: 'results')
  final List<QuestionModel> questions;

  GetListQuestionsResponseModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.questions,
  });

  factory GetListQuestionsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetListQuestionsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetListQuestionsResponseModelToJson(this);
}
