import 'package:explaino/features/tabs/chatbot/data/models/response/session_details_history_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'session_details_model.g.dart';

@JsonSerializable()
class SessionDetailsModel {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'last_message_at')
  final DateTime lastMessageAt;
  @JsonKey(name: 'history')
  final SessionDetailsHistoryModel history;

  SessionDetailsModel({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.lastMessageAt,
    required this.history,
  });

  factory SessionDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$SessionDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SessionDetailsModelToJson(this);
}
