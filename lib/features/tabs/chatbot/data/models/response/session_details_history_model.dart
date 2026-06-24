import 'package:json_annotation/json_annotation.dart';
part 'session_details_history_model.g.dart';

@JsonSerializable()
class SessionDetailsHistoryModel {
  @JsonKey(name: 'session_id')
  final String sessionId;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'summary')
  final String summary;
  @JsonKey(name: 'history')
  final List<HistoryElementModel> history;

  SessionDetailsHistoryModel({
    required this.sessionId,
    required this.userId,
    required this.summary,
    required this.history,
  });

  factory SessionDetailsHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$SessionDetailsHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$SessionDetailsHistoryModelToJson(this);
}

@JsonSerializable()
class HistoryElementModel {
  @JsonKey(name: 'role')
  final String role;
  @JsonKey(name: 'content')
  final String content;

  HistoryElementModel({required this.role, required this.content});

  factory HistoryElementModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryElementModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryElementModelToJson(this);
}
