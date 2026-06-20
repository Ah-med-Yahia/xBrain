import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/data/models/posts/response/post_model/post_model.dart';
import 'package:explaino/core/shared/data/models/posts/response/get_comments_of_post_response_model/get_comments_of_post_response_model.dart';
import 'package:explaino/core/shared/data/models/posts/response/get_comments_of_post_response_model/comment_model.dart';
import 'package:explaino/features/post_action/data/models/request/comment_request_model.dart';

abstract interface class RemotePostActionDataSource {
  Future<BaseResponse<PostModel>> getSinglePost(String id);
  Future<BaseResponse<PostModel>> likePost(String id);
  Future<BaseResponse<PostModel>> unlikePost(String id);
  Future<BaseResponse<GetCommentsOfPostResponseModel>> getComments({
    required String id,
    required int page,
  });
  Future<BaseResponse<GetCommentsOfPostResponseModel>> getRepliesOnComment({
    required String id,
    required int page,
  });
  Future<BaseResponse<CommentModel>> getSingleCommentOrReply(String id);
  Future<BaseResponse<CommentModel>> addComment({
    required String id,
    required CommentRequestModel request,
  });
  Future<BaseResponse<CommentModel>> addReplyOnComment({
    required String id,
    required CommentRequestModel request,
  });
  Future<BaseResponse<CommentModel>> updateCommentOrReply({
    required String id,
    required CommentRequestModel request,
  });
  Future<BaseResponse<void>> deleteCommentOrReply(String id);
}
