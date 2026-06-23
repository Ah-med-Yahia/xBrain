import 'package:explaino/features/schedule_meeting/data/models/response/schedule_meeting_response_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'meetings_response_model.g.dart';

@JsonSerializable()
class MeetingsResponseModel {
  @JsonKey(name: 'count')
  int count;
  @JsonKey(name: 'next')
  String? next;
  @JsonKey(name: 'previous')
  String? previous;
  @JsonKey(name: 'results')
  List<ScheduleMeetingResponseModel> results;

  MeetingsResponseModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  MeetingsResponseModel copyWith({
    int? count,
    String? next,
    String? previous,
    List<ScheduleMeetingResponseModel>? results,
  }) => MeetingsResponseModel(
    count: count ?? this.count,
    next: next ?? this.next,
    previous: previous ?? this.previous,
    results: results ?? this.results,
  );

  factory MeetingsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MeetingsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MeetingsResponseModelToJson(this);
}
