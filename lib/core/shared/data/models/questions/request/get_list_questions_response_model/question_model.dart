import 'package:explaino/core/shared/data/models/auth/user_model/specialization_model/specialization_model.dart';
import 'package:explaino/core/shared/data/models/questions/request/get_list_questions_response_model/attachment_model.dart';
import 'package:explaino/core/shared/data/models/questions/request/get_list_questions_response_model/author_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question_model.g.dart';

@JsonSerializable()
class QuestionModel {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'author')
  final AuthorModel author;
  @JsonKey(name: 'content_preview')
  final String contentPreview;
  @JsonKey(name: 'attachments')
  final List<AttachmentModel> attachments;
  @JsonKey(name: 'specializations')
  final List<SpecializationModel> specializations;
  @JsonKey(name: 'is_resolved')
  final bool isResolved;
  @JsonKey(name: 'answers_count')
  final int answersCount;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  QuestionModel({
    required this.id,
    required this.author,
    required this.contentPreview,
    required this.attachments,
    required this.specializations,
    required this.isResolved,
    required this.answersCount,
    required this.createdAt,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);
}
