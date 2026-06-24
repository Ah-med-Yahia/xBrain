import 'package:explaino/core/shared/data/models/posts/response/get_comments_of_post_response_model/comment_model.dart';
import 'package:explaino/features/post_action/domain/entities/response/comment_entity.dart';

extension CommentMapper on CommentModel {
  CommentEntity toEntity() {
    return CommentEntity(
      id: id,
      post: post,
      author: author,
      content: content,
      parentComment: parentComment,
      repliesCount: repliesCount,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension CommentEntityMapper on CommentEntity {
  CommentModel toModel() {
    return CommentModel(
      id: id,
      post: post,
      author: author,
      content: content,
      parentComment: parentComment,
      repliesCount: repliesCount,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
