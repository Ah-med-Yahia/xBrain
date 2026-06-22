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
}
