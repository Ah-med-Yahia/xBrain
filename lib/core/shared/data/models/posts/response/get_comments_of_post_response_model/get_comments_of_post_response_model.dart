import 'package:explaino/core/shared/data/models/posts/response/get_comments_of_post_response_model/comment_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_comments_of_post_response_model.g.dart';

@JsonSerializable()
class GetCommentsOfPostResponseModel {
  @JsonKey(name: 'count')
  final int count;
  @JsonKey(name: 'next')
  final String? next;
  @JsonKey(name: 'previous')
  final String? previous;
  @JsonKey(name: 'results')
  final List<CommentModel> comments;

  GetCommentsOfPostResponseModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.comments,
  });

  factory GetCommentsOfPostResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetCommentsOfPostResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetCommentsOfPostResponseModelToJson(this);
}
