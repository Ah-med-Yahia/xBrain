import 'package:explaino/core/shared/data/models/auth/user_model/specialization_model/specialization_model.dart';
import 'package:explaino/core/shared/data/models/questions/request/get_list_questions_response_model/attachment_model.dart';
import 'package:explaino/core/shared/data/models/questions/request/get_list_questions_response_model/author_model.dart';
import 'package:explaino/core/shared/data/models/questions/response/answer_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_question_response_model.g.dart';

@JsonSerializable()
class AddQuestionResponsModel {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'author')
  final AuthorModel author;
  @JsonKey(name: 'content')
  final String content;
  @JsonKey(name: 'specializations')
  final List<SpecializationModel> specializations;
  @JsonKey(name: 'is_resolved')
  final bool isResolved;
  @JsonKey(name: 'resolved_at')
  final DateTime resolvedAt;
  @JsonKey(name: 'answers_count')
  final int answersCount;
  @JsonKey(name: 'answers')
  final List<AnswerModel> answers;
  @JsonKey(name: 'attachments')
  final List<AttachmentModel> attachments;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  AddQuestionResponsModel({
    required this.id,
    required this.author,
    required this.content,
    required this.specializations,
    required this.isResolved,
    required this.resolvedAt,
    required this.answersCount,
    required this.answers,
    required this.attachments,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AddQuestionResponsModel.fromJson(Map<String, dynamic> json) =>
      _$AddQuestionResponsModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddQuestionResponsModelToJson(this);
}
