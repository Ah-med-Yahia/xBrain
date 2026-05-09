import 'package:explaino/core/shared/data/models/questions/response/get_list_questions_response_model/author_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'post')
  final String post;
  @JsonKey(name: 'author')
  final AuthorModel author;
  @JsonKey(name: 'content')
  final String content;
  @JsonKey(name: 'parent_comment')
  final String? parentComment;
  @JsonKey(name: 'replies_count')
  final int repliesCount;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  CommentModel({
    required this.id,
    required this.post,
    required this.author,
    required this.content,
    required this.parentComment,
    required this.repliesCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);
}
