import 'package:explaino/core/shared/data/models/questions/request/get_list_questions_response_model/attachment_model.dart';
import 'package:explaino/core/shared/data/models/questions/request/get_list_questions_response_model/author_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'reply_model.g.dart';

@JsonSerializable()
class ReplyModel {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'question')
  final String question;
  @JsonKey(name: 'author')
  final AuthorModel author;
  @JsonKey(name: 'content')
  final String content;
  @JsonKey(name: 'parent_answer')
  final String parentAnswer;
  @JsonKey(name: 'replies_count')
  final int repliesCount;
  @JsonKey(name: 'attachments')
  final List<AttachmentModel> attachments;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  ReplyModel({
    required this.id,
    required this.question,
    required this.author,
    required this.content,
    required this.parentAnswer,
    required this.repliesCount,
    required this.attachments,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReplyModel.fromJson(Map<String, dynamic> json) =>
      _$ReplyModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReplyModelToJson(this);
}
