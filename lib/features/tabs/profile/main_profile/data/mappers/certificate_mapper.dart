import 'package:explaino/features/tabs/profile/main_profile/data/models/certificate_model.dart';
import 'package:explaino/features/tabs/profile/main_profile/domain/entities/response/certificate_entity.dart';

extension CertificateMapper on CertificateModel {
  CertificateEntity toEntity() {
    return CertificateEntity(
      id: id,
      title: title,
      issuer: issuer,
      issueDate: issueDate,
      certificateUrl: certificateUrl,
      certificateFileUrl: certificateFileUrl,
    );
  }
}
