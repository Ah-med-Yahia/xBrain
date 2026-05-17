import 'package:explaino/core/shared/data/models/posts/response/get_posts_response_model/get_posts_response_model.dart';
import 'package:explaino/features/tabs/home/domain/entities/response/get_posts_response_entity.dart';

extension GetPostsResponseMapper on GetPostsResponsModel {
  GetPostsResponseEntity toEntity() {
    return GetPostsResponseEntity(
      count: count,
      next: next,
      previous: previous,
      posts: posts,
    );
  }
}
