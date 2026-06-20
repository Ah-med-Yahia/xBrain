import 'package:dio/dio.dart';
import 'package:explaino/core/constants/api_constants.dart';
import 'package:explaino/core/shared/data/models/posts/response/post_model/post_model.dart';
import 'package:explaino/core/shared/data/models/posts/response/get_comments_of_post_response_model/get_comments_of_post_response_model.dart';
import 'package:explaino/core/shared/data/models/posts/response/get_comments_of_post_response_model/comment_model.dart';
import 'package:explaino/features/post_action/data/models/request/comment_request_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'post_action_api_client.g.dart';

@injectable
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class PostActionApiClient {
  @factoryMethod
  factory PostActionApiClient(Dio dio) = _PostActionApiClient;

  @GET(ApiConstants.getSinglePost)
  Future<PostModel> getSinglePost(@Path('id') String id);

  @POST(ApiConstants.likePost)
  Future<PostModel> likePost(@Path('id') String id);

  @POST(ApiConstants.unlikePost)
  Future<PostModel> unlikePost(@Path('id') String id);

  @GET(ApiConstants.getComments)
  Future<GetCommentsOfPostResponseModel> getComments(
    @Path('id') String id,
    @Query('page') int page,
  );

  @GET(ApiConstants.getRepliesOnComment)
  Future<GetCommentsOfPostResponseModel> getRepliesOnComment(
    @Path('id') String id,
    @Query('page') int page,
  );

  @GET(ApiConstants.getSingleCommentOrReply)
  Future<CommentModel> getSingleCommentOrReply(@Path('id') String id);

  @POST(ApiConstants.addComment)
  Future<CommentModel> addComment(
    @Path('id') String id,
    @Body() CommentRequestModel request,
  );

  @POST(ApiConstants.addReplyOnComment)
  Future<CommentModel> addReplyOnComment(
    @Path('id') String id,
    @Body() CommentRequestModel request,
  );

  @PATCH(ApiConstants.updateCommentOrReply)
  Future<CommentModel> updateCommentOrReply(
    @Path('id') String id,
    @Body() CommentRequestModel request,
  );

  @DELETE(ApiConstants.deleteCommentOrReply)
  Future<void> deleteCommentOrReply(@Path('id') String id);
}
