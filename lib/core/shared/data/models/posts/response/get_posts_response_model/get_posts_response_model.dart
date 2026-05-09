import 'package:explaino/core/shared/data/models/posts/response/get_posts_response_model/post_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_posts_response_model.g.dart';

@JsonSerializable()
class GetPostsResponsModel {
  @JsonKey(name: 'count')
  final int count;
  @JsonKey(name: 'next')
  final String? next;
  @JsonKey(name: 'previous')
  final String? previous;
  @JsonKey(name: 'results')
  final List<ShortPostModel> posts;

  GetPostsResponsModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.posts,
  });

  factory GetPostsResponsModel.fromJson(Map<String, dynamic> json) =>
      _$GetPostsResponsModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetPostsResponsModelToJson(this);
}
