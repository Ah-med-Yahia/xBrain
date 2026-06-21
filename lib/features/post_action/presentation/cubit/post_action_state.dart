import 'package:equatable/equatable.dart';
import 'package:explaino/features/post_action/domain/entities/response/get_comments_of_post_response_entity.dart';
import 'package:explaino/features/post_action/domain/entities/response/post_entity.dart';

class PostActionState extends Equatable {
  final PostEntity? post;
  final GetCommentsOfPostResponseEntity? commentsResponse;
  final bool loadingComments;
  const PostActionState({
    this.post,
    this.commentsResponse,
    this.loadingComments = false,
  });

  PostActionState copyWith({
    PostEntity? post,
    GetCommentsOfPostResponseEntity? commentsResponse,
    bool? loadingComments,
  }) => PostActionState(
    post: post ?? this.post,
    commentsResponse: commentsResponse ?? this.commentsResponse,
    loadingComments: loadingComments ?? this.loadingComments,
  );

  @override
  List<Object?> get props => [post, commentsResponse, loadingComments];
}
