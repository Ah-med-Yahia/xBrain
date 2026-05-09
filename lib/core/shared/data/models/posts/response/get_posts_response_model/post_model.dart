import 'package:explaino/core/shared/data/models/auth/user_model/specialization_model/specialization_model.dart';
import 'package:explaino/core/shared/data/models/questions/response/get_list_questions_response_model/attachment_model.dart';
import 'package:explaino/core/shared/data/models/questions/response/get_list_questions_response_model/author_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'post_model.g.dart';

@JsonSerializable()
class ShortPostModel {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'author')
  final AuthorModel author;
  @JsonKey(name: 'content_preview')
  final String contentPreview;
  @JsonKey(name: 'specializations')
  final List<SpecializationModel> specializations;
  @JsonKey(name: 'attachments')
  final List<AttachmentModel>? attachments;
  @JsonKey(name: 'likes_count')
  final int likesCount;
  @JsonKey(name: 'dislikes_count')
  final int dislikesCount;
  @JsonKey(name: 'my_reaction')
  final String? myReaction;
  @JsonKey(name: 'comments_count')
  final int commentsCount;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  ShortPostModel({
    required this.id,
    required this.author,
    required this.contentPreview,
    required this.specializations,
    required this.attachments,
    required this.likesCount,
    required this.dislikesCount,
    required this.myReaction,
    required this.commentsCount,
    required this.createdAt,
  });

  factory ShortPostModel.fromJson(Map<String, dynamic> json) =>
      _$ShortPostModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShortPostModelToJson(this);
}
