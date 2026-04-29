import 'package:explaino/core/shared/data/mappers/auth/user_mapper.dart';
import 'package:explaino/features/auth/register/data/models/response/get_specializations_response_model.dart';
import 'package:explaino/features/auth/register/domain/entities/response/get_specializations_response_entity.dart';

extension GetSpecializationsResponseMapper on GetSpecializationsResponseModel {
  GetSpecializationsResponseEntity toEntity() {
    return GetSpecializationsResponseEntity(
      count: count,
      specializations: results.map((e) => e.toEntity()).toList(),
    );
  }
}
