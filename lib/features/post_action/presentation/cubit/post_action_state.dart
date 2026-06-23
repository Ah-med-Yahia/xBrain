import 'package:equatable/equatable.dart';
import 'package:explaino/features/post_action/domain/entities/response/post_entity.dart';
import 'package:explaino/features/post_action/domain/entities/response/comment_entity.dart';

class PostActionState extends Equatable {
  final PostEntity? post;
  final CommentEntity? replyingToComment;
  final Map<String, List<CommentEntity>> commentReplies;
  final Set<String> loadingReplies;
  final int loadedPagesCount;

  const PostActionState({
    this.post,
    this.replyingToComment,
    this.commentReplies = const {},
    this.loadingReplies = const {},
    this.loadedPagesCount = 1,
  });

  PostActionState copyWith({
    PostEntity? post,
    CommentEntity? replyingToComment,
    bool clearReplyingToComment = false,
    Map<String, List<CommentEntity>>? commentReplies,
    Set<String>? loadingReplies,
    int? loadedPagesCount,
  }) => PostActionState(
    post: post ?? this.post,
    replyingToComment: clearReplyingToComment
        ? null
        : (replyingToComment ?? this.replyingToComment),
    commentReplies: commentReplies ?? this.commentReplies,
    loadingReplies: loadingReplies ?? this.loadingReplies,
    loadedPagesCount: loadedPagesCount ?? this.loadedPagesCount,
  );

  @override
  List<Object?> get props => [
    post,
    replyingToComment,
    commentReplies,
    loadingReplies,
    loadedPagesCount,
  ];
}
