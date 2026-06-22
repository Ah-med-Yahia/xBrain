import 'package:equatable/equatable.dart';
import 'package:explaino/features/post_action/domain/entities/response/post_entity.dart';
import 'package:explaino/features/post_action/domain/entities/response/comment_entity.dart';

class PostActionState extends Equatable {
  final PostEntity? post;
  final CommentEntity? replyingToComment;
  const PostActionState({this.post, this.replyingToComment});

  PostActionState copyWith({
    PostEntity? post,
    CommentEntity? replyingToComment,
    bool clearReplyingToComment = false,
  }) => PostActionState(
    post: post ?? this.post,
    replyingToComment: clearReplyingToComment
        ? null
        : (replyingToComment ?? this.replyingToComment),
  );

  @override
  List<Object?> get props => [post, replyingToComment];
}
