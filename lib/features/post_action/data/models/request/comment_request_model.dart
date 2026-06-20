import 'package:json_annotation/json_annotation.dart';

part 'comment_request_model.g.dart';

@JsonSerializable()
class CommentRequestModel {
  @JsonKey(name: 'content')
  final String content;

  CommentRequestModel({required this.content});

  factory CommentRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CommentRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentRequestModelToJson(this);
}
