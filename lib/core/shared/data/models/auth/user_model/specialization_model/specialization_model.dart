import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'specialization_model.g.dart';

SpecializationModel specializationModelFromJson(String str) =>
    SpecializationModel.fromJson(json.decode(str));

String specializationModelToJson(SpecializationModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class SpecializationModel {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String? description;

  SpecializationModel({required this.id, required this.name, this.description});

  SpecializationModel copyWith({
    String? id,
    String? name,
    String? description,
  }) => SpecializationModel(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
  );

  factory SpecializationModel.fromJson(Map<String, dynamic> json) =>
      _$SpecializationModelFromJson(json);

  Map<String, dynamic> toJson() => _$SpecializationModelToJson(this);
}
