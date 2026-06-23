import 'package:explaino/features/tabs/profile/main_profile/data/mappers/certificate_mapper.dart';
import 'package:explaino/features/tabs/profile/main_profile/data/models/response/get_certificates_response_model.dart';
import 'package:explaino/features/tabs/profile/main_profile/domain/entities/response/get_certificates_respone_entity.dart';

extension GetCertificatesResponseMapper on GetCertificatesResponseModel {
  GetCertificatesResponseEntity toEntity() {
    return GetCertificatesResponseEntity(
      count: count,
      next: next,
      previous: previous,
      results: results.map((e) => e.toEntity()).toList(),
    );
  }
}
