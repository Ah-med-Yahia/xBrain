import 'package:explaino/core/shared/data/models/auth/user_model/specialization_model/specialization_model.dart';
import 'package:explaino/core/shared/data/models/posts/response/get_comments_of_post_response_model/comment_model.dart';
import 'package:explaino/core/shared/data/models/questions/response/get_list_questions_response_model/attachment_model.dart';
import 'package:explaino/core/shared/data/models/questions/response/get_list_questions_response_model/author_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'post_model.g.dart';

@JsonSerializable()
class PostModel {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'author')
  final AuthorModel author;
  @JsonKey(name: 'content')
  final String content;
  @JsonKey(name: 'specializations')
  final List<SpecializationModel> specializations;
  @JsonKey(name: 'attachments')
  final List<AttachmentModel> attachments;
  @JsonKey(name: 'likes_count')
  final int likesCount;
  @JsonKey(name: 'dislikes_count')
  final int dislikesCount;
  @JsonKey(name: 'my_reaction')
  final String? myReaction;
  @JsonKey(name: 'comments_count')
  final int commentsCount;
  @JsonKey(name: 'comments')
  final List<CommentModel> comments;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  PostModel({
    required this.id,
    required this.author,
    required this.content,
    required this.specializations,
    required this.attachments,
    required this.likesCount,
    required this.dislikesCount,
    required this.myReaction,
    required this.commentsCount,
    required this.comments,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}
