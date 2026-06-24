import 'package:explaino/core/shared/data/models/posts/response/get_comments_of_post_response_model/get_comments_of_post_response_model.dart';
import 'package:explaino/features/post_action/data/mappers/comment_mapper.dart';
import 'package:explaino/features/post_action/domain/entities/response/get_comments_of_post_response_entity.dart';

extension GetCommentsOfPostResponseMapper on GetCommentsOfPostResponseModel {
  GetCommentsOfPostResponseEntity toEntity() {
    return GetCommentsOfPostResponseEntity(
      count: count,
      next: next,
      previous: previous,
      comments: comments.map((e) => e.toEntity()).toList(),
    );
  }
}
