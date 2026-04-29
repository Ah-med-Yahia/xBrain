import 'package:explaino/core/shared/data/models/auth/user_model/specialization_model/specialization_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'get_tracks_response_model.g.dart';

GetTracksResponseModel getTracksResponseModelFromJson(String str) =>
    GetTracksResponseModel.fromJson(json.decode(str));

@JsonSerializable()
class GetTracksResponseModel {
  @JsonKey(name: 'count')
  final int count;
  @JsonKey(name: 'results')
  final List<SpecializationModel> results;

  GetTracksResponseModel({required this.count, required this.results});

  factory GetTracksResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetTracksResponseModelFromJson(json);
}
