import 'package:explaino/core/shared/data/models/auth/user_model/specialization_model/specialization_model.dart';
import 'package:explaino/core/shared/data/models/posts/response/get_comments_of_post_response_model/comment_model.dart';
import 'package:explaino/core/shared/data/models/questions/response/get_list_questions_response_model/attachment_model.dart';
import 'package:explaino/core/shared/data/models/questions/response/get_list_questions_response_model/author_model.dart';

class PostEntity {
  final String id;
  final AuthorModel author;
  final String content;
  final List<SpecializationModel> specializations;
  final List<AttachmentModel> attachments;
  final int likesCount;
  final int dislikesCount;
  final String? myReaction;
  final int commentsCount;
  final List<CommentModel> comments;
  final DateTime createdAt;
  final DateTime updatedAt;

  PostEntity({
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

  PostEntity copyWith({
    String? id,
    AuthorModel? author,
    String? content,
    List<SpecializationModel>? specializations,
    List<AttachmentModel>? attachments,
    int? likesCount,
    int? dislikesCount,
    String? myReaction,
    int? commentsCount,
    List<CommentModel>? comments,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PostEntity(
      id: id ?? this.id,
      author: author ?? this.author,
      content: content ?? this.content,
      specializations: specializations ?? this.specializations,
      attachments: attachments ?? this.attachments,
      likesCount: likesCount ?? this.likesCount,
      dislikesCount: dislikesCount ?? this.dislikesCount,
      myReaction: myReaction ?? this.myReaction,
      commentsCount: commentsCount ?? this.commentsCount,
      comments: comments ?? this.comments,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
