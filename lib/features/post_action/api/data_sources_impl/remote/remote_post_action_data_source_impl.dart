import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/config/network/safe_api_call.dart';
import 'package:explaino/core/shared/data/models/posts/response/post_model/post_model.dart';
import 'package:explaino/core/shared/data/models/posts/response/get_comments_of_post_response_model/get_comments_of_post_response_model.dart';
import 'package:explaino/core/shared/data/models/posts/response/get_comments_of_post_response_model/comment_model.dart';
import 'package:explaino/features/post_action/api/api_clients/post_action_api_client.dart';
import 'package:explaino/features/post_action/data/data_sources/remote/remote_post_action_data_source.dart';
import 'package:explaino/features/post_action/data/models/request/comment_request_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RemotePostActionDataSource)
class RemotePostActionDataSourceImpl implements RemotePostActionDataSource {
  final PostActionApiClient _apiClient;

  RemotePostActionDataSourceImpl(this._apiClient);

  @override
  Future<BaseResponse<PostModel>> getSinglePost(String id) {
    return safeApiCall(() => _apiClient.getSinglePost(id));
  }

  @override
  Future<BaseResponse<PostModel>> likePost(String id) {
    return safeApiCall(() => _apiClient.likePost(id));
  }

  @override
  Future<BaseResponse<PostModel>> unlikePost(String id) {
    return safeApiCall(() => _apiClient.unlikePost(id));
  }

  @override
  Future<BaseResponse<GetCommentsOfPostResponseModel>> getComments({
    required String id,
    required int page,
  }) {
    return safeApiCall(() => _apiClient.getComments(id, page));
  }

  @override
  Future<BaseResponse<GetCommentsOfPostResponseModel>> getRepliesOnComment({
    required String id,
    required int page,
  }) {
    return safeApiCall(() => _apiClient.getRepliesOnComment(id, page));
  }

  @override
  Future<BaseResponse<CommentModel>> getSingleCommentOrReply(String id) {
    return safeApiCall(() => _apiClient.getSingleCommentOrReply(id));
  }

  @override
  Future<BaseResponse<CommentModel>> addComment({
    required String id,
    required CommentRequestModel request,
  }) {
    return safeApiCall(() => _apiClient.addComment(id, request));
  }

  @override
  Future<BaseResponse<CommentModel>> addReplyOnComment({
    required String id,
    required CommentRequestModel request,
  }) {
    return safeApiCall(() => _apiClient.addReplyOnComment(id, request));
  }

  @override
  Future<BaseResponse<CommentModel>> updateCommentOrReply({
    required String id,
    required CommentRequestModel request,
  }) {
    return safeApiCall(() => _apiClient.updateCommentOrReply(id, request));
  }

  @override
  Future<BaseResponse<void>> deleteCommentOrReply(String id) {
    return safeApiCall(() => _apiClient.deleteCommentOrReply(id));
  }
}
