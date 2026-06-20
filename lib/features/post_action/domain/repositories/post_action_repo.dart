import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/post_action/domain/entities/request/comment_request_entity.dart';
import 'package:explaino/features/post_action/domain/entities/response/comment_entity.dart';
import 'package:explaino/features/post_action/domain/entities/response/get_comments_of_post_response_entity.dart';
import 'package:explaino/features/post_action/domain/entities/response/post_entity.dart';

abstract interface class PostActionRepo {
  Future<BaseResponse<PostEntity>> getSinglePost(String id);
  Future<BaseResponse<PostEntity>> likePost(String id);
  Future<BaseResponse<PostEntity>> unlikePost(String id);
  Future<BaseResponse<GetCommentsOfPostResponseEntity>> getComments({
    required String id,
    required int page,
  });
  Future<BaseResponse<GetCommentsOfPostResponseEntity>> getRepliesOnComment({
    required String id,
    required int page,
  });
  Future<BaseResponse<CommentEntity>> getSingleCommentOrReply(String id);
  Future<BaseResponse<CommentEntity>> addComment({
    required String id,
    required CommentRequestEntity request,
  });
  Future<BaseResponse<CommentEntity>> addReplyOnComment({
    required String id,
    required CommentRequestEntity request,
  });
  Future<BaseResponse<CommentEntity>> updateCommentOrReply({
    required String id,
    required CommentRequestEntity request,
  });
  Future<BaseResponse<void>> deleteCommentOrReply(String id);
}
