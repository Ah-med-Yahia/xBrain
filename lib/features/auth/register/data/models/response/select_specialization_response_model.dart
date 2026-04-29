import 'package:explaino/core/shared/data/models/auth/user_model/specialization_model/specialization_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'select_specialization_response_model.g.dart';

SelectSpecializationResponseModel selectSpecializationResponseModelFromJson(
  String str,
) => SelectSpecializationResponseModel.fromJson(json.decode(str));

@JsonSerializable()
class SelectSpecializationResponseModel {
  @JsonKey(name: 'specialization_form_completed_at')
  final DateTime specializationFormCompletedAt;
  @JsonKey(name: 'specializations')
  final List<SpecializationModel> specializations;

  SelectSpecializationResponseModel({
    required this.specializationFormCompletedAt,
    required this.specializations,
  });

  factory SelectSpecializationResponseModel.fromJson(
    Map<String, dynamic> json,
  ) => _$SelectSpecializationResponseModelFromJson(json);
}
