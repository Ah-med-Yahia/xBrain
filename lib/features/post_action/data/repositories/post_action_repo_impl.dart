import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/post_action/data/data_sources/remote/remote_post_action_data_source.dart';
import 'package:explaino/features/post_action/data/mappers/comment_mapper.dart';
import 'package:explaino/features/post_action/data/mappers/comment_request_mapper.dart';
import 'package:explaino/features/post_action/data/mappers/get_comments_of_post_response_mapper.dart';
import 'package:explaino/features/post_action/data/mappers/post_mapper.dart';
import 'package:explaino/features/post_action/domain/entities/request/comment_request_entity.dart';
import 'package:explaino/features/post_action/domain/entities/response/comment_entity.dart';
import 'package:explaino/features/post_action/domain/entities/response/get_comments_of_post_response_entity.dart';
import 'package:explaino/features/post_action/domain/entities/response/post_entity.dart';
import 'package:explaino/features/post_action/domain/repositories/post_action_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PostActionRepo)
class PostActionRepoImpl implements PostActionRepo {
  final RemotePostActionDataSource _remoteDataSource;

  PostActionRepoImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<PostEntity>> getSinglePost(String id) async {
    final result = await _remoteDataSource.getSinglePost(id);
    return result.when(
      success: (data) => BaseResponse.success(data.toEntity()),
      failure: (error) => BaseResponse.failure(error),
    );
  }

  @override
  Future<BaseResponse<PostEntity>> likePost(String id) async {
    final result = await _remoteDataSource.likePost(id);
    return result.when(
      success: (data) => BaseResponse.success(data.toEntity()),
      failure: (error) => BaseResponse.failure(error),
    );
  }

  @override
  Future<BaseResponse<PostEntity>> unlikePost(String id) async {
    final result = await _remoteDataSource.unlikePost(id);
    return result.when(
      success: (data) => BaseResponse.success(data.toEntity()),
      failure: (error) => BaseResponse.failure(error),
    );
  }

  @override
  Future<BaseResponse<GetCommentsOfPostResponseEntity>> getComments({
    required String id,
    required int page,
  }) async {
    final result = await _remoteDataSource.getComments(id: id, page: page);
    return result.when(
      success: (data) => BaseResponse.success(data.toEntity()),
      failure: (error) => BaseResponse.failure(error),
    );
  }

  @override
  Future<BaseResponse<GetCommentsOfPostResponseEntity>> getRepliesOnComment({
    required String id,
    required int page,
  }) async {
    final result = await _remoteDataSource.getRepliesOnComment(
      id: id,
      page: page,
    );
    return result.when(
      success: (data) => BaseResponse.success(data.toEntity()),
      failure: (error) => BaseResponse.failure(error),
    );
  }

  @override
  Future<BaseResponse<CommentEntity>> getSingleCommentOrReply(String id) async {
    final result = await _remoteDataSource.getSingleCommentOrReply(id);
    return result.when(
      success: (data) => BaseResponse.success(data.toEntity()),
      failure: (error) => BaseResponse.failure(error),
    );
  }

  @override
  Future<BaseResponse<CommentEntity>> addComment({
    required String id,
    required CommentRequestEntity request,
  }) async {
    final result = await _remoteDataSource.addComment(
      id: id,
      request: request.toModel(),
    );
    return result.when(
      success: (data) => BaseResponse.success(data.toEntity()),
      failure: (error) => BaseResponse.failure(error),
    );
  }

  @override
  Future<BaseResponse<CommentEntity>> addReplyOnComment({
    required String id,
    required CommentRequestEntity request,
  }) async {
    final result = await _remoteDataSource.addReplyOnComment(
      id: id,
      request: request.toModel(),
    );
    return result.when(
      success: (data) => BaseResponse.success(data.toEntity()),
      failure: (error) => BaseResponse.failure(error),
    );
  }

  @override
  Future<BaseResponse<CommentEntity>> updateCommentOrReply({
    required String id,
    required CommentRequestEntity request,
  }) async {
    final result = await _remoteDataSource.updateCommentOrReply(
      id: id,
      request: request.toModel(),
    );
    return result.when(
      success: (data) => BaseResponse.success(data.toEntity()),
      failure: (error) => BaseResponse.failure(error),
    );
  }

  @override
  Future<BaseResponse<void>> deleteCommentOrReply(String id) async {
    final result = await _remoteDataSource.deleteCommentOrReply(id);
    return result.when(
      success: (data) => const BaseResponse<void>.success(null),
      failure: (error) => BaseResponse<void>.failure(error),
    );
  }
}
