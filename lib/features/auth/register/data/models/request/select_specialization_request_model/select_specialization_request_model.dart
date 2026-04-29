import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'select_specialization_request_model.g.dart';

String selectSpecializationRequestModelToJson(
  SelectSpecializationRequestModel data,
) => json.encode(data.toJson());

@JsonSerializable()
class SelectSpecializationRequestModel {
  @JsonKey(name: 'specialization_ids')
  final List<String> specializationIds;

  @JsonKey(name: 'skip', defaultValue: false)
  final bool skip;

  SelectSpecializationRequestModel({
    required this.specializationIds,
    this.skip = false,
  });

  Map<String, dynamic> toJson() =>
      _$SelectSpecializationRequestModelToJson(this);
}
