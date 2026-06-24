import 'package:explaino/features/tabs/add_question_or_posts/data/models/request/add_certificate_request_model.dart';
import 'package:explaino/features/tabs/add_question_or_posts/domain/entities/request/add_certificate_request_entity.dart';

extension AddCertificateRequestMapper on AddCertificateRequestEntity {
  AddCertificateRequestModel toModel() {
    return AddCertificateRequestModel(
      title: title,
      issuer: issuer,
      issueDate: issueDate,
      certificateUrl: certificateUrl,
      certificateFile: certificateFile,
    );
  }
}
