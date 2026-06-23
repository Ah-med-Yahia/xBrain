import 'package:json_annotation/json_annotation.dart';

part 'start_new_chat_request.g.dart';

@JsonSerializable()
class StartNewChatRequest {
  @JsonKey(name: 'title')
  final String title;

  StartNewChatRequest({this.title = ''});

  Map<String, dynamic> toJson() => _$StartNewChatRequestToJson(this);
}
