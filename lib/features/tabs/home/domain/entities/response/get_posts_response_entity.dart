import 'package:explaino/core/shared/data/models/posts/response/get_posts_response_model/post_model.dart';

class GetPostsResponseEntity {
  final int count;
  final String? next;
  final String? previous;
  final List<ShortPostModel> posts;

  GetPostsResponseEntity({
    required this.count,
    required this.next,
    required this.previous,
    required this.posts,
  });

  GetPostsResponseEntity copyWith({
    int? count,
    String? next,
    String? previous,
    List<ShortPostModel>? posts,
  }) {
    return GetPostsResponseEntity(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      posts: posts ?? this.posts,
    );
  }
}
