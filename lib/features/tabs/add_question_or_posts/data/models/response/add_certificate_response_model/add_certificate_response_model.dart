import 'package:json_annotation/json_annotation.dart';

part 'add_certificate_response_model.g.dart';

@JsonSerializable()
class AddCertificateResponseModel {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'issuer')
  final String issuer;
  @JsonKey(name: 'issue_date')
  final DateTime issueDate;
  @JsonKey(name: 'certificate_url')
  final String certificateUrl;
  @JsonKey(name: 'certificate_file_url')
  final String certificateFileUrl;

  AddCertificateResponseModel({
    required this.id,
    required this.title,
    required this.issuer,
    required this.issueDate,
    required this.certificateUrl,
    required this.certificateFileUrl,
  });

  factory AddCertificateResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AddCertificateResponseModelFromJson(json);
}
