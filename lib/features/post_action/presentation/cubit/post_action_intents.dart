import 'package:explaino/features/post_action/domain/entities/request/comment_request_entity.dart';
import 'package:explaino/features/post_action/domain/entities/response/comment_entity.dart';

sealed class PostActionIntents {}

// =======================  Post ========================

class GetSinglePostIntent extends PostActionIntents {
  final String postId;
  GetSinglePostIntent({required this.postId});
}

class LikePostIntent extends PostActionIntents {
  final String postId;
  LikePostIntent({required this.postId});
}

class DislikePostIntent extends PostActionIntents {
  final String postId;
  DislikePostIntent({required this.postId});
}

// =======================  Comments-Replies =======================

class AddCommentIntent extends PostActionIntents {
  final String id;
  final CommentRequestEntity request;
  AddCommentIntent({required this.id, required this.request});
}

class AddReplyIntent extends PostActionIntents {
  final String commentId;
  final CommentRequestEntity request;
  AddReplyIntent({required this.commentId, required this.request});
}

class DeleteCommentOrReplyIntent extends PostActionIntents {
  final String id;
  DeleteCommentOrReplyIntent({required this.id});
}

class GetRepliesIntent extends PostActionIntents {
  final String id;
  final int page;
  GetRepliesIntent({required this.id, this.page = 1});
}

class GetSingleCommentOrReplyIntent extends PostActionIntents {
  final String id;
  GetSingleCommentOrReplyIntent({required this.id});
}

class UpdateCommentOrReplyIntent extends PostActionIntents {
  final String id;
  final CommentRequestEntity request;
  UpdateCommentOrReplyIntent({required this.id, required this.request});
}

class SetReplyingToCommentIntent extends PostActionIntents {
  final CommentEntity? comment;
  SetReplyingToCommentIntent({this.comment});
}
