import 'package:json_annotation/json_annotation.dart';

part 'get_my_chats_response_model.g.dart';

@JsonSerializable()
class GetMyChatsResponse {
  @JsonKey(name: 'count')
  final int count;
  @JsonKey(name: 'next')
  final dynamic next;
  @JsonKey(name: 'previous')
  final dynamic previous;
  @JsonKey(name: 'results')
  final List<Result> results;

  GetMyChatsResponse({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory GetMyChatsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetMyChatsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetMyChatsResponseToJson(this);
}

@JsonSerializable()
class Result {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'last_message_at')
  final DateTime lastMessageAt;

  Result({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.lastMessageAt,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
