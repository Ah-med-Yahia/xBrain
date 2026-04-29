import 'package:explaino/core/shared/data/models/auth/user_model/specialization_model/specialization_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'get_specializations_response_model.g.dart';

GetSpecializationsResponseModel getSpecializationsResponseModelFromJson(
  String str,
) => GetSpecializationsResponseModel.fromJson(json.decode(str));

@JsonSerializable()
class GetSpecializationsResponseModel {
  @JsonKey(name: 'count')
  final int count;
  @JsonKey(name: 'results')
  final List<SpecializationModel> results;

  GetSpecializationsResponseModel({required this.count, required this.results});

  factory GetSpecializationsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetSpecializationsResponseModelFromJson(json);
}
