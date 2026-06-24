import 'package:explaino/core/shared/data/models/posts/response/post_model/post_model.dart';
import 'package:explaino/features/post_action/domain/entities/response/post_entity.dart';

extension PostMapper on PostModel {
  PostEntity toEntity() {
    return PostEntity(
      id: id,
      author: author,
      content: content,
      specializations: specializations,
      attachments: attachments,
      likesCount: likesCount,
      dislikesCount: dislikesCount,
      myReaction: myReaction,
      commentsCount: commentsCount,
      comments: comments,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
